
import UIKit

class VegetableTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    var buyButtonAction : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if self.buyButton != nil {
            var buyButtonAction : (() -> ())?
            
            
            self.buyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    @IBAction func buyButtonTapped(_ sender: UIButton){
       // if the closure is defined (not nil)
       // then execute the code inside the buy closure
       
       buyButtonAction?()
     }

}
