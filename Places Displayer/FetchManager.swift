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
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { (not) -> Void in
                FetchManager.getPlaces(completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func getPlaces(completion: successResponse) {
        NetworkManager.getPlaces(params: nil) { (json, error) in
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
    
    private func postNotification(notification: CustomNotification) {
        let notificationCenter = NotificationCenter.default
        let notificationObj = Notification(name: Notification.Name(rawValue: "\(notification)"))
        notificationCenter.post(notificationObj)
    }
}

