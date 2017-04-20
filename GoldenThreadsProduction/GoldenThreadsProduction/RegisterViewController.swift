//
//  RegisterViewController.swift
//  JBTFoundation
//
//  Created by Sugat Nagavkar on 02/09/16.
//  Copyright © 2016 Sugat Nagavkar. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userMobile: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var registerView: UIView!
    
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

    
    @IBAction func register(_ sender: AnyObject) {
        
        let userEmailText = userEmail.text!
        //let userMobileText = userMobile.text!
        let userPasswordText = userPassword.text!
        
        if (userEmailText.isEmpty || userPasswordText.isEmpty){
            sendAlert("Please Enter Empty Fields")
        }
        
        //create user
        FIRAuth.auth()?.createUser(withEmail: userEmailText, password: userPasswordText, completion: {
            user, error in
            
            print("Email = \(userEmailText), Password = \(userPasswordText)")
            
            if error != nil {
                self.sendAlert("Email Already Exists. Please click on Forgot Password.")
            }else{
                
                self.sendAlert("Registration Successfull")
                
                self.userEmail.text = ""
                self.userPassword.text = ""
                self.resignFirstResponder()
            }
            
        
        })
        

        
    }
    
    
    
    override func viewDidLoad() {
        
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        
         view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        registerView.layer.cornerRadius = 5
        registerView.layer.masksToBounds = true
        
    }//end of viewDidLoad
    
    func sendAlert(_ message : String){
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
    }//end of sendAlert func
    
    
}
