//
//  EditRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class EditRecipeVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var pHourTF: UITextField!
    @IBOutlet weak var pMinTF: UITextField!
    @IBOutlet weak var cHourTF: UITextField!
    @IBOutlet weak var cMinTF: UITextField!

    var row: Int!


    @IBAction func saveRecipeBtn(sender: UIBarButtonItem) {
    
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(pHourTF.text!)
        var prepMin = recipeBook.stringToInt(pMinTF.text!)
        var cookHours = recipeBook.stringToInt(cHourTF.text!)
        var cookMin = recipeBook.stringToInt(cMinTF.text!)
    
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
    
        recipeBook.editRecipe(row, ttl: title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin)
    
        recipeBook.saveRecipeToParse()
        
        ING = ""
        DIR = ""
        recipeBook.saveRecipeToParse()  

        NSNotificationCenter.defaultCenter().postNotificationName("ViewRecipe", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("RecipeTable", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.text = recipeBook.recipes[row].title
        yieldTF.text = String(recipeBook.recipes[row].yield)
        pHourTF.text = String(recipeBook.recipes[row].prepHour)
        pMinTF.text = String(recipeBook.recipes[row].prepMin)
        cHourTF.text = String(recipeBook.recipes[row].cookHour)
        cMinTF.text = String(recipeBook.recipes[row].cookMin)
        
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "editIngredients") {
            let nextVC:EditIngredientsVC = segue.destinationViewController as EditIngredientsVC
            nextVC.row = row
        }
        else if (segue.identifier == "editDirections") {
            let nextVC:EditDirectionsVC = segue.destinationViewController as EditDirectionsVC
            nextVC.row = row
        }
    }
    

}
