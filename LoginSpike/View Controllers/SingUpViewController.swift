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
import FirebaseStorage

class SingUpViewController: UIViewController,UITextFieldDelegate,
                            UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storage = Storage.storage().reference()
    
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
                    
                    db.collection("users").document(result!.user.uid).setData( ["firstname":firstName,
                                                                                "lastname":lastName,
                                                                                "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            //show error message
                            self.showError("Error saving user data")
                        }
                        
                    }
                    guard let imageData = self.photoImageView.image?.pngData() else {
                        return
                    }
                    //upload image data
                    self.storage.child("profilePhotos/"+String(result!.user.uid)+".png").putData(imageData, metadata: nil) { (_, error) in
                        guard error == nil else {
                            self.showError("Failed to upload")
                            return
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
        // Dismiss the picker.
        picker.dismiss(animated: true, completion: nil)
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage =
                info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        
    }
    
    @IBAction func changePhotoTapped(_ sender: Any) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
}
