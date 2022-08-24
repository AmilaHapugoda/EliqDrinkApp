//
//  DrinkItemTableViewCell.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-22.
//

import UIKit

class DrinkItemTableViewCell: UITableViewCell {

    @IBOutlet weak var img_drink: UIImageView!
    @IBOutlet weak var lbl_drink_name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(drink: ListItemModel) {
        self.lbl_drink_name.text = drink.strDrink
        self.img_drink.loadFrom(url: drink.strDrinkThumb)
        self.img_drink.clipsToBounds = true
        self.img_drink.layer.cornerRadius = 10
    }
    
}
