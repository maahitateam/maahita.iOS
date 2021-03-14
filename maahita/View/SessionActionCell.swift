//
//  SessionActionCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 30/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionActionCell: UICollectionViewCell {
    
    lazy var actionTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12.0)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(actionTitle)
        
        NSLayoutConstraint.activate([
            actionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2.0),
            actionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2.0),
            actionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 2.0),
            actionTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, titleColor: UIColor, bgColor: UIColor = .white) {
        self.actionTitle.text = title
        self.actionTitle.textColor = titleColor
        self.backgroundColor = bgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 3.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.cornerRadius = 3.0
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
