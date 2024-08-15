//
//  Register.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import FirebaseAuth

class Register: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var login = Login()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        registerButton.clipsToBounds = true
        
        navigationItem.title = login.getItemText()
        
        let creamColor = UIColor(red: 250/255, green: 243/255, blue: 224/255, alpha: 1.0).cgColor
        let whiteColor = UIColor.white.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [creamColor, whiteColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        if let emailText = emailTextField.text, let passwordText = passwordTextField.text {
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
                if let e = error {
                    print("Error : \(e.localizedDescription)")
                    let alert = UIAlertController(title: "Kullanıcı kaydı başarısız !", message: "", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "Tekrar Dene", style: .default)
                    alert.addAction(tryAgainAction)
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Kullanıcı kaydı başarılı !", message: "Aramıza hoşgeldin :)", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Tamam", style: .default) { alertAction in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
