//
//  ItemTableViewController.swift
//  todo
//
//  Created by Peter on 24.05.17.
//  Copyright (c) 2017 Peter. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
   var items = [Item]()
    
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        let scrViewCon = sender.source
        as? ViewController
        let item = scrViewCon?.item
        if (scrViewCon != nil &&
            item?.name != "" && item?.date != "") {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    items[selectedIndexPath.row] = item!
                    tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.none)
                }
                else {
                    //
                let newIndexPath = NSIndexPath(row: items.count, section: 0)
                items.append(item!)
                
                    tableView.insertRows(at: [newIndexPath as IndexPath], with: UITableViewRowAnimation.bottom)
                }
                //call save here (is it all for updating existing item's data? //refer sololearn's guide!
                saveItems()
        }
    }
    
    // to save items (reference to Item.swift)
    func saveItems() {
        let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
        if !isSaved {
            print("Failed to save items...")
        }
    }
    // to load items
    func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as?
        [Item]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        // load saved items
        if let savedItems = loadItems() {
            items += savedItems
        }
        
    }
    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 1
    //}
    //now use self.count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //general table view with cells
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath IndexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:IndexPath as IndexPath)
            as! ItemTableViewCell
        let item = items[IndexPath.row]
        cell.nameLabel.text = item.name //text from TextField
        cell.nameDate.text = item.date //date from DatePicker
        return cell
    }
    
    //to show edit viewcontroller when press the TableCell
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination
            as! ViewController
            if let selectedCell = sender
                as? ItemTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                    let selectedItem = items[indexPath.row]
                    detailVC.item = selectedItem
            }
        }
            // and also when pressing "+"
        else if segue.identifier == "AddItem" {
            
            }
    }
    
    //this is for deleting and call saveItems if any cell from table is deleted!!!
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            saveItems()
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }
    
    //to move rows at ItemTablweView
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let elementToMove = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(elementToMove, at: destinationIndexPath.row)
    }
    //allow moving rows
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    
}

