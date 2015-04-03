//
//  EditDirectionsVC.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class EditDirectionsVC: UIViewController {

    @IBOutlet weak var editDirectionsTV: UITextView!
    var row: Int!
    
    @IBAction func saveDirectionsBtn(sender: UIBarButtonItem) {
        recipeBook.recipes[row].directions = editDirectionsTV.text!
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editDirectionsTV.text = recipeBook.recipes[row].directions
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }

}
