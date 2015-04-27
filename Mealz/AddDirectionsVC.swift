//
//  AddDirectionsVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/30/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class AddDirectionsVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var addDirectionsTextView: UITextView!
    
    @IBAction func saveDirections(sender: UIBarButtonItem) {
        var directions = addDirectionsTextView.text!
        DIR = directions
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDirectionsTextView.text = DIR
        addDirectionsTextView.delegate = self
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
}
