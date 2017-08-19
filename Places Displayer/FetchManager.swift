//
//  FetchManager.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import SwiftyJSON

class FetchManager: NSObject {
   
    var placesList = [Place]()
    
    static var shared = FetchManager()
        
    override init(){
        super.init()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func getPlaces(searchText: String, completion: successResponse) {
        let query = self.shared.getQuery(searchText: searchText)
        NetworkManager.getPlaces(query: query, params: nil) { (json, error) in
            guard let error = error else{
                if let jsonList = json?["entries"].arrayValue {
                    self.shared.placesList = jsonList.map({Place(info: $0)})
                }
                if let completion = completion {
                    completion(true, nil)
                }
                FetchManager.shared.postNotification(notification: CustomNotification.EntriesHasBeenFetched)
                return
            }
            
            if let completion = completion {
                completion(false, error)
            }
        }
    }// end class func
    
    private func getQuery(searchText: String) -> String{
        var query = "json?query=\(searchText)"
        if let coordinates = LocationManager.currentManager.currentLocation {
            let lat = coordinates.latitude
            let lng = coordinates.longitude
            let radius = MAX_RADIUS
            query = query + "&location=\(lat),\(lng)&radius\(radius)"
            
        }
        query = query + "&key=\(API_KEY)"
        return query
    }
    
    private func postNotification(notification: CustomNotification) {
        let notificationCenter = NotificationCenter.default
        let notificationObj = Notification(name: Notification.Name(rawValue: "\(notification)"))
        notificationCenter.post(notificationObj)
    }
}

