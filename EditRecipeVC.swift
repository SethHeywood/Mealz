//
//  EditRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var pHourTF: UITextField!
    @IBOutlet weak var pMinTF: UITextField!
    @IBOutlet weak var cHourTF: UITextField!
    @IBOutlet weak var cMinTF: UITextField!
    @IBOutlet weak var picture: UIImageView!
    var picker = UIImagePickerController()
    var photo: UIImage!

    var row: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.text = recipeBook.recipes[row].title
        yieldTF.text = String(recipeBook.recipes[row].yield)
        pHourTF.text = String(recipeBook.recipes[row].prepHour)
        pMinTF.text = String(recipeBook.recipes[row].prepMin)
        cHourTF.text = String(recipeBook.recipes[row].cookHour)
        cMinTF.text = String(recipeBook.recipes[row].cookMin)
        picture.image = recipeBook.recipes[row].picture
        
        titleTF.delegate = self
        yieldTF.delegate = self
        pHourTF.delegate = self
        pMinTF.delegate = self
        cHourTF.delegate = self
        cMinTF.delegate = self
    }
    
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }


    @IBAction func saveRecipeBtn(sender: UIBarButtonItem) {
    
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(pHourTF.text!)
        var prepMin = recipeBook.stringToInt(pMinTF.text!)
        var cookHours = recipeBook.stringToInt(cHourTF.text!)
        var cookMin = recipeBook.stringToInt(cMinTF.text!)
    
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
    
        recipeBook.editRecipe(row, ttl: title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin, pic: photo)
    
        recipeBook.saveRecipeToParse()
        
        ING = ""
        DIR = ""

        NSNotificationCenter.defaultCenter().postNotificationName("ViewRecipe", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("RecipeTable", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
        //    picker.popoverPresentationController?. = sender
    }
    
    
    @IBAction func addPicture(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            noCamera()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        picture.contentMode = .ScaleAspectFit
        picture.image = photo
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "editIngredients") {
            let nextVC:EditIngredientsVC = segue.destinationViewController as! EditIngredientsVC
            nextVC.row = row
        }
        else if (segue.identifier == "editDirections") {
            let nextVC:EditDirectionsVC = segue.destinationViewController as! EditDirectionsVC
            nextVC.row = row
        }
    }
    

}
