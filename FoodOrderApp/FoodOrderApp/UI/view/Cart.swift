//
//  Cart.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import Kingfisher

class Cart: UIViewController {
    
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    var cartContent: FoodContent?
    var viewModel = CartViewModel()
    var inFoodsCart = [CartContent]()
    var cartPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCollectionView.dataSource = self
        cartCollectionView.register(UINib(nibName: "CartCell", bundle: nil), forCellWithReuseIdentifier: "cartCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: 350, height: 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        
        cartCollectionView.collectionViewLayout = flowLayout
        
        _ = viewModel.inFoodsCart.subscribe(onNext: { list in
            self.inFoodsCart = list
            DispatchQueue.main.async {
                self.cartCollectionView.reloadData()
            }
        })
    }
    
    @IBAction func paymentPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ödeme Başarılı !", message: "Afiyet Olsun :)", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Tamam", style: .default) { alertAction in
            self.dismiss(animated: true)
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
}

extension Cart: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inFoodsCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let foodCart = inFoodsCart[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartCell", for: indexPath) as! CartCell
        
        cell.foodNameLabel.text = foodCart.yemek_adi
        cell.foodPieceLabel.text = "Adet : \(foodCart.yemek_siparis_adet!)"
        cell.foodPriceLabel.text = "\(foodCart.yemek_fiyat!)₺"
        cell.foodContent = foodCart
        
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(foodCart.yemek_resim_adi!)") {
            cell.foodImageView.kf.setImage(with: url)
        }
        
        if indexPath.row == inFoodsCart.count - 1 {
            calculateCartPrice()
        }
        
        if let foodPrice = Int(foodCart.yemek_fiyat!), let foodPiece = Int(foodCart.yemek_siparis_adet!) {
            let price = foodPrice * foodPiece
            cell.totalPriceLabel.text = "\(price)₺"
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func calculateCartPrice() {
        cartPrice = 0
        for foodCart in inFoodsCart {
            if let foodPrice = Int(foodCart.yemek_fiyat!), let foodPiece = Int(foodCart.yemek_siparis_adet!) {
                let price = foodPrice * foodPiece
                cartPrice += price
            }
        }
        cartPriceLabel.text = "\(cartPrice)₺"
    }
}
