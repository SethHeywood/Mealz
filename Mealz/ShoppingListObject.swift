//
//  ShoppingListObject.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import Foundation


class ShoppingListObject {
    
    var list = Array<String>()
    
    
    func addToShoppingList(items: String) {
        
        var newItems = split(items) {$0 == "\n"}
        
        for (var i = 0; i < newItems.count; i++) {
            list.append(newItems[i])
        }
    }
    
    
    
    func removeShoppingListItems(item: String){
        
        
        
    }
    
}