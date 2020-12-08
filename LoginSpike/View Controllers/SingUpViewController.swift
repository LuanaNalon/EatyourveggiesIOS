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

class SingUpViewController: UIViewController,UITextFieldDelegate,
                            UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTexeField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var changePhotoButton: UIButton!
    
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
                    let alert = UIAlertController(title: "Registration done successfully!", message: nil, preferredStyle: .alert)
                    self.present(alert, animated: true)
                    //transition to login form
                    self.transitionToLogin()
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
                                Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage =
                info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        
        photoImageView.image = selectedImage
    
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changePhotoTapped(_ sender: Any) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    
}
