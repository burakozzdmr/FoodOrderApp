//
//  CartCell.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 10.08.2024.
//

import UIKit

class CartCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodPieceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var foodContent: CartContent?
    var viewModel = CartViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func trashPressed(_ sender: UIButton) {
        if let safeContent = foodContent {
            viewModel.removeFood(sepet_yemek_id: safeContent.sepet_yemek_id!, kullanici_adi: "burak_ozdemir")
        }
    }
}
