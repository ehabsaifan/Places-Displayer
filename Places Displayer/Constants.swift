//
//  Constants.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//



/*
    ****************************
        JSON Constants
    ****************************
*/

let PREDICTIONS = "predictions"
let NAME = "name"
let STRUCTURED_FORMATTING = "structured_formatting"
let MAIN_TEXT = "main_text"
let PLACE_ID = "place_id"

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


/// Represents the status of the request comming back from the 'autocomplete' api
///
/// - OK: indicates that no errors occurred and at least one result was returned.
/// - ZERO_RESULTS: indicates that the search was successful but returned no results. This may occur if the search was passed a bounds in a remote location.
/// - OVER_QUERY_LIMIT: indicates that you are over your quota.
/// - REQUEST_DENIED: indicates that your request was denied, generally because of lack of an invalid key
/// - INVALID_REQUEST: generally indicates that the input parameter is missing..
/// - Unknown: we are passing empty if the value from the server was nil
enum RequestStatus: String {
    case OK = "OK"
    case ZERO_RESULTS = "ZERO_RESULTS"
    case OVER_QUERY_LIMIT = "OVER_QUERY_LIMIT"
    case REQUEST_DENIED = "REQUEST_DENIED"
    case INVALID_REQUEST = "INVALID_REQUEST"
    case Unknown = ""
}
