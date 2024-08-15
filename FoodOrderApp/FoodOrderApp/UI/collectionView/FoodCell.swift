//
//  FoodCell.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit

protocol SegueDelegate {
    func performingSegue(withIdentifier: String, sender: Any?)
}

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    var foodContent: FoodContent?
    var viewModel = HomepageViewModel()
    var delegate: SegueDelegate?
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        if let safeContent = foodContent, let safePrice = Int(safeContent.yemek_fiyat!) {
            viewModel.addFoodCart(yemek_adi: safeContent.yemek_adi!, yemek_resim_adi: safeContent.yemek_resim_adi!, yemek_fiyat: safePrice, yemek_siparis_adet: 1, kullanici_adi: "burak_ozdemir")
        }
        delegate?.performingSegue(withIdentifier: "plusToCart", sender: self)
    }
}
