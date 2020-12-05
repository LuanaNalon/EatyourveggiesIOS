//
//  SingUpViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 01/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SingUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTexeField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()

    }
    func setUpElements(){
        //hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTexeField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(singUpButton)
    }
        //check the fields and validate that the data is correct.
        func validateFields() -> String?{
            //check that allfields are filled in
            if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                lastNameTexeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                return "Please fill in all fields."
            }
            //check if the password is secure
            //let password = passwordTextField.text!.trimmingCharacters(in:  .whitespacesAndNewlines)
            
           // if Utilities.isPasswordValid(password) == false {
                //Password isn't secure enough
           //    return "Please make sure your password is at least 8 characters, contains a special character and a number."
            //}
            //todo add method to check an email
            return nil
        }
        
        func showError(_ message:String) {
            
            errorLabel.text = message
            errorLabel.alpha = 1
        }
    
        func transitionToLogin() {
        
            let loginviewController =
            storyboard?.instantiateViewController(identifier:
            Constants.Storyboard.loginViewController) as?
            LoginViewController
        
            view.window?.rootViewController = loginviewController
            view.window?.makeKeyAndVisible()
        }
    
    @IBAction func singUpTapped(_ sender: Any) {
        //Validate the fields
                let error = validateFields()
        
                if error != nil{
                    
                    //there's something wrong with the fields, show error message
                   showError(error!)
                }
                else {
                    let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastName = lastNameTexeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    //Create the user
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        //check for errors
                        if err != nil{
                            
                            //there was an error creating the user
                            self.showError("Error creating user")
                            
                        }else{
                        
                            // User was created successfully, now store the first name and last name
                            let db = Firestore.firestore()
                            
                            db.collection("users").addDocument(data: ["firstname":firstName,
                               "lastname":lastName, "uid": result!.user.uid]) { (error) in
                                
                                if error != nil {
                                    //show error message
                                    self.showError("Error saving user data.")
                                }
                        }
                            //transition to login form
                            self.transitionToLogin()
                    }
                   
                    }
                }
    }
}
