

import UIKit

@IBDesignable class FavoriteControl: UIStackView {
    
    private var favoriteButtons = [UIButton]()
    var favorite = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
           super.init(coder: coder)
           setupButtons()
       }
    
 
    
    private func setupButtons() {
        // clear any existing buttons
        for button in favoriteButtons {
        
            button.removeFromSuperview()
        }
        favoriteButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "circle", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "checkmark.circle.fill", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
      
            // Create the button
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(FavoriteControl.favoriteButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
           
            // Add the new button to the favorite button array
            favoriteButtons.append(button)
        
        
        updateButtonSelectionStates()
    }
    
    @objc func favoriteButtonTapped(button: UIButton) {
        //print("Button pressed!")
       
        /*
        guard let index = favoriteButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the favoriteButtons array: \(favoriteButtons)")
        }
        
        // Calculate the favorite of the selected button
        let selectedfavorite = index + 1
        
        if selectedfavorite == favorite {
            // If the selected star represents the current favorite, reset the favorite to 0.
            favorite = 0
        } else {
            // Otherwise set the favorite to the selected star
            favorite = selectedfavorite
        }
 */
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in favoriteButtons.enumerated() {
            // If the index of a button is less than the favorite, that button should be selected.
            button.isSelected = index < favorite
        }
    }
}
