//
//  EditProfileViewController.swift
//  LoginSpike
//
//  Created by Tânia Maria Martins Roda on 04/12/2020.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var vButtonAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        vButtonAction.backgroundColor = UIColor.systemBlue
        vButtonAction.layer.cornerRadius = 5
        vButtonAction.layer.borderWidth = 1
        vButtonAction.layer.borderColor = UIColor.systemBlue.cgColor
        
    }


}
