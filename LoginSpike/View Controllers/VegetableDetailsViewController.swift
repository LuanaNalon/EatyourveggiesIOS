//
//  VegetableDetaisViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 06/12/2020.
//

import UIKit

class VegetableDetailsViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var vegetable:Vegetable?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements(){
        
        nameField.isUserInteractionEnabled = false
        originField.isUserInteractionEnabled = false
        cultivationField.isUserInteractionEnabled = false
        weightField.isUserInteractionEnabled = false
        hDateField.isUserInteractionEnabled = false
        eDateField.isUserInteractionEnabled = false
        localizationField.isUserInteractionEnabled = false
        temperatureField.isUserInteractionEnabled = false
        humidityField.isUserInteractionEnabled = false
        co2Field.isUserInteractionEnabled = false
        tiltField.isUserInteractionEnabled = false
        shockField.isUserInteractionEnabled = false

        if let vegetable = vegetable {
            
            nameField.text = vegetable.name
            originField.text = vegetable.origin
            cultivationField.text = vegetable.cultivation
            weightField.text = vegetable.weight
            hDateField.text = vegetable.hDate
            eDateField.text = vegetable.eDate
            localizationField.text = vegetable.localization
            temperatureField.text = vegetable.temperature
            humidityField.text = vegetable.humidity
            co2Field.text = vegetable.co2
            tiltField.text = vegetable.tilt
            shockField.text = vegetable.shock
        }
    }
}
