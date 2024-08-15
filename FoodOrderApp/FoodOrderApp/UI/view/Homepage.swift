//
//  Homepage.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import Kingfisher

class Homepage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodsCollectionView: UICollectionView!
    
    var viewModel = HomepageViewModel()
    var foodsList = [FoodContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodsCollectionView.delegate = self
        foodsCollectionView.dataSource = self
        
        _ = viewModel.foodsList.subscribe(onNext: { list in
            self.foodsList = list
            DispatchQueue.main.async {
                self.foodsCollectionView.reloadData()
            }
        })
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        let viewWidth = UIScreen.main.bounds.width
        let itemWidth = (viewWidth - 80) / 2
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        foodsCollectionView.collectionViewLayout = flowLayout
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "miniViewColor")
        
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.scrollEdgeAppearance = appearance
    }
    

}

extension Homepage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        cell.foodNameLabel.text = food.yemek_adi
        cell.foodPriceLabel.text = "\(food.yemek_fiyat!)₺"
        cell.foodContent = food
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
           cell.foodImageView.kf.setImage(with: url)
        }
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.backgroundColor = UIColor(named: "cellColor")
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodsList[indexPath.row]
        performSegue(withIdentifier: "homepageToDetail", sender: food)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homepageToDetail" {
            if let safeSender = sender as? FoodContent {
                if let navigationController = segue.destination as? UINavigationController {
                    if let destinationVC = navigationController.topViewController as? FoodDetail {
                        destinationVC.foodContent = safeSender
                    }
                }
            }
        }
    }
}

extension Homepage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.loadFoods()
        } else {
            viewModel.searchFood(searchText: searchText)
        }
    }
}

extension Homepage: SegueDelegate {
    func performingSegue(withIdentifier: String, sender: Any?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
