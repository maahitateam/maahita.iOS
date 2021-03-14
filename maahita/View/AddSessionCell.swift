//
//  AddSessionCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 27/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class AddSessionCell: UICollectionViewCell {
    
    lazy var sessionTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        title.text = "Request Session"
        title.textAlignment = .center
        title.textColor = .white
        title.sizeToFit()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .cerulean
        
        addSubview(sessionTitle)
        
        NSLayoutConstraint.activate([
            sessionTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            sessionTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.cornerRadius = 10.0
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
