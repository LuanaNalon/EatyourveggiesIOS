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
    
    @IBOutlet weak var noLogoutButton: UIButton!
    @IBOutlet weak var labelError: UILabel!
    override func viewDidLoad() {
        labelError.alpha = 0
        setUpElements()
        super.viewDidLoad()
    }
    func setUpElements(){
        Utilities.styleFilledButton(logoutButton)
        Utilities.styleHollowButton(noLogoutButton)
    }
    func showError(_ message:String) {
        labelError.text = message
        labelError.alpha = 1
    }
    func logout(){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            showError("Error: Could not log out")
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
    func transitionToMenu() {
        
        let menuviewController =
            storyboard?.instantiateViewController(identifier:
                                                    Constants.Storyboard.menuViewcontroller) as?
            MenuViewController
        
        view.window?.rootViewController = menuviewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        logout()
        transitionToHome()
    }
    
    @IBAction func noTapped(_ sender: Any) {
        transitionToMenu()
    }
    
}
