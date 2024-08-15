//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Burak Özdemir on 5.08.2024.
//

import UIKit
import FirebaseAuth

class Login: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        loginButton.clipsToBounds = true
        registerButton.clipsToBounds = true
        
        navigationItem.title = getItemText()
        
        let creamColor = UIColor(red: 250/255, green: 243/255, blue: 224/255, alpha: 1.0).cgColor
        let whiteColor = UIColor.white.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [creamColor, whiteColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let emailText = emailTextField.text, let passwordText = passwordTextField.text {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) {authResult, error in
                if let e = error {
                    print("Error : \(e.localizedDescription)")
                    let alert = UIAlertController(title: "Böyle bir kullanıcı yok !", message: "Lütfen öncelikle kayıt olunuz.", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Tamam", style: .default)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                } else {
                    self.performSegue(withIdentifier: "loginToHomepage", sender: self)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToRegister", sender: self)
    }
    
    func getItemText() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 8..<12:
            return "Günaydın ☀️"
        case 12..<18:
            return "İyi Günler 👋🏻"
        case 18..<22:
            return "İyi Akşamlar 👋🏻"
        default:
            return "İyi Geceler 🌙"
        }
    }
}
