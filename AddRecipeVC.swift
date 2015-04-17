//
//  AddRecipeVC.swift
//  Mealz
//
//  Created by Seth Heywood on 3/24/15.
//  Copyright (c) 2015 Seth Heywood. All rights reserved.
//
// Camera modified from this tutorial http://tjsander.github.io/swift-camera/

import UIKit
import MobileCoreServices

class AddRecipeVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var yieldTF: UITextField!
    @IBOutlet weak var prepH: UITextField!
    @IBOutlet weak var prepM: UITextField!
    @IBOutlet weak var cookH: UITextField!
    @IBOutlet weak var cookM: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!

    @IBOutlet weak var imageView = UIImageView(image: UIImage(named: "Blank.png"))
    
    @IBAction func saveRecipe(sender: UIBarButtonItem) {
        var title = titleTF.text
        var yield = recipeBook.stringToInt(yieldTF.text!)
        var prepHours = recipeBook.stringToInt(prepH.text!)
        var prepMin = recipeBook.stringToInt(prepM.text!)
        var cookHours = recipeBook.stringToInt(cookH.text!)
        var cookMin = recipeBook.stringToInt(cookM.text!)
        
        var readyHour = prepHours + cookHours
        var readyMin = prepMin + cookMin
        
        recipeBook.addRecipe(title, yld: yield, pHour: prepHours, pMin: prepMin, cHour: cookHours, cMin: cookMin, rHour: readyHour, rMin: readyMin, ingred: ING, direct: DIR, image: self.imageView!.image!)

        //recipeBook.saveRecipeToParse()
        
        //println(recipeBook.recipes)

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
