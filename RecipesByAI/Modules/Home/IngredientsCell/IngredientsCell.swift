//
//  IngredientsCell.swift
//  RecipesByAI
//
//  Created by Glauber Gustavo on 18/04/23.
//

import UIKit

protocol IngredientsCellDelegate {
    func configSelectedIngredients(view: UIView, addIngredients: Bool)
}

class IngredientsCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIngredient: UIImageView!
    @IBOutlet weak var vwIngredient: UIView!
    @IBOutlet weak var lblIngredient: UILabel!
    
    var checkboxImage: UIImageView!
    var isSelectedIngredient = false

    var delegate: IngredientsCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwIngredient.layer.cornerRadius = 12
        vwIngredient.layer.shadowColor = UIColor.orange.withAlphaComponent(0.50).cgColor
        vwIngredient.layer.shadowOpacity = 1
        vwIngredient.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwIngredient.layer.shadowRadius = 4
        
        checkboxImage = UIImageView(image: UIImage(named: Constants.Images.iconCheckGreen))
        checkboxImage.frame = CGRect(x: 62, y: 2, width: 12, height: 12)
        checkboxImage.isHidden = true
        checkboxImage.tag = 1
        vwIngredient.addSubview(checkboxImage)
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        vwIngredient.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkboxImage.isHidden = true
        isSelectedIngredient = false
    }

    
    func setIngredientImage(image: String) {
        imgIngredient.image = UIImage(named: image)
    }
    
    func setIngredientName(name: String) {
        lblIngredient.text = name
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        isSelectedIngredient = !isSelectedIngredient

        checkboxImage.isHidden = !isSelectedIngredient

        delegate.configSelectedIngredients(view: vwIngredient, addIngredients: isSelectedIngredient)

        if isSelectedIngredient {
            self.shadowAnimation(transform: CGAffineTransform(scaleX: 0.9, y: 0.9), size: CGSize(width: 0, height: -5))
        } else {
            self.shadowAnimation(transform: CGAffineTransform.identity, size: CGSize(width: 0, height: 2))
        }
    }
    
}
