//
//  SearchViewController.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/19/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var placesTableView: UITableView!
    
    private var places = [Place](){
        didSet{
            self.placesTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placesTableView.isScrollEnabled = true
        self.placesTableView.isHidden = true
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
        if let text = textField.text {
            self.placesTableView.isHidden = false
            self.searchPlacesWith(substring: text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchPlacesWith(substring: substring)
        
        return true
    }
    
    func searchPlacesWith(substring: String){
        
        print(substring)
        
        FetchManager.getPlaces(searchText: substring, completion: nil)

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
        
        print(indexPath.row)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}
