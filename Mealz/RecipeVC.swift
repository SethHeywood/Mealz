//
//  RecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class RecipeVC: UITableViewController, UITableViewDataSource {

    
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeBook.loadRecipes()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"RecipeTable", object: nil)
    }

    
    func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeBook.recipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: RecipeCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! RecipeCell
        let item = recipeBook.recipes[indexPath.row]
        
        cell.recipeTitle.text = item.title
        cell.readyTime.text = NSString(format: "%d hours %d minutes", item.readyHour, item.readyMin) as String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            recipeBook.deleteRecipe(indexPath.row)
            
            self.tableView.reloadData()
            recipeBook.saveRecipeToParse()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "viewRecipe") {
            let nextVC:ViewRecipeVC = segue.destinationViewController as! ViewRecipeVC
            nextVC.row = tableView.indexPathForSelectedRow()?.row
        }
    }    

}
