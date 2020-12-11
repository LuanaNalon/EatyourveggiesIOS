
import UIKit

class FavoriteVegetableTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!

    var favButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
        
        // Add action to perform when the button is tapped
        self.favButton.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favButtonTapped(_ sender: UIButton){
       // if the closure is defined (not nil)
       // then execute the code inside the subscribeButtonAction closure
        favButton.tintColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
       favButtonAction?()
     }
}
