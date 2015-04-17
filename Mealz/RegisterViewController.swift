//
//  RegisterViewController.swift
//  Mealz
//
//  Created by Ryan Simmons on 4/16/15.
//
// This view controller is a register screen. Users must have a registered account to use the app
// All fields must be filled out and user will be notified if not, or if the email field does not contain
// a valid email address. (must have an '@' and a '.com'. The user can go back to the login screen from here
// however if they register they are logged in automatically and taken into the app

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // Use parse to sign up user
    @IBAction func signUp(sender: AnyObject) {
        if(self.nameField.text != "" && self.emailField.text != "" && self.passwordField.text != "") {
            var user = PFUser()
            user.username = self.nameField.text;
            user.password = self.passwordField.text;
            user.email = self.emailField.text;
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    // If the signup was successful, attempt to log them in
                    PFUser.logInWithUsernameInBackground(self.nameField.text, password:self.passwordField.text) {
                        (user: PFUser!, error: NSError!) -> Void in
                        if user != nil {
                            self.performSegueWithIdentifier("goToApp", sender: self)
                        
                        } else {
                            // We couln't log in so you get an error
                            let errorString = error.userInfo!["error"] as NSString
                            var alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // We couldn't sign up so you get an error
                    let errorString = error.userInfo!["error"] as NSString
                    var alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        // If any field is left blank, we should shade the textfields red.....or back to white
        // depending on what is happening
        else {
            if(self.nameField.text == "") {
                self.nameField.backgroundColor = UIColor(hue:0, saturation:0.2, brightness:0.96, alpha:1)
            }
            else {
                self.nameField.backgroundColor = .whiteColor()
            }
            if(self.emailField.text == "") {
                self.emailField.backgroundColor = UIColor(hue:0, saturation:0.2, brightness:0.96, alpha:1)
            }
            else {
                self.emailField.backgroundColor = .whiteColor()
            }
            if(self.passwordField.text == "") {
                self.passwordField.backgroundColor = UIColor(hue:0, saturation:0.2, brightness:0.96, alpha:1)
            }
            else {
                self.passwordField.backgroundColor = .whiteColor()
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










