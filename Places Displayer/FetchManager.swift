//
//  FetchManager.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias PlacesResponse = ((_ Data : [Place]?, _ error : NSError?)->Void)?

class FetchManager: NSObject {
   
    var placesList = [Place]()
    
    static var shared = FetchManager()
        
    override init(){
        super.init()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func getPlaces(searchText: String, completion: PlacesResponse) {
        let query = self.shared.getQuery(searchText: searchText)
        NetworkManager.getPlaces(query: query, params: nil) { (json, error) in
            guard let error = error else{
                if let jsonList = json?[PREDICTIONS].arrayValue {
                    self.shared.placesList = jsonList.map({Place(info: $0)})
                }
                if let completion = completion {
                    completion(self.shared.placesList, nil)
                }
                FetchManager.shared.postNotification(notification: CustomNotification.EntriesHasBeenFetched)
                return
            }
            
            if let completion = completion {
                completion(nil, error)
            }
        }
    }// end class func
    
    private func getQuery(searchText: String) -> String{
        let text = searchText.replacingOccurrences(of: " ", with: "+")
        var query = "json?input=\(text)"
        
        if let coordinates = LocationManager.currentManager.currentLocation {
            let lat = coordinates.latitude
            let lng = coordinates.longitude
            let radius = MAX_RADIUS
            query = query + "&location=\(lat),\(lng)&radius=\(radius)"
            
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

