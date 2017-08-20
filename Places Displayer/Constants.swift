//
//  Constants.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//



/*
    ****************************
        Entries Constants
    ****************************
*/

let FORMATTED_ADDRESS = "formatted_address" // "123 Main St, Watertown, MA 02472, USA",
let GEOMETRY = "geometry"                   // {"location": {}},
let LOCATION = "location"                   // "location": {lat: 42.3675294, lng: -71.18696609999999}
let LAT = "lat"                             // lat: 42.3675294
let LNG = "lng"                             // lng: -71.18696609999999
let PLACE_ID = "place_id"                   // "ChIJ3aqMmgZ444kRgD5YevF7_tc"

let MAX_RADIUS = 50_000
//TODO: Add to user settings
let API_KEY = "AIzaSyDw1_GUBq-9qxrgf4Z3v6feyOnlBTT05KU"


/*
 ****************************
    Enums
 ****************************
 */

enum CustomNotification {
    case EntriesHasBeenFetched
}

enum CellType{
    case placeCell
}
