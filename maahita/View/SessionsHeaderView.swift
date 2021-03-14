//
//  SessionsHeaderView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionsHeaderView: UICollectionReusableView {
      
    lazy var collectionView: SessionsHeaderCollectionView = {
        let collectionview = SessionsHeaderCollectionView()
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var userProfileView: UserProfileView = {
        let profileView = UserProfileView()
        profileView.backgroundColor = .darkGray
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    lazy var profilePlaceHolder: UIView = {
        let placeholder = UIView()
        placeholder.backgroundColor = .white
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()
    
    lazy var headerLabel: UILabel = {
        let header = UILabel()
        header.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        header.text = "Sessions"
        header.sizeToFit()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubview(profilePlaceHolder)
        addSubview(collectionView)
        addSubview(userProfileView)
                
        let height = UIDevice.hasNotch ? 25.0 : 0.0
        
        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: topAnchor),
            userProfileView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userProfileView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userProfileView.heightAnchor.constraint(equalToConstant: CGFloat(60 + height)),
            collectionView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 40.0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        profilePlaceHolder.layer.shadowColor = UIColor.black.cgColor
        profilePlaceHolder.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        profilePlaceHolder.layer.shadowRadius = 2.0
        profilePlaceHolder.layer.shadowOpacity = 0.25
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.25
    }
}
