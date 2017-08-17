//
//  PlacesTableViewController.swift.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    private var refreshController = UIRefreshControl()
    
    //Helper variable used in NullTableViewCell
    var tableViewHeight: CGFloat? {
        return self.tableView?.frame.height
    }
    
    private var places = [Place](){
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRefreshController()
        self.tableView?.estimatedRowHeight = 90
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "\(CustomNotification.EntriesHasBeenFetched)"), object: nil, queue: OperationQueue.main) { (not) -> Void in
            self.places = FetchManager.shared.placesList
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func configureRefreshController() {
        self.tableView?.alwaysBounceVertical = true
        self.refreshController.tintColor = UIColor.lightGray
        self.refreshController.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        self.tableView?.addSubview(self.refreshController)
    }
    
    @objc private func fetchData(){
        FetchManager.getPlaces { (suceess, error) in
            self.refreshController.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = self.places.count
        return  (count != 0 ? count: 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.places.count
        let identifier: CellType = (count == 0 ? .nullCell: .placeCell)
        
        if count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier)", for: indexPath) as! PlaceTableViewCell
            cell.place = self.places[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier)", for: indexPath) as! NullTableViewCell
        
        return cell
    }

}
