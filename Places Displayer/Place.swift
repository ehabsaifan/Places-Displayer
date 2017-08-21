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
    
    var hours: String {
        var hoursText = ""
        for openHours in self.weekDays {
            hoursText = hoursText + openHours + "\n"
        }
        return hoursText
    }
    
    var name: String?
    var formattedAddress: String?
    var placeID: String?
    var interPhoneNum: String?
    var weekDays = ["N/A"]
    var rating: Double? 
    var reviews = [JSON]()
    var location: (lat: Double?, lng: Double?)?
    
    init(info: JSON, isDetailsEndPoint: Bool = false) {
        
        if !isDetailsEndPoint {
            let structuredFormatting = info[STRUCTURED_FORMATTING].dictionary
            self.name = structuredFormatting?[MAIN_TEXT]?.string
        }else {
            self.name = info[NAME].string
        }
        self.formattedAddress = info[FORMATTED_ADDRESS].string
        self.placeID = info[PLACE_ID].string
        self.interPhoneNum = info[INTER_PHONE].string
        self.rating = info[RATING].double
        
        if let reviews = info[REVIEWS].array {
            self.reviews = reviews
        }
        
        let openings = info[OPENING_HOURS].dictionary
        if let array = openings?[WEEK_DAY]?.arrayObject {
            self.weekDays = array as! [String]
        }
        
        let location = info[GEOMETRY][LOCATON].dictionary
        self.location = (lat: location?["lat"]?.double, lng: location?["lat"]?.double)
    }
    
}

