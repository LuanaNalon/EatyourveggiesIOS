//
//  EditProfileViewController.swift
//  LoginSpike
//
//  Created by Tânia Maria Martins Roda on 04/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class EditProfileViewController: UIViewController {
  
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sucessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        getUser1()
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func setUpElements(){
        //hide the error label
        errorLabel.alpha = 0
        sucessLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextfield)
        Utilities.styleTextField(lastNameTextfield)
        Utilities.styleFilledButton(updateButton)
    }
    //todo parei aqui falta mostrar os dados
    func getUser(){
        let docRef = db.collection("users").document(user!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
        }
            
    }
    func getUser1(){
        let docRef = db.collection("users").document(user!)
        docRef.getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists {
                    let documentdata = document?.data()
                    
                }
            }
            
    }
}
    
    
    @IBAction func updateTapped(_ sender: Any) {
        let firstName = firstNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        db.collection("users").document(user!).setData(["firstName" : firstName, "lastName": lastName])
        sucessLabel.alpha = 1
    }
    
}
