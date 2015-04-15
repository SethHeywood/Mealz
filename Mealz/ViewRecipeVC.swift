//
//  ViewRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/30/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class ViewRecipeVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var readyTimeLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var directionsTextView: UITextView!
    
    var row: Int!
    var hour: Int!
    var min: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populate()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadView:",name:"ViewRecipe", object: nil)
    }

    
    func loadView(notification: NSNotification){
        populate()
    }
    
    
    func populate() {
        titleLabel.text = recipeBook.recipes[row].title
        servingsLabel.text = NSString(format: "%d servings", recipeBook.recipes[row].yield) as String
        
        hour = recipeBook.recipes[row].cookHour
        min = recipeBook.recipes[row].cookMin
        if (hour == 0){
            if (min == 0){
                cookTimeLabel.text = "Instant"
            }
            else {
                cookTimeLabel.text = NSString(format: "%d minutes", min) as String
            }
        }
        else {
            if (min == 0){
                cookTimeLabel.text = NSString(format: "%d hours", hour) as String
            }
            else {
                cookTimeLabel.text = NSString(format: "%d hours %d minutes", hour, min) as String
            }
        }
        
        hour = recipeBook.recipes[row].prepHour
        min = recipeBook.recipes[row].prepMin
        if (hour == 0){
            if (min == 0){
                prepTimeLabel.text = "Instant"
            }
            else {
                prepTimeLabel.text = NSString(format: "%d minutes", min) as String
            }
        }
        else {
            if (min == 0){
                prepTimeLabel.text = NSString(format: "%d hours", hour) as String
            }
            else {
                prepTimeLabel.text = NSString(format: "%d hours %d minutes", hour, min) as String
            }
        }
        
        hour = recipeBook.recipes[row].readyHour
        min = recipeBook.recipes[row].readyMin
        if (hour == 0){
            if (min == 0){
                readyTimeLabel.text = "Instant"
            }
            else {
                readyTimeLabel.text = NSString(format: "%d minutes", min) as String
            }
        }
        else {
            if (min == 0){
                readyTimeLabel.text = NSString(format: "%d hours", hour) as String
            }
            else {
                readyTimeLabel.text = NSString(format: "%d hours %d minutes", hour, min) as String
            }
        }
        
        
        ingredientsTextView.text = recipeBook.recipes[row].ingredients
        directionsTextView.text = recipeBook.recipes[row].directions
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "editRecipe") {
            let nextVC:EditRecipeVC = segue.destinationViewController as! EditRecipeVC
            nextVC.row = row
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
