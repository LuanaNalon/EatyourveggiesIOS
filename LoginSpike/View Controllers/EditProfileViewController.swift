//
//  EditProfileViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 05/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class EditProfileViewController: UIViewController, UITextFieldDelegate,
                                 UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    let storage = Storage.storage().reference()
    
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sucessLabel: UILabel!
    @IBOutlet weak var photoProfileView: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        getUser()
    }
    func validateFields() -> String?{
        //check that allfields are filled in
        if lastNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        return nil
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setUpElements(){
        //hide the error label
        errorLabel.alpha = 0
    
        //style the elements
        Utilities.styleTextField(firstNameTextfield)
        Utilities.styleTextField(lastNameTextfield)
        Utilities.styleFilledButton(updateButton)
    }
    func getUser(){
        let docRef = db.collection("users").document(user!)
        print("docRef", docRef)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.firstNameTextfield.text = document.get("firstname") as? String
                self.lastNameTextfield.text =  document.get("lastname") as? String
            } else {
                self.showError("Unable to get user data")
            }
        }
        // Create a reference from a Google Cloud Storage URI
        let storage = Storage.storage().reference(forURL: "gs://loginspike-47cbc.appspot.com/profilePhotos/"+String(user!)+".png")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        storage.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if error != nil {
            return
          } else {
            let image = UIImage(data: data!)
            self.photoProfileView.image = image
          }
        }
        
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        if error != nil{
            
            //there's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            let firstName = firstNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            db.collection("users").document(user!).setData(["firstname" : firstName, "lastname": lastName])
            let alert = UIAlertController(title: "User updated successfully!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
            self.present(alert, animated: true)
        }
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
        guard let imageData = selectedImage.pngData() else {
            return
        }
        photoProfileView.image = selectedImage
        //upload image data
        storage.child("profilePhotos/"+String(user!)+".png").putData(imageData, metadata: nil) { (_, error) in
            guard error == nil else {
                self.showError("Failed to upload")
                return
            }
        }
        
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
