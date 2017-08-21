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
typealias PlaceResponse = ((_ Data : Place?, _ error : NSError?)->Void)?

class FetchManager: NSObject {
   
    ///To be used if needed by other ViewControllers in the future
    var placesList = [Place]()
    
    static var shared = FetchManager()
        
    override init(){
        super.init()
    }
    
    class func getPlaces(searchText: String, completion: PlacesResponse) {
        let query = self.shared.getPlacesQuery(searchText: searchText)
        NetworkManager.getPlaces(query: query, params: nil) { (json, error) in
            guard let error = error else{
                if let jsonList = json?[PREDICTIONS].arrayValue {
                    self.shared.placesList = jsonList.map({Place(info: $0)})
                }
                if let completion = completion {
                    completion(self.shared.placesList, nil)
                }
                return
            }
            
            if let completion = completion {
                completion(nil, error)
            }
        }
    }// end class func
    
    class func getDetails(for placeID: String, completion: PlaceResponse) {
        let query = self.shared.getDetailsQuery(placeID: placeID)
        NetworkManager.getDetails(for: query, params: nil) { (json, error) in
            guard let error = error else{
                if let json = json?[RESULT] {
                    let place = Place(info: json, isDetailsEndPoint: true)
                    if let completion = completion {
                        completion(place, nil)
                    }
                }
                return
            }
            
            if let completion = completion {
                completion(nil, error)
            }
        }
    }// end class func
    
    private func getPlacesQuery(searchText: String) -> String{
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

    private func getDetailsQuery(placeID: String) -> String {
        var query = "json?placeid=\(placeID)"
        query = query + "&key=\(API_KEY)"
        return query
    }
}

