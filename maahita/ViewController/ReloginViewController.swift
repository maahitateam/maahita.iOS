//
//  ReloginViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 16/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

protocol ReloginViewDelegate {
    func relogin(authenticated: Bool, isdelete: Bool)
}

class ReloginViewController: PanCloseViewController {
    
    var isDeleteAccount: Bool = false
    
    var delegate: ReloginViewDelegate?
    
    lazy var reloginInfo: UILabel = {
        let name = UILabel()
        name.text = "We need to make sure it is from you. Please provide your email and password"
        name.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        name.textAlignment = .center
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
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
    
    lazy var emailID: UITextField = {
        let email = UITextField()
        email.setLeftView(image: UIImage(named: "envelope")!)
        email.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        email.clearButtonMode = .whileEditing
        email.textContentType = .emailAddress
        email.placeholder = "Email ID"
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        email.autocapitalizationType = .none
        email.autocorrectionType = .no
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    lazy var password: UITextField = {
        let passwd = UITextField()
        passwd.setLeftView(image: UIImage(named: "lock")!)
        passwd.setRightView(image: UIImage(named: "show-password")!)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleHideShow))
        gestureRecognizer.numberOfTapsRequired = 1
        passwd.rightView?.addGestureRecognizer(gestureRecognizer)
        passwd.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        passwd.clearButtonMode = .whileEditing
        passwd.placeholder = "Password"
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
    
    lazy var loginButton: UIButton = {
        let login = UIButton()
        login.setTitle("Login", for: .normal)
        login.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 15.0)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .cerulean
        login.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(self.emailID)
        self.containerView.addSubview(self.password)
        self.containerView.addSubview(self.errorLabel)
        self.containerView.addSubview(self.loginButton)
        self.view.addSubview(self.reloginInfo)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.emailID.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.emailID.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.emailID.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0),
            self.emailID.heightAnchor.constraint(equalToConstant: 40.0),
            self.password.topAnchor.constraint(equalTo: self.emailID.bottomAnchor, constant: 10.0),
            self.password.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.password.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.password.heightAnchor.constraint(equalToConstant: 40.0),
            self.errorLabel.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 10.0),
            self.errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.loginButton.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 10.0),
            self.loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            self.loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            self.loginButton.heightAnchor.constraint(equalToConstant: 45.0),
            self.loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10.0),
            self.reloginInfo.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -10.0),
            self.reloginInfo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            self.reloginInfo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0)
        ])
        
        self.emailID.delegate = self
        self.password.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.loginButton.layer.cornerRadius = 10.0
        self.loginButton.layer.masksToBounds = true
        
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
    
    @objc func doLogin() {
        if let username = self.emailID.text,
            let password = self.password.text,
            !username.isEmpty, !password.isEmpty {
            UserAuthService.instance.relogin(email: username, password: password) { (success, error) in
                if(success) {
                    self.delegate?.relogin(authenticated: true, isdelete: self.isDeleteAccount)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.errorLabel.text = error?.localizedDescription
                }
            }
        }
        else {
            self.errorLabel.text = "Email and Password are not given"
        }
    }
    
    @objc func toggleHideShow() {
        self.password.isSecureTextEntry = !self.password.isSecureTextEntry
        let imageName = self.password.isSecureTextEntry ? "show-password" : "hide-password"
        self.password.setRightView(image: UIImage(named: imageName)!)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleHideShow))
        gestureRecognizer.numberOfTapsRequired = 1
        self.password.rightView?.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension ReloginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailID {
            return self.password.becomeFirstResponder()
        } else if textField == self.password {
            textField.resignFirstResponder()
        }
        return true
    }
}
