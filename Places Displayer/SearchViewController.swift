//
//  SearchViewController.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/19/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    private var isKeyboardDisplayed = false
    
    private var places = [Place](){
        didSet{
            self.placesTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placesTableView.isScrollEnabled = true
        self.placesTableView.isHidden = true
        self.placesTableView.rowHeight = 50
        self.placesTableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTableViewHeight), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTableViewHeight), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    /// Toggles the height of the tableView
    /// based on the keyboard notification and the height of the 
    /// keyboard
    /// - Parameter notification: Notification object the has the keyboard info
    @objc private func adjustTableViewHeight(notification: NSNotification) {
        
        var keyboardHeight:CGFloat = 0
        
        //get height
        if !self.isKeyboardDisplayed {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardSize.height
            }
        }
        
        //animate constraint
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.tableViewBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        //toggle the status to keep track of keyboard appearnece 
        self.isKeyboardDisplayed = !self.isKeyboardDisplayed
    }

   func hideKeyboard(sender: AnyObject) {
        self.searchTextField.resignFirstResponder()
    }
    
    // Called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboard(sender: textField)
        return true
    }
    
    func showKeyboard(){
        self.searchTextField.becomeFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text?.trim {
            self.placesTableView.isHidden = false
            self.searchPlacesWith(substring: text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string).trim
        self.searchPlacesWith(substring: substring)
        
        return true
    }
    
    func searchPlacesWith(substring: String){
       
        guard !substring.isEmpty else {
            return
        }
        
        ProgressHUD.displayProgress(text: "Fetching data from server", fromView: self.view)
        FetchManager.getPlaces(searchText: substring) { (places, error) in
            ProgressHUD.hidProgress(fromView: self.view)
            guard error == nil else {
                ProgressHUD.displayMessage(text: error?.localizedDescription, fromView: self.view, mode: .determinateHorizontalBar, delayTime: 1.5, completion: nil)
                return
            }
            
            if let places = places {
                self.places = places
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.places.count
        return  count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier: CellType = .placeCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier)", for: indexPath) as! PlaceTableViewCell
        cell.place = self.places[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "Place Details", sender: indexPath.row)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Place Details" {
            let controller = segue.destination as! PlaceDetailsTableViewController
            if let row = sender as? Int {
                controller.place = self.places[row]
            }
        }
    }

}
