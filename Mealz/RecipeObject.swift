//
//  RecipeObject.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import Foundation

var ING = String()
var DIR = String()
var recipeBook = RecipeObject()

struct Recipe {
    var title: String
    var yield: Int
    var prepHour: Int
    var prepMin: Int
    var cookHour: Int
    var cookMin: Int
    var readyHour: Int
    var readyMin: Int
    var ingredients: String
    var directions: String
}


class RecipeObject {
    
    var recipes = Array<Recipe>()
    
    // var to store the currently logged in user
    var currentUser = PFUser.currentUser()
    
    func addRecipe(ttl: String, yld: Int, pHour: Int, pMin: Int, cHour: Int, cMin: Int, rHour: Int, rMin: Int, ingred: String, direct: String){
        
        var newRecipe = Recipe(title: ttl, yield: yld, prepHour: pHour, prepMin: pMin, cookHour: cHour, cookMin: cMin, readyHour: rHour, readyMin: rMin, ingredients: ingred, directions: direct)
        
        recipes.append(newRecipe)
    }
    
    func editRecipe(selection: Int, ttl: String, yld: Int, pHour: Int, pMin: Int, cHour: Int, cMin: Int, rHour: Int, rMin: Int){
     
        recipes[selection].title = ttl
        recipes[selection].yield = yld
        recipes[selection].prepHour = pHour
        recipes[selection].prepMin = pMin
        recipes[selection].cookHour = cHour
        recipes[selection].cookMin = cMin
        recipes[selection].readyHour = rHour
        recipes[selection].readyMin = rMin
    }
    
    func deleteRecipe(selection: Int){
        recipes.removeAtIndex(selection)
    }
    
    func loadRecipes() {
        var query = PFQuery(className: "Recipes")
        
        /*************************************************************************************/
        // This should be the only line needed to filter the recipes loaded to only those
        // belonging to the currently logged in user. I am unable to save recipes though,
        // so have not been able to check
        
        query.whereKey("owner", equalTo: self.currentUser.objectId)
        /*************************************************************************************/
        
        query.getObjectInBackgroundWithId("0h4bmjUfZv") {
            (recipe: PFObject?, error: NSError?) -> Void in
            if error == nil {
                var pTitle = recipe!.objectForKey("title") as [String]
                var pYield = recipe!.objectForKey("yield") as [Int]
                var pPrepHour = recipe!.objectForKey("prepHour") as [Int]
                var pPrepMin = recipe!.objectForKey("prepMin") as [Int]
                var pCookHour = recipe!.objectForKey("cookHour") as [Int]
                var pCookMin = recipe!.objectForKey("cookMin") as [Int]
                var pReadyHour = recipe!.objectForKey("readyHour") as [Int]
                var pReadyMin = recipe!.objectForKey("readyMin") as [Int]
                var pIngredients = recipe!.objectForKey("ingredients") as [String]
                var pDirections = recipe!.objectForKey("directions") as [String]
                
                
                for var i = 0; i < pDirections.count; i++ {
                    recipeBook.addRecipe(pTitle[i], yld: pYield[i], pHour: pPrepHour[i], pMin: pPrepMin[i], cHour: pCookHour[i], cMin: pCookMin[i], rHour: pReadyHour[i], rMin: pReadyMin[i], ingred: pIngredients[i], direct: pDirections[i])
                }
                NSNotificationCenter.defaultCenter().postNotificationName("RecipeTable", object: nil)
            }
            else {
                NSLog("%@", error!)
            }
        }
    }
    
    
    func saveRecipeToParse() {
        /*************************************************************************************/
        // I am unable to save recipes. I am not sure what the id being used below is exactly
        // but assume its specific to the way Parse was set up. Either way, all that needs to
        // be added here, is for the currently logged in users id to be saved as a field in
        // the Recipes class on parse. Each recipe should have this field and then can be filtered
        // by it when loading them. The line would be something like what is below...
        
        // query.whereKey("owner", equalTo: self.currentUser.objectId)
        /*************************************************************************************/
        
        //setObject(pTitle, forKey: "title")
        var query = PFQuery(className: "Recipes")
        
        query.getObjectInBackgroundWithId("0h4bmjUfZv") {
            (query: PFObject?, error: NSError?) -> Void in
            if error == nil {
                var pTitle = [String]()
                var pYield = [Int]()
                var pPrepHour = [Int]()
                var pPrepMin = [Int]()
                var pCookHour = [Int]()
                var pCookMin = [Int]()
                var pReadyHour = [Int]()
                var pReadyMin = [Int]()
                var pIngredients = [String]()
                var pDirections = [String]()
                
                for var i = 0; i < recipeBook.recipes.count; i++ {
                    pTitle.append(recipeBook.recipes[i].title)
                    pYield.append(recipeBook.recipes[i].yield)
                    pPrepHour.append(recipeBook.recipes[i].prepHour)
                    pPrepMin.append(recipeBook.recipes[i].prepMin)
                    pCookHour.append(recipeBook.recipes[i].cookHour)
                    pCookMin.append(recipeBook.recipes[i].cookMin)
                    pReadyHour.append(recipeBook.recipes[i].readyHour)
                    pReadyMin.append(recipeBook.recipes[i].readyMin)
                    pIngredients.append(recipeBook.recipes[i].ingredients)
                    pDirections.append(recipeBook.recipes[i].directions)
                }
                
                query!.setObject(pTitle, forKey: "title")
                query!.setObject(pYield, forKey: "yield")
                query!.setObject(pPrepHour, forKey: "prepHour")
                query!.setObject(pPrepMin, forKey: "prepMin")
                query!.setObject(pCookHour, forKey: "cookHour")
                query!.setObject(pCookMin, forKey: "cookMin")
                query!.setObject(pReadyHour, forKey: "readyHour")
                query!.setObject(pReadyMin, forKey: "readyMin")
                query!.setObject(pIngredients, forKey: "ingredients")
                query!.setObject(pDirections, forKey: "directions")
                
                query!.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success == true) {
                        NSLog("Object created with id: \(query!.objectId)")
                    } else {
                        NSLog("%@", error!)
                    }
                }
            }
            else{
                NSLog("%@", error!)
            }
        }
    }

    
    // converts a string to an integer
    func stringToInt(val: String) -> Int {
        return (val as NSString).integerValue
    }
    
}


