//
//  Vegetable.swift
//  LoginSpike
//
//  Created by Mac on 05/12/2020.
//

import UIKit

class Vegetable: Codable, Identifiable {
    
    //MARK: Properties
    var batchID: String
    var name :String
  //  var size :String
    var photo: UIImage?
    var category: String
    
    //MARK: Initialization
    init?(batchID: String,name: String, photo: UIImage? ) {
        
        // Should fail if there’s no name or if the rating is negative.
        if name.isEmpty || batchID.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.batchID = batchID
        self.category = "category"
    }
    
}

