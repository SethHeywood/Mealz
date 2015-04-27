//
//  ShoppingListObject.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import Foundation

var shoppingList = ShoppingListObject()


class ShoppingListObject{
    
    var list = Array<String>()
    
    init(){
        loadShoppingListFromParse()
    }
    
    func addToShoppingList(items: String) {
        
        var newItems = split(items) {$0 == "\n"}
        
        for (var i = 0; i < newItems.count; i++) {
            list.append(newItems[i])
        }
    }
    
    
    func removeShoppingListItems(selection: Int){
        list.removeAtIndex(selection)  
    }
    
    
    func clearShoppingList(){
        list.removeAll(keepCapacity: false)
    }
    
    
    
    
    func loadShoppingListFromParse() {
        
        var query = PFQuery(className: "ShoppingList")
        query.getObjectInBackgroundWithId("sYL4nZ873m") {
            (cart: PFObject?, error: NSError?) -> Void in
            if error == nil {
                var shoppingCart = cart!.objectForKey("shoppingCart") as! [String]
                
                shoppingList.list = shoppingCart
                
                NSNotificationCenter.defaultCenter().postNotificationName("Shopping Cart", object: nil)
            }
            else {
                NSLog("%@", error!)
            }
        }
        
    }
    
    
    
    
    func saveShoppingListToParse() {
   
        var query = PFQuery(className: "ShoppingList")
        
        query.getObjectInBackgroundWithId("sYL4nZ873m") {
            (query: PFObject?, error: NSError?) -> Void in
            if error == nil {
                var shoppingCart = [String]()
 
                for (var i = 0; i < shoppingList.list.count; i++){
                    shoppingCart.append(shoppingList.list[i])
                }
                
                query!.setObject(shoppingCart, forKey: "shoppingCart")
   
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

    
    
}