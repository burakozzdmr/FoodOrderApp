//
//  CartViewModel.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import Foundation
import RxSwift

class CartViewModel {
    var frepo = FoodOrderRepository()
    var inFoodsCart = BehaviorSubject<[CartContent]>(value: [CartContent]())
    
    init() {
        inFoodsCart = frepo.inFoodsCart
        loadCartContent(kullanici_adi: "burak_ozdemir")
    }
    
    func loadCartContent(kullanici_adi: String) {
        frepo.loadCartFoods(kullanici_adi: kullanici_adi)
    }
    
    func removeFood(sepet_yemek_id: String, kullanici_adi: String) {
        frepo.removeFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}
