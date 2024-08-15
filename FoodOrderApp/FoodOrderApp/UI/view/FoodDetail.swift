//
//  FoodDetail.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import Kingfisher

class FoodDetail: UIViewController {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var pieceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    var foodContent: FoodContent?
    var pieceValue = 1
    var viewModel = FoodDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let safeContent = foodContent {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(safeContent.yemek_resim_adi!)") {
                foodImageView.kf.setImage(with: url)
            }
            foodPriceLabel.text = "\(safeContent.yemek_fiyat!)₺"
            foodNameLabel.text = safeContent.yemek_adi
            totalPriceLabel.text = "\(safeContent.yemek_fiyat!)₺"
        }
        updateUI()
    }
    
    
    @IBAction func exitPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if pieceValue > 1 {
            pieceValue -= 1
        }
        updateUI()
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        pieceValue += 1
        updateUI()
    }
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        if let safeContent = foodContent {
            if let convertedPrice = Int(safeContent.yemek_fiyat!) {
                viewModel.addFoodCart(yemek_adi: safeContent.yemek_adi!, yemek_resim_adi: safeContent.yemek_resim_adi!, yemek_fiyat: convertedPrice, yemek_siparis_adet: pieceValue, kullanici_adi: "burak_ozdemir")
            } else {
                print("Convert Error !")
            }
        }
        performSegue(withIdentifier: "detailToCart", sender: foodContent)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToCart" {
            if let safeSender = sender as? FoodContent {
                let destinationVC = segue.destination as! Cart
                destinationVC.cartContent = safeSender
            }
        }
    }
    
    func updateUI() {
        pieceLabel.text = "\(pieceValue)"
        if let safeContent = foodContent {
            if let price = Int(safeContent.yemek_fiyat!) {
                let priceValue = pieceValue * price
                totalPriceLabel.text = "\(priceValue)₺"
            }
        }
    }
}
