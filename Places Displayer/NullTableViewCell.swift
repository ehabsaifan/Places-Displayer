//
//  NullTableViewCell.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class NullTableViewCell: UITableViewCell {

    @IBOutlet weak var upperConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.calculateUpperConstraintValue()
    }
    
    private func calculateUpperConstraintValue(){
        let entryTable = PlacesTableViewController()
        if let height = entryTable.tableViewHeight {
            self.upperConstraint.constant = height/2
        }
    }

}
