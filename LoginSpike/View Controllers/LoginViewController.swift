//
//  LoginViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 27/11/2020.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

//    FirebaseApp.configure()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel:
        UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

// Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
//hide the error label
        errorLabel.alpha = 0
        
//style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
//check the fields and validate that the data is correct.
    func validateFields() -> String?{
//check that allfields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
//check if the password is secure
    //    let password = passwordTextField.text!.trimmingCharacters(in:  .whitespacesAndNewlines)
        
    //    if Utilities.isPasswordValid(password) == false {
//Password isn't secure enough
     //      return "Please make sure your password is at least 8 characters, contains a special character and a number."
     //   }
            return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToMenu() {
        
       let menuviewController =
        storyboard?.instantiateViewController(identifier:
        Constants.Storyboard.menuViewcontroller) as?
        MenuViewController
        
        view.window?.rootViewController = menuviewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func loginTapped(_ sender: Any) {
//Validate the fields
        let error = validateFields()
        if error != nil{
//there's something wrong with the fields, show error message
           showError(error!)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
//Singning in the user
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                if error != nil{
//there's something wrong with the fields, show error message
                   self.errorLabel.text = error!.localizedDescription
                   self.errorLabel.alpha = 1
                }else{
                    self.transitionToMenu()
                }
                
            }
           
                    
        }

    }
    
    func transitionToHome() {
        
       let viewController =
        storyboard?.instantiateViewController(identifier:
        Constants.Storyboard.viewController) as?
        ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func returnTapped(_ sender: Any) {
        transitionToHome()
        
    }
}
