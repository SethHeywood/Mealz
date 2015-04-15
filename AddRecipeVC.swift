//
//  AddRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit

class AddRecipeVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var prepH: UITextField!
    @IBOutlet weak var prepM: UITextField!
    @IBOutlet weak var cookH: UITextField!
    @IBOutlet weak var cookM: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!

    
    @IBAction func saveRecipe(sender: UIBarButtonItem) {
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(prepH.text!)
        var prepMin = recipeBook.stringToInt(prepM.text!)
        var cookHours = recipeBook.stringToInt(cookH.text!)
        var cookMin = recipeBook.stringToInt(cookM.text!)
        
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
        
        recipeBook.addRecipe(title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin, ingred: ING, direct: DIR)

        recipeBook.saveRecipeToParse()

        DIR = ""
        ING = ""

        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.view.endEditing(true);
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
