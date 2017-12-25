//
//  ViewController.swift
//  todo
//
//  Created by Peter on 23.05.17.
//  Copyright (c) 2017 Peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // reference to Item.swift
    
    var item: Item?
    
    @IBAction func cancel(sender: UIBarButtonItem) {
    let isInAddMode = presentingViewController is UINavigationController
        if isInAddMode {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    //connect UIs to the code
    
    @IBOutlet weak var nameTextField: UITextView!
   
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    //converting date to string to show in table cell
    
    func dateToString (date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: date as Date)
    }
    
    //converting string from table cell to edit date

    func stringToDate (string: String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.date(from: string)! as NSDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            let name = nameTextField.text ?? ""
            let date = dateToString (date: myDatePicker.date as NSDate)
            item = Item(name: name, date: date)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item {
            nameTextField.text = item.name
            // setting a date using our convert function stringToDate with item.date property
            myDatePicker.setDate(stringToDate(string: item.date) as Date!, animated: true)
        }
    }
    
    //to hide keyboard when touch out of
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
