//
//  FoodOrderRepository.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import RxSwift
import Alamofire
import FirebaseAuth

class FoodOrderRepository {
    var foodsList = BehaviorSubject<[FoodContent]>(value: [FoodContent]())
    var inFoodsCart = BehaviorSubject<[CartContent]>(value: [CartContent]())
    
    func loadFoods() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let safeData = try JSONDecoder().decode(Foods.self, from: data)
                    if let food = safeData.yemekler {
                        self.foodsList.onNext(food)
                    }
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func addFoodCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params: [String: Any] = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Message : \(result.message!)")
                    print("Success : \(result.success!)")
                    self.loadCartFoods(kullanici_adi: kullanici_adi)
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadCartFoods(kullanici_adi: String) {
        let params: [String: Any] = ["kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let safeData = try JSONDecoder().decode(FoodCart.self, from: data)
                    if let cartFood = safeData.sepet_yemekler {
                        self.inFoodsCart.onNext(cartFood)
                    }
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func removeFood(sepet_yemek_id: String, kullanici_adi: String) {
        let params: [String: Any] = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.loadCartFoods(kullanici_adi: kullanici_adi)
                    }
                    print("Message : \(result.message!)")
                    print("Success : \(result.success!)")
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func searchFood(searchText: String) {
        if let allFoods = try? foodsList.value() {
            let filteredFoods = allFoods.filter { food in
                food.yemek_adi!.lowercased().contains(searchText.lowercased())
            }
            foodsList.onNext(filteredFoods)
        }
    }
}
