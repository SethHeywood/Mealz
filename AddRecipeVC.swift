//
//  AddRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
// Code for camera modified from Steve Lipton tutorial http://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/
// and from http://tjsander.github.io/swift-camera/

import UIKit
import MobileCoreServices

class AddRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var prepH: UITextField!
    @IBOutlet weak var prepM: UITextField!
    @IBOutlet weak var cookH: UITextField!
    @IBOutlet weak var cookM: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var picture: UIImageView!
    var picker = UIImagePickerController()
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        titleTF.delegate = self
        yieldTF.delegate = self
        prepH.delegate = self
        prepM.delegate = self
        cookH.delegate = self
        cookM.delegate = self
        picture.image = UIImage(named: "Chef.png")
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

    
    @IBAction func saveRecipe(sender: UIBarButtonItem) {
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(prepH.text!)
        var prepMin = recipeBook.stringToInt(prepM.text!)
        var cookHours = recipeBook.stringToInt(cookH.text!)
        var cookMin = recipeBook.stringToInt(cookM.text!)
        
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
        
        recipeBook.addRecipe(title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin, ingred: ING, direct: DIR, pic: photo)

        recipeBook.saveRecipeToParse()

        DIR = ""
        ING = ""

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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
