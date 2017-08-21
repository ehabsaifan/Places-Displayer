//
//  PlaceTableViewCell.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    var place: Place? {
        didSet {
            if let place = self.place {
                self.updateUI(place: place)
            }// end if let
        }
    }

    private func updateUI(place: Place) {
        self.name?.text  = "\(place.name ?? "N/A")"
    }
}
