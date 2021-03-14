//
//  ProfilePicView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class ProfilePicView: UIView {
    
    var profilePicURL: String! {
        didSet {
            if let url = profilePicURL {
                self.userProfilePic.cacheImage(urlString: url)
            } else {
                self.userProfilePic.image = UIImage(named: "avatar")
            }
        }
    }
    
    var profileImage: UIImage? {
        didSet {
            self.userProfilePic.image = profileImage
        }
    }
    
    lazy var userProfilePicBg: UIView = {
       let profilePicBg = UIView()
        profilePicBg.backgroundColor = .white
        profilePicBg.isUserInteractionEnabled = false
        profilePicBg.translatesAutoresizingMaskIntoConstraints = false
        return profilePicBg
    }()
    
    lazy var userProfilePic: UIImageView = {
       let profilePic = UIImageView()
        profilePic.image = UIImage(named: "avatar")
        profilePic.backgroundColor = .white
        profilePic.contentMode = .scaleAspectFill
        profilePic.isUserInteractionEnabled = false
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(userProfilePicBg)
        userProfilePicBg.addSubview(userProfilePic)
        
        NSLayoutConstraint.activate([
            userProfilePicBg.topAnchor.constraint(equalTo: self.topAnchor),
            userProfilePicBg.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userProfilePicBg.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userProfilePicBg.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            userProfilePic.leadingAnchor.constraint(equalTo: userProfilePicBg.leadingAnchor, constant: 1.0),
            userProfilePic.trailingAnchor.constraint(equalTo: userProfilePicBg.trailingAnchor, constant: -1.0),
            userProfilePic.topAnchor.constraint(equalTo: userProfilePicBg.topAnchor, constant: 1.0),
            userProfilePic.bottomAnchor.constraint(equalTo: userProfilePicBg.bottomAnchor, constant: -1.0)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bgRadius = self.userProfilePicBg.bounds.width/2
        self.userProfilePicBg.clipsToBounds = false
        self.userProfilePicBg.layer.shadowOffset = CGSize.zero
        self.userProfilePicBg.layer.shadowRadius = 2
        self.userProfilePicBg.layer.shadowPath = UIBezierPath(roundedRect: self.userProfilePicBg.bounds, cornerRadius: bgRadius).cgPath
        self.userProfilePicBg.layer.cornerRadius = bgRadius
        self.userProfilePicBg.layer.shadowColor = UIColor.black.cgColor
        self.userProfilePicBg.layer.shadowOpacity = 0.5
        
        let photoRadius = (self.userProfilePicBg.bounds.width-4)/2
        self.userProfilePic.clipsToBounds = true
        self.userProfilePic.layer.cornerRadius = photoRadius
    }
}
