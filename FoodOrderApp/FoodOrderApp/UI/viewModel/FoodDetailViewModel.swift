//
//  FoodDetailViewModel.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import Foundation

class FoodDetailViewModel {
    var frepo = FoodOrderRepository()
    
    func addFoodCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        frepo.addFoodCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
}
