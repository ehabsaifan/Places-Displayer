//
//  Place.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import SwiftyJSON

struct Place: CustomStringConvertible {
    
    var description: String {
        let text = "Address: \(self.formattedAddress ?? ""),\nPlace id: \(self.placeID ?? ""),\nLocation: \(self.location?.lat ?? 0), \(self.location?.lng ?? 0)"
        return text
    }
    
    var formattedAddress: String?
    var placeID: String?
    var location: (lat: Double?, lng: Double?)?
    
    
    init(info: JSON) {
        self.formattedAddress = info[FORMATTED_ADDRESS].string
        self.placeID = info[PLACE_ID].string
        if let location = (info[GEOMETRY].dictionary)?[LOCATION] {
            self.location = (lat: location[LAT].double, lng: location[LNG].double)
        }
    }
    
    
}

