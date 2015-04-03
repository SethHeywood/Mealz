//
//  AddDirectionsVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/30/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class AddDirectionsVC: UIViewController {
    
    @IBOutlet weak var addDirectionsTextView: UITextView!
    
    @IBAction func saveDirections(sender: UIBarButtonItem) {
        var directions = addDirectionsTextView.text!
        DIR = directions
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDirectionsTextView.text = DIR
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }

}
