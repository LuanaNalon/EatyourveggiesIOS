import UIKit
import os.log

class Vegetable: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var batchID: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in:
                                                        .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("vegetables")
    
    //MARK: Initialization
    init?(batchID: String, name: String, photo: UIImage?) {
        
        // Should fail if there’s no name or if the rating is negative.
        if name.isEmpty || batchID.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.batchID = batchID
    }
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let batchID = "batchID"
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(batchID, forKey: PropertyKey.batchID)
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
        
        // Must call designated initializer.
        self.init(batchID: batchID, name: name, photo: photo )
    }
    
}
