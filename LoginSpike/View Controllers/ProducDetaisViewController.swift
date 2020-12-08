//
//  ProducDetaisViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 06/12/2020.
//

import UIKit

class ProducDetaisViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var cultivationField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var hDateField: UITextField!
    @IBOutlet weak var eDateField: UITextField!
    @IBOutlet weak var localizationField: UITextField!
    @IBOutlet weak var temperatureField: UITextField!
    @IBOutlet weak var humidityField: UITextField!
    @IBOutlet weak var co2Field: UITextField!
    @IBOutlet weak var tiltField: UITextField!
    @IBOutlet weak var shockField: UITextField!
    
    @IBOutlet weak var returnButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        
        //style the elements
        Utilities.styleTextField(nameField)
        Utilities.styleTextField(originField)
        Utilities.styleTextField(cultivationField)
        Utilities.styleTextField(weightField)
        Utilities.styleTextField(hDateField)
        Utilities.styleTextField(eDateField)
        Utilities.styleTextField(localizationField)
        Utilities.styleTextField(temperatureField)
        Utilities.styleTextField(humidityField)
        Utilities.styleTextField(co2Field)
        Utilities.styleTextField(tiltField)
        Utilities.styleTextField(shockField)
        
    }
    
    @IBAction func returnTapped(_ sender: Any) {
    }
}
