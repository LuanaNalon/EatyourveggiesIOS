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

    override func viewDidLoad() {
        super.viewDidLoad()
        logout()
        
    }
    
    func logout(){
        do {
          try Auth.auth().signOut()
            transitionToHome()
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

}
