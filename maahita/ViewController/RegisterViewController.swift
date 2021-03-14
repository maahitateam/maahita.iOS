//
//  RegisterViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

protocol RegisterUserDelegate {
    func registered()
}

class RegisterViewController: PanCloseViewController {
    
    var delegate: RegisterUserDelegate?
    
    lazy var logoImage: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "maahita")
        logoView.contentMode = .scaleAspectFit
        logoView.tintColor = .darkGray
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    lazy var appName: UILabel = {
        let name = UILabel()
        name.text = "māhita"
        name.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        name.textAlignment = .center
        name.textColor = .darkGray
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var fullName: UITextField = {
        let name = UITextField()
        name.setLeftView(image: UIImage(named: "nametag")!)
        name.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        name.clearButtonMode = .whileEditing
        name.textContentType = .emailAddress
        name.placeholder = "Full Name"
        name.autocorrectionType = .no
        name.returnKeyType = .next
        name.borderStyle = .roundedRect
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var emailID: UITextField = {
        let email = UITextField()
        email.setLeftView(image: UIImage(named: "envelope")!)
        email.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        email.clearButtonMode = .whileEditing
        email.textContentType = .emailAddress
        email.placeholder = "Email ID"
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .none
        email.autocorrectionType = .no
        email.returnKeyType = .next
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    lazy var password: UITextField = {
        let passwd = UITextField()
        passwd.setLeftView(image: UIImage(named: "lock")!)
        passwd.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        passwd.clearButtonMode = .whileEditing
        passwd.placeholder = "Password"
        passwd.returnKeyType = .done
        passwd.isSecureTextEntry = true
        passwd.borderStyle = .roundedRect
        passwd.translatesAutoresizingMaskIntoConstraints = false
        return passwd
    }()
    
    lazy var confirmPassword: UITextField = {
        let passwd = UITextField()
        passwd.setLeftView(image: UIImage(named: "lock")!)
        passwd.setRightView(image: UIImage(named: "show-password")!)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleHideShow))
        gestureRecognizer.numberOfTapsRequired = 1
        passwd.rightView?.addGestureRecognizer(gestureRecognizer)
        passwd.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        passwd.clearButtonMode = .whileEditing
        passwd.placeholder = "Confirm Password"
        passwd.returnKeyType = .done
        passwd.isSecureTextEntry = true
        passwd.borderStyle = .roundedRect
        passwd.translatesAutoresizingMaskIntoConstraints = false
        return passwd
    }()

    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Comfortaa-Regular", size: 15.0)
        label.text = "Do you already have an account with us?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let login = UIButton()
        login.setTitle("Register", for: .normal)
        login.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 15.0)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .red
        login.addTarget(self, action: #selector(doRegister), for: .touchUpInside)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    lazy var loginButton: UIButton = {
        let login = UIButton()
        login.setTitle("Login", for: .normal)
        login.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 15.0)
        login.setTitleColor(.cerulean, for: .normal)
        login.addTarget(self, action: #selector(backtoLogin), for: .touchUpInside)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(self.fullName)
        self.containerView.addSubview(self.emailID)
        self.containerView.addSubview(self.password)
        self.containerView.addSubview(self.confirmPassword)
        self.containerView.addSubview(self.errorLabel)
        self.containerView.addSubview(self.registerButton)
        self.view.addSubview(self.logoImage)
        self.view.addSubview(self.appName)
        self.view.addSubview(self.infoLabel)
        self.view.addSubview(self.loginButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.fullName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.fullName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.fullName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0),
            self.fullName.heightAnchor.constraint(equalToConstant: 40.0),
            self.emailID.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.emailID.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.emailID.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 10.0),
            self.emailID.heightAnchor.constraint(equalToConstant: 40.0),
            self.password.topAnchor.constraint(equalTo: self.emailID.bottomAnchor, constant: 10.0),
            self.password.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.password.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.confirmPassword.heightAnchor.constraint(equalToConstant: 40.0),
            self.confirmPassword.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 10.0),
            self.confirmPassword.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.confirmPassword.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.confirmPassword.heightAnchor.constraint(equalToConstant: 40.0),
            self.errorLabel.topAnchor.constraint(equalTo: self.confirmPassword.bottomAnchor, constant: 10.0),
            self.errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.registerButton.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 10.0),
            self.registerButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.registerButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.registerButton.heightAnchor.constraint(equalToConstant: 45.0),
            self.registerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10.0),
            self.appName.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -10.0),
            self.appName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100.0),
            self.logoImage.widthAnchor.constraint(equalToConstant: 100.0),
            self.logoImage.bottomAnchor.constraint(equalTo: self.appName.topAnchor, constant: -10.0),
            self.logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.infoLabel.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20.0),
            self.infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loginButton.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 10.0),
            self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.fullName.delegate = self
        self.emailID.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.registerButton.layer.cornerRadius = 10.0
        self.registerButton.layer.masksToBounds = true
        
        self.containerView.layer.cornerRadius = 10.0
        self.containerView.layer.masksToBounds = true
        
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.containerView.layer.cornerRadius = 10.0
        self.containerView.layer.shadowRadius = 2.0
        self.containerView.layer.shadowOpacity = 0.25
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.shadowPath = UIBezierPath(roundedRect: self.containerView.bounds, cornerRadius: self.containerView.layer.cornerRadius).cgPath
    }
    
    @objc func doRegister() {
        if  let displayname = self.fullName.text, let username = self.emailID.text,
            let password = self.password.text, let confpassword = self.confirmPassword.text,
            !displayname.isEmpty, !username.isEmpty, !password.isEmpty, !confpassword.isEmpty {
            
            if password != confpassword {
                self.errorLabel.text = "Passwords are not matching"
                return
            }
            
            UserAuthService.instance.register(fullName: displayname, email: username, password: password) { (success, error) in
                if(success) {
                    let logoutAlert = UIAlertController(title: "Welcome", message: "Thanks for registering with us. Hope you will have a great learning experience with us.", preferredStyle: .alert)

                    logoutAlert.addAction(UIAlertAction(title: "Let's go", style: .default, handler: { (action: UIAlertAction!) in
                        self.dismiss(animated: true) {
                            self.delegate?.registered()
                        }
                    }))
                    self.present(logoutAlert, animated: true, completion: nil)
                } else {
                    self.errorLabel.text = error?.localizedDescription
                }
            }
        }
        else {
            self.errorLabel.text = "All fields are mandatory"
        }
    }
    
    @objc func backtoLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleHideShow() {
        self.confirmPassword.isSecureTextEntry = !self.confirmPassword.isSecureTextEntry
        let imageName = self.confirmPassword.isSecureTextEntry ? "show-password" : "hide-password"
        self.confirmPassword.setRightView(image: UIImage(named: imageName)!)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleHideShow))
        gestureRecognizer.numberOfTapsRequired = 1
        self.confirmPassword.rightView?.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.fullName {
            return self.emailID.becomeFirstResponder()
        } else if textField == self.emailID {
            return self.password.becomeFirstResponder()
        } else if textField == self.password {
            self.confirmPassword.becomeFirstResponder()
        } else if textField == self.confirmPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
