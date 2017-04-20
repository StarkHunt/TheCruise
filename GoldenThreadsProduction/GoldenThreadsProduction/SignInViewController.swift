//
//  SignInViewController.swift
//  JBTFoundation
//
//  Created by Sugat Nagavkar on 02/09/16.
//  Copyright © 2016 Sugat Nagavkar. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewSignIn: UIView!
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func signIn(_ sender: AnyObject) {
        
        let userEmailText = userEmail.text!
        let userPasswordText = userPassword.text!
        print("UserEmail: \(userEmailText). userPassword: \(userPasswordText)")
        if (userEmailText.isEmpty || userPasswordText.isEmpty){
        
        sendAlert("Cannot Sign In. Please Enter Empty Fields")
            
        return
        }
        
        //login with Firebase
        FIRAuth.auth()?.signIn(withEmail: userEmailText, password: userPasswordText, completion: {
            user, error in
            
            if error != nil {
                self.sendAlert("Email or Password Incorrect. Please reenter.")
                return
            }else{
        print("Successful ")
        self.performSegue(withIdentifier: "swreveal", sender: self)
            }
        
        })
        
        
    }//end of sign in action
    
    
    override func viewDidLoad() {
        
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        
        do{
            try FIRAuth.auth()?.signOut()
        }catch let errorType{
            print(errorType)
        }
        
        
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
    
        viewSignIn.layer.cornerRadius = 5
        viewSignIn.layer.masksToBounds = true
        //self.navigationController?.navigationBar.hidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
        return true;
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    
    func sendAlert(_ message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }//end of sendAlert func
    
}
