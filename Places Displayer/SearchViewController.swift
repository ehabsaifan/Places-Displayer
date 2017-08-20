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
    
    // Gesture Recognizer func called when press outside textfields
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
            self.searchAutocompleteEntriesWithSubstring(substring: text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWithSubstring(substring: substring)
        
        return true     // not sure about this - could be false
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String){
        
        //self.places.removeAll(keepingCapacity: false)
        
        print(substring)
        
        FetchManager.getPlaces(searchText: substring, completion: <#T##successResponse##successResponse##(Bool, NSError?) -> Void#>)
//        if !self.customerIDs.isEmpty {
//            
//            for curString in self.customerIDs {
//                let myString:NSString! = curString as NSString
//                
//                let substringRange :NSRange! = myString.rangeOfString(substring, options: .CaseInsensitiveSearch)
//                
//                if (substringRange.location  == 0) {
//                    self.places.append(curString)
//                    
//                }// end if
//            }// end for
//            self.placesTableView.reloadData()
//        }// end if
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
//        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)!
//        self.searchTextField.text = selectedCell.textLabel!.text?.uppercased()
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if(segue.identifier == CheckInDetailSegue){
        //            if let controller = segue.destinationViewController as? SLCheckInDetailViewController{
        //                controller.customerID = self.textInput?.uppercaseString
        //                controller.isCarrierCheckin = self.isCarrierCheckin
        //            }
        //        } else if let VC = segue.destinationViewController as? ScannerViewController where segue.identifier == ShowScannerSegue {
        //            VC.delegate = self
        //        }// end else
    }

}
