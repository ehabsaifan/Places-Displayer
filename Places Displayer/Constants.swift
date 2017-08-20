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

let API = "API"                             //"StackExchange",
let AUTH = "Auth"                           // "OAuth",
let DESCREPTION = "Description"             //"Q&A forum for developers",
let HTTPS = "HTTPS"                         // true,
let LINK = "Link"                           // "https://api.stackexchange.com/",
let SECTION = "Section"                     // "Development"

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
