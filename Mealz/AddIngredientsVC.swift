//
//  AddIngredientsVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/30/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class AddIngredientsVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var addIngredientsTextView: UITextView!
    
    @IBAction func saveIngredients(sender: UIBarButtonItem) {
        var ingredients = addIngredientsTextView.text!
        ING = ingredients
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addIngredientsTextView.text = ING
        addIngredientsTextView.delegate = self
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
}
