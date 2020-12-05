//
//  LogoutViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 05/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LogoutViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        
        Utilities.styleCancelButton(logoutButton)
        
        super.viewDidLoad()
    }
    
    func logout(){
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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
    
    @IBAction func logoutTapped(_ sender: Any) {
        logout()
        transitionToHome()
    }
    
}
