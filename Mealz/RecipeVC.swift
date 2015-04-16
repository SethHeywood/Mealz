//
//  RecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit


class RecipeVC: UITableViewController, UITableViewDataSource, UISearchResultsUpdating {
    
    
    @IBOutlet var table: UITableView!
    var recipeSearchController = UISearchController()
    var searchResults:Array<Recipe> = Array<Recipe>(){
        didSet  {self.table.reloadData()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        self.recipeSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.table.tableHeaderView = controller.searchBar
            self.table.contentOffset = CGPointMake(0, CGRectGetHeight(controller.searchBar.frame))
            controller.searchBar.searchBarStyle = .Minimal
            return controller
        })()
        
        recipeBook.loadRecipes()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"RecipeTable", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.table.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // Set searchString equal to what's typed into the searchbar
        var searchString: String = searchController.searchBar.text.lowercaseString
        
        self.searchResults.removeAll(keepCapacity: false)
        searchResults = recipeBook.recipes.filter({
            (element: Recipe) in
            (element.title.lowercaseString as NSString).containsString(searchString)
        })
    }
    
    
    func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (recipeSearchController.active) {
            return searchResults.count
        } else {
            return recipeBook.recipes.count
        }
    }
    
    //alphabetize
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RecipeCell = tableView.dequeueReusableCellWithIdentifier("Cell") as RecipeCell
        if (self.recipeSearchController.active) {
            if indexPath.row < searchResults.count {
                let item = searchResults[indexPath.row]
                
                cell.recipeTitle?.text! = item.title
                cell.readyTime?.text! = "\(item.readyHour) hours \(item.readyMin) minutes"

                return cell
            }
        } else {
            if indexPath.row < recipeBook.recipes.count {

                let item = recipeBook.recipes[indexPath.row]
                
                cell.recipeTitle?.text! = item.title
                cell.readyTime?.text! = "\(item.readyHour) hours \(item.readyMin) minutes"
            
                return cell
            }
        }
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
            let nextVC:ViewRecipeVC = segue.destinationViewController as ViewRecipeVC
            nextVC.row = tableView.indexPathForSelectedRow()?.row
        }
    }
    
}
