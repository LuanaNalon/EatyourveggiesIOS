import UIKit
import os.log

class Vegetable: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var batchID: String
    var origin: String
    var cultivation: String
    var weight: String
    var hDate: String
    var eDate: String
    var localization: String
    var temperature: String
    var humidity: String
    var co2: String
    var tilt: String
    var shock: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in:
                                                        .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("vegetables")
    
    //MARK: Initialization
    init?(batchID: String, name: String, photo: UIImage?, origin: String, cultivation: String, weight: String, hDate: String, eDate: String,
          localization: String, temperature: String, humidity: String, co2: String, tilt: String, shock: String) {
        
        // Should fail if there’s no name or if the rating is negative.
        if name.isEmpty || batchID.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.batchID = batchID
        self.origin = origin
        self.cultivation = cultivation
        self.weight = weight
        self.hDate = hDate
        self.eDate = eDate
        self.localization = localization
        self.temperature = temperature
        self.humidity = humidity
        self.co2 = co2
        self.tilt = tilt
        self.shock = shock
    }
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let batchID = "batchID"
        static let origin = "origin"
        static let cultivation = "cutivation"
        static let weight = "weight"
        static let hDate = "hDate"
        static let eDate = "eDate"
        static let localization = "localization"
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let co2 = "co2"
        static let tilt = "tilt"
        static let shock = "shock"
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(batchID, forKey: PropertyKey.batchID)
        coder.encode(origin, forKey: PropertyKey.origin)
        coder.encode(cultivation, forKey: PropertyKey.cultivation)
        coder.encode(weight, forKey: PropertyKey.weight)
        coder.encode(hDate, forKey: PropertyKey.hDate)
        coder.encode(eDate, forKey: PropertyKey.eDate)
        coder.encode(localization, forKey: PropertyKey.localization)
        coder.encode(temperature, forKey: PropertyKey.temperature)
        coder.encode(humidity, forKey: PropertyKey.humidity)
        coder.encode(co2, forKey: PropertyKey.co2)
        coder.encode(tilt, forKey: PropertyKey.tilt)
        coder.encode(shock, forKey: PropertyKey.shock)
    }
    
    required convenience init?(coder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Vegetable, just use conditional cast.
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let batchID = coder.decodeObject(forKey: PropertyKey.batchID) as? String else {
            os_log("Unable to decode the batchId for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let origin = coder.decodeObject(forKey: PropertyKey.origin) as? String else {
            os_log("Unable to decode the origin for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let cultivation = coder.decodeObject(forKey: PropertyKey.cultivation) as? String else {
            os_log("Unable to decode the cultivation for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let weight = coder.decodeObject(forKey: PropertyKey.weight) as? String else {
            os_log("Unable to decode the weight for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let hDate = coder.decodeObject(forKey: PropertyKey.hDate) as? String else {
            os_log("Unable to decode the hDate for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let eDate = coder.decodeObject(forKey: PropertyKey.eDate) as? String else {
            os_log("Unable to decode the eDate for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let localization = coder.decodeObject(forKey: PropertyKey.localization) as? String else {
            os_log("Unable to decode the localization for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let temperature = coder.decodeObject(forKey: PropertyKey.temperature) as? String else {
            os_log("Unable to decode the temperature for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let humidity = coder.decodeObject(forKey: PropertyKey.humidity) as? String else {
            os_log("Unable to decode the humidity for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let co2 = coder.decodeObject(forKey: PropertyKey.co2) as? String else {
            os_log("Unable to decode the temperature for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let tilt = coder.decodeObject(forKey: PropertyKey.tilt) as? String else {
            os_log("Unable to decode the tilt for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let shock = coder.decodeObject(forKey: PropertyKey.shock) as? String else {
            os_log("Unable to decode the shock for a Vegetable object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(batchID: batchID,
                  name: name,
                  photo: photo,
                  origin: origin,
                  cultivation: cultivation,
                  weight: weight,
                  hDate: hDate,
                  eDate: eDate,
                  localization: localization,
                  temperature: temperature,
                  humidity: humidity,
                  co2: co2,
                  tilt: tilt,
                  shock: shock)
    }
    
}
