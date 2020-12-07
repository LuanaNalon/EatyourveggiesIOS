//
//  Vegetable.swift
//  LoginSpike
//
//  Created by Mac on 05/12/2020.
//

import UIKit
import os.log

struct Vegetable:  Codable {
    
    //MARK: Properties
    var batchID: String
    var name :String
  //  var size :String
   // var photo: UIImage?
   // var category: String
    
    //MARK: Initialization
 /*   init?(batchID: String,name: String, photo: UIImage? ) {
        
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
    */
 /*   struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let batchID = "batchID"
        static let category = "category"
    }
    
    func encode(with coder: NSCoder) {
            coder.encode(name, forKey: PropertyKey.name)
            coder.encode(photo, forKey: PropertyKey.photo)
            coder.encode(batchID, forKey: PropertyKey.batchID)
        coder.encode(category, forKey: PropertyKey.category)

        }
    
    required convenience init?(coder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let batchID = coder.decodeObject(forKey: PropertyKey.batchID) as! String
        
       // let category = coder.decodeObject(forKey: PropertyKey.category) as!  String
        // Must call designated initializer.
        self.init( batchID: batchID, name: name, photo: photo)
    }
    */
}

