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
        let text = "API: \(self.api ?? ""),\nAuth: \(self.auth ?? ""),\nDescription: \(self.descreption ?? ""),\nHTTPS: \(self.isHTTPS),\nLink: \(self.link ?? ""),\nSection: \(self.section ?? "")"
        return text
    }
    
    let API = "API"                             // "StackExchange",
    let AUTH = "Auth"                           // "OAuth",
    let DESCREPTION = "Description"             // "Q&A forum for developers",
    let HTTPS = "HTTPS"                         // true,
    let LINK = "Link"                           // "https://api.stackexchange.com/",
    let SECTION = "Section"                     // "Development"
    
    var api: String?
    var auth: String?
    var descreption: String?
    var https: Bool?
    var link: String?
    var section: String?
    
    var isHTTPS: String {
        switch self.https {
        case (let yes) where yes == true:
            return "Yes"
        case (let no) where no == false:
            return "False"
        default:
            return "Unknown"
        }
    }
    
    init(info: JSON) {
        self.api = info[API].string
        self.auth = info[AUTH].string
        self.descreption = info[DESCREPTION].string
        self.https = info[HTTPS].bool
        self.link = info[LINK].string
        self.section = info[SECTION].string
    }
    
    
}

