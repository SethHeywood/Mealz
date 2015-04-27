//
//  ShoppingListVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class ShoppingListVC: UITableViewController, UITableViewDataSource {


    @IBOutlet var table: UITableView!

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func clearShoppingList(sender: UIBarButtonItem) {
        shoppingList.clearShoppingList()
        self.tableView.reloadData()
        shoppingList.saveShoppingListToParse()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ShoppingListCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ShoppingListCell
        let item = shoppingList.list[indexPath.row]
        
        cell.ingredientLabel.text = item
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            shoppingList.removeShoppingListItems(indexPath.row)
            self.tableView.reloadData()
            shoppingList.saveShoppingListToParse()
        }
    }
}
