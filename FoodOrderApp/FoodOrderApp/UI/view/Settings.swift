//
//  Settings.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 11.08.2024.
//

import UIKit
import FirebaseAuth

class Settings: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Çıkış yapmak istediğinize emin misiniz ?", message: "", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Evet", style: .default) { alertAction in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                print("Sign out error !")
            }
        }
        let noAction = UIAlertAction(title: "Hayır", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
    }
}
