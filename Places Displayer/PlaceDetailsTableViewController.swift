//
//  PlaceDetailsTableViewController.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/20/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import MBProgressHUD

class PlaceDetailsTableViewController: UITableViewController {
    
    var place: Place?
    
    @IBOutlet weak var exitBton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var operationHoursLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 500
        
        self.fetchDetails()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func dismissPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        self.callPlacePhoneNumber()
    }
    
    private func callPlacePhoneNumber(){
        if let phoneNumber = self.place?.interPhoneNum {
            
            let phoneLink = "tel://\(phoneNumber.removeAllWhiteSpaces)"
            if let url = URL(string: phoneLink){
                UIApplication.shared.open(url)
            }
        }
    }

    private func updateUI(){
        
        self.exitBton?.makeCircular()
        
        self.titleLabel.text = self.place?.name ?? "No name available"
        let count = self.place?.reviews.count ?? 0
        self.reviewsCountLabel?.text = "\(String(describing: count))"
        self.operationHoursLabel?.text = self.place?.hours
        
        if let rating = self.place?.rating {
            self.ratingValueLabel.text = "(\(rating))"
            let filledStarCount = Int(rating)
            let emptyStarCount = 5-filledStarCount
            var rating = String(repeating: "✭", count: filledStarCount)
            rating = rating + String(repeating: "✩", count: emptyStarCount)
            self.ratingCountLabel?.text = rating
        }
        
        self.updateCallButton()
        self.tableView.reloadData()
    }
    
    private func updateCallButton() {
        if let phoneNumber = self.place?.interPhoneNum {
            self.phoneButton.makeCircularEdges(radius: 2)
            self.phoneButton.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 6)
            self.phoneButton.setTitle("Call: \(phoneNumber)", for: .normal)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 273
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    private func fetchDetails() {
        guard let placeID = self.place?.placeID else {
            let message = "Sorry we could not get your request details at the moment!\nPlease try again later"
            self.displayMessageToUser(text: message)
            return
        }
        
        ProgressHUD.displayProgress(text: "Fetching Place Details", fromView: self.view)
        FetchManager.getDetails(for: placeID) { [unowned self] (place, error) in
            ProgressHUD.hidProgress(fromView: self.view)
            guard let place = place else{
                if let error = error {
                    self.displayMessageToUser(text: error.localizedDescription)
                }
                return
            }
            self.place = place
            self.updateUI()
        }
    }
    
    private func displayMessageToUser(text: String) {
        ProgressHUD.displayMessage(text: text, fromView: self.view, mode: .determinateHorizontalBar, delayTime: 1.5){
            self.dismissPressed(self)
        }
    }
    
}
