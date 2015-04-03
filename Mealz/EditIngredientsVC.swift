//
//  EditIngredientsVC.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class EditIngredientsVC: UIViewController {

    @IBOutlet weak var editIngredientsTV: UITextView!
    var row: Int!
    
    @IBAction func saveIngredientsBtn(sender: UIBarButtonItem) {
        recipeBook.recipes[row].ingredients = editIngredientsTV.text!
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editIngredientsTV.text = recipeBook.recipes[row].ingredients
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
}
