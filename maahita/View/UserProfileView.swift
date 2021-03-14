//
//  UserProfileView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

class UserProfileView: UIView {
    
    lazy var profilePicView: ProfilePicView = {
        let profilePic = ProfilePicView()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openUserProfile))
        gestureRecognizer.numberOfTapsRequired = 1
        profilePic.addGestureRecognizer(gestureRecognizer)
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    lazy var userName: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        name.textColor = .white
        name.text = "māhita guest"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.sizeToFit()
        return name
    }()
    
    lazy var emailID: UILabel = {
        let email = UILabel()
        email.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        email.textColor = .darkGray
        email.text = "guest email"
        email.sizeToFit()
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    lazy var isVerified: UILabel = {
        let verified = UILabel()
        verified.font = UIFont(name: "Comfortaa-Light", size: 10.0)
        verified.textColor = .cerulean
        verified.text = "Email verified"
        verified.sizeToFit()
        verified.translatesAutoresizingMaskIntoConstraints = false
        return verified
    }()
    
    lazy var loginButton: UIButton = {
        let login = UIButton()
        login.setTitle("Login", for: .normal)
        login.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .cerulean
        login.translatesAutoresizingMaskIntoConstraints = false
        login.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        return login
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UserAuthService.instance.delegates?.append(self)
        
        self.addSubview(profilePicView)
        self.addSubview(userName)
        self.addSubview(emailID)
        self.addSubview(isVerified)
        self.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            profilePicView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            profilePicView.widthAnchor.constraint(equalToConstant: 60.0),
            profilePicView.heightAnchor.constraint(equalToConstant: 60.0),
            profilePicView.centerYAnchor.constraint(equalTo: bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: profilePicView.trailingAnchor, constant: 10.0),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            userName.bottomAnchor.constraint(equalTo: profilePicView.centerYAnchor, constant: -4.0),
            emailID.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            emailID.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            emailID.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8.0),
            emailID.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            isVerified.topAnchor.constraint(equalTo: emailID.bottomAnchor, constant: 4.0),
            isVerified.leadingAnchor.constraint(equalTo: emailID.leadingAnchor),
            loginButton.centerYAnchor.constraint(equalTo: profilePicView.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 65.0),
            loginButton.heightAnchor.constraint(equalToConstant: 40.0),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
        ])
        
        self.backgroundColor = .darkGray
        self.populateUser()
    }
    
    fileprivate func populateUser() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            self.userName.text = user.displayName
            self.emailID.text = user.email
            self.loginButton.isHidden = true
            self.profilePicView.profilePicURL = user.photoURL?.absoluteString
            self.profilePicView.isUserInteractionEnabled = true
            self.isVerified.isHidden = user.isEmailVerified
            
            if !user.isEmailVerified {
                self.isVerified.textColor = .red
                self.isVerified.text = "Email not verified"
            }
        } else {
            self.userName.text = "māhita guest"
            self.emailID.text = "guest email"
            self.loginButton.isHidden = false
            self.loginButton.setTitle("Login", for: .normal)
            self.loginButton.backgroundColor = .cerulean
            self.profilePicView.profilePicURL = nil
            self.profilePicView.isUserInteractionEnabled = false
            self.isVerified.isHidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loginButton.layer.cornerRadius = 5.0
        self.loginButton.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doLogin() {
        let loginViewController = LoginViewController()
        NavigationUtility.presentOverCurrentContext(destination: loginViewController, style: .overCurrentContext, completion: nil)
    }
    
    @objc func openUserProfile() {
        let profileViewController = UserProfileViewController()
        NavigationUtility.presentOverCurrentContext(destination: profileViewController, style: .overCurrentContext, completion: nil)
    }
}

extension UserProfileView: AuthServiceDelegate {
    func refreshUser() {
        self.populateUser()
    }
}
