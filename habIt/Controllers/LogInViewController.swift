//
//  ViewController.swift
//  habIt
//
//  Created by kjhfsjdgfhk on 21.03.2021.
//

import UIKit
import PinLayout
import FirebaseAuth
import Foundation

class LogInViewController: UIViewController {
    private let containerView = UIView()
    private let labelLogIn = UILabel()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let signupButton = UIButton()
    private let emailboxImage1 = UIImageView()  // Овальная штуковина за надписью Email
    private let emailboxImage2 = UIImageView()
    private let forgotlabel = UILabel()  //Забыли пароль?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 249/255, green: 255/255, blue: 255/255, alpha: 1)
        
        loginButton.layer.cornerRadius = 25
        loginButton.layer.masksToBounds = true
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = UIColor(red: 134/255, green: 213/255, blue: 238/255, alpha: 1)
        loginButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 18)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        signupButton.layer.cornerRadius = 25
        signupButton.layer.masksToBounds = true
        signupButton.setTitle("Еще нет аккаунта?", for: .normal)
        signupButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        signupButton.layer.borderWidth = 3
        signupButton.layer.borderColor = CGColor(red: 77/255, green: 185/255, blue: 219/255, alpha: 1)
        signupButton.backgroundColor = UIColor(red: 249/255, green: 255/255, blue: 255/255, alpha: 1)
        signupButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 18)
        signupButton.addTarget(self, action: #selector(toSignupButtonPressed), for: .touchUpInside)

        
        
        forgotlabel.text = "Забыли пароль?"
        forgotlabel.font = .systemFont(ofSize: 15)
        forgotlabel.textColor = UIColor(red: 123/255, green: 124/255, blue: 124/255, alpha: 1)
        forgotlabel.font = UIFont(name: "Lato-Regular", size: 15)
        
        
        labelLogIn.text = "Вход"
        labelLogIn.font = .systemFont(ofSize: 30)
        labelLogIn.font = UIFont(name: "Lato-Regular", size: 30)
        
        
        emailField.placeholder = "Email"
        emailField.autocapitalizationType = .none
        emailField.leftViewMode = .always
        emailField.textColor = UIColor(red: 42/255, green: 43/255, blue: 43/255, alpha: 1)
        emailField.font = UIFont(name: "Lato-Regular", size: 18)
        
        
        emailboxImage1.image = UIImage(named: "TypingBox")
        emailboxImage2.image = UIImage(named: "TypingBox")
        
        
        passwordField.placeholder = "Пароль"
        passwordField.autocapitalizationType = .none
        passwordField.leftViewMode = .always
        passwordField.font = UIFont(name: "Lato-Regular", size: 18)
        passwordField.isSecureTextEntry.toggle() //делает пароль невидимым
        
        [emailField, labelLogIn, passwordField, loginButton, signupButton, emailboxImage1, emailboxImage2, forgotlabel].forEach { view.addSubview($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        labelLogIn.pin
            .hCenter()
            .bottom(541)
            .sizeToFit()
        
        emailField.pin
            .hCenter()
            .bottom(461)
            .width(245)
            .height(50)
        
        emailboxImage1.pin
            .width(280)
            .height(50)
            .hCenter()
            .bottom(461)
        
        emailboxImage2.pin
            .width(280)
            .height(50)
            .hCenter()
            .bottom(391)
        
        passwordField.pin
            .hCenter()
            .bottom(391)
            .width(245)
            .height(50)
        
        forgotlabel.pin
            .bottom(358)
            .hCenter()
            .sizeToFit()
        
        loginButton.pin
            .hCenter()
            .bottom(278)
            .width(220)
            .height(50)
        
        signupButton.pin
            .bottom(138)
            .hCenter()
            .height(50)
            .width(290)
    }
    
    
    // функция которая логинит пользователя при нажатии на кнопку войти и выкидывает поп ап при ошибке
    // при успешном логине переходит на главную
    @objc
    private func loginButtonPressed() {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult,error in
                if let err = error {
                    self.showAlert(message: err.localizedDescription)
                } else {
                    //Navigate to the main view controller
                    let mainVC = MainViewController()
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //переход на экран регистрации при нажатии кнопки "Еще нет аккаунта?"
    @objc func toSignupButtonPressed() {
        //let signUpVC = MainView()
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    
    //показывает pop up window с ошибкой
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
