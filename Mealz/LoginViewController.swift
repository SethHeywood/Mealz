//
//  LoginViewController.swift
//  Mealz
//
//  Created by Ryan Simmons on 4/16/15.
//
// This view controller is a login screen. Users must have a registered account to log in,
// and will receive an error if they don't. From this view, a user can also navigate to a register
// view controller to create an account.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!      // Username field
    @IBOutlet weak var passwordField: UITextField!  // Password field
    
    // Login button will use Parse to log in user if the have an account.
    // If not, they will receive an error message.
    @IBAction func login(sender: AnyObject) {
        
        // Attempt to log them in in the background
        PFUser.logInWithUsernameInBackground(self.nameField.text, password:self.passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // User is valid and was logged in...we can go into the app
                self.performSegueWithIdentifier("goToApp", sender: self)
                
            } else {
                // Something went wrong and we should show an alert
                let errorString = error.userInfo!["error"] as NSString
                var alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
