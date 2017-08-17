//
//  PlaceTableViewCell.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var httpsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //To keep track of the current image displayed
    //to eleminate image flickiring
    var imageURL = ""
    
    var place: Place? {
        didSet {
            if let place = self.place {
                self.updateUI(place: place)
            }// end if let
        }
    }
   
    private func updateUI(place: Place) {
        self.descriptionLabel?.text  = "Description: \(place.descreption ?? "N/A")"
        self.apiLabel?.text = "API: \(place.api ?? "Unkown")"
        self.httpsLabel?.text = "HTTPS: \(place.isHTTPS)"
        self.fechImage()
    }
    
    //Set default image
    //Fetch Image from cash if existed
    //Check if the image belongs to the cell that are currently displayed
    private func fechImage(){
        self.avatar?.image = UIImage(named: "defaultImage")
        guard let path = self.place?.link, let id = self.place?.api else{
            return
        }
        self.imageURL = path
        let cashPath = ImageManager.generateImageName(name: "\(id)")
        self.activityIndicator.startAnimating()
        ImageManager.getImage(path: path, cashPath: cashPath) { (path, image, error) in
            self.activityIndicator.stopAnimating()
            guard let image = image else{
                return
            }
            if self.imageURL == path {
                self.avatar?.image = image
            }
        }// end getImage
    }//end fetchImage

}
