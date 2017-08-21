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
        let text = "Name: \(self.name ?? ""),\nPlace id: \(self.placeID ?? "")"
        return text
    }
    
    var name: String?
    var formattedAddress: String?
    var placeID: String?
    var location: (lat: Double?, lng: Double?)?
    
    init(info: JSON) {
        let structuredFormatting = info[STRUCTURED_FORMATTING].dictionary
        self.name = structuredFormatting?[MAIN_TEXT]?.string
        self.placeID = info[PLACE_ID].string
    }
    
    
}

