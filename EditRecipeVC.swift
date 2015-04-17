//
//  EditRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 4/2/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//
// Camera modified from this tutorial http://tjsander.github.io/swift-camera/

import UIKit
import MobileCoreServices

class EditRecipeVC: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var pHourTF: UITextField!
    @IBOutlet weak var pMinTF: UITextField!
    @IBOutlet weak var cHourTF: UITextField!
    @IBOutlet weak var cMinTF: UITextField!

    @IBOutlet weak var imageView: UIImageView!

    
    var row: Int!


    @IBAction func saveRecipeBtn(sender: UIBarButtonItem) {
    
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(pHourTF.text!)
        var prepMin = recipeBook.stringToInt(pMinTF.text!)
        var cookHours = recipeBook.stringToInt(cHourTF.text!)
        var cookMin = recipeBook.stringToInt(cMinTF.text!)
    
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
    
        recipeBook.editRecipe(row, ttl: title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin, editImage: self.imageView!.image!)
    
        //recipeBook.saveRecipeToParse()
        
        ING = ""
        DIR = ""
        //recipeBook.saveRecipeToParse()

        NSNotificationCenter.defaultCenter().postNotificationName("ViewRecipe", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("RecipeTable", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes =  [kUTTypeImage]
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
            var alert = UIAlertController(title: "No camera", message: "Please allow this app the use of your camera in settings or buy a device that has a camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject])
    {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        let compResult:CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        if ( compResult == CFComparisonResult.CompareEqualTo ) {
            
            editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
            originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
            
            if ( editedImage != nil ) {
                imageToSave = editedImage
            } else {
                imageToSave = originalImage
            }
            imageView!.image = imageToSave
            imageView!.reloadInputViews()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.text = recipeBook.recipes[row].title
        yieldTF.text = String(recipeBook.recipes[row].yield)
        pHourTF.text = String(recipeBook.recipes[row].prepHour)
        pMinTF.text = String(recipeBook.recipes[row].prepMin)
        cHourTF.text = String(recipeBook.recipes[row].cookHour)
        cMinTF.text = String(recipeBook.recipes[row].cookMin)
        
        self.imageView!.image = recipeBook.recipes[row].image
        
        
    }

//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.view.endEditing(true);
//    }


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
