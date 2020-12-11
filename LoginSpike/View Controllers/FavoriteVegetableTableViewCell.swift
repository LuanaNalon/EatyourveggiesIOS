
import UIKit

class FavoriteVegetableTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!


    var favButtonAction : (() -> ())?
    var buyButtonAction : (() -> ())?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
        var buyButtonAction : (() -> ())?
        
        // Add action to perform when the button is tapped
        self.favButton.addTarget(self, action: #selector(favButtonTapped(_:)), for: .touchUpInside)
        self.buyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favButtonTapped(_ sender: UIButton){
       // if the closure is defined (not nil)
       // then execute the code inside the subscribeButtonAction closure
       favButtonAction?()

     }
    @IBAction func buyButtonTapped(_ sender: UIButton){
       // if the closure is defined (not nil)
       // then execute the code inside the buy closure
       
       buyButtonAction?()
     }
}
