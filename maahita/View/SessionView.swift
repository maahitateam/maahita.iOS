//
//  SessionView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 20/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionView : UIView {
    
    lazy var sessionCalView: UIView = {
        let calView = UIView()
        calView.backgroundColor = .red
        calView.translatesAutoresizingMaskIntoConstraints = false
        return calView
    }()
    
    lazy var sessionDay: UILabel = {
        let day = UILabel()
        day.textColor = .white
        day.font = UIFont(name: "Comfortaa-Bold", size: 20.0)
        day.textAlignment = .center
        day.sizeToFit()
        day.translatesAutoresizingMaskIntoConstraints = false
        return day
    }()
    
    lazy var sessionMonth: UILabel = {
        let month = UILabel()
        month.textColor = .white
        month.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        month.textAlignment = .center
        month.translatesAutoresizingMaskIntoConstraints = false
        return month
    }()
    
    lazy var sessionTimeTzone: UILabel = {
        let time = UILabel()
        time.textColor = .darkGray
        time.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        time.textAlignment = .center
        time.sizeToFit()
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    lazy var sessionTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Bold", size: 16.0)
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.sizeToFit()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var sessionDescription: UILabel = {
        let desc = UILabel()
        desc.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        desc.numberOfLines = 0
        desc.sizeToFit()
        desc.lineBreakMode = .byWordWrapping
        desc.translatesAutoresizingMaskIntoConstraints = false
        return desc
    }()
    
    lazy var sessionPresneter: PaddingLabel = {
        let presenter = PaddingLabel(padding: 4.0)
        presenter.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        presenter.textAlignment = .right
        presenter.sizeToFit()
        presenter.translatesAutoresizingMaskIntoConstraints = false
        return presenter
    }()
    
    lazy var presenterAvatar: UIImageView = {
       let profilePic = UIImageView()
        profilePic.image = UIImage(named: "avatar")
        profilePic.backgroundColor = .white
        profilePic.contentMode = .scaleAspectFill
        profilePic.isUserInteractionEnabled = false
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    lazy var statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var statusLabel: PaddingLabel = {
        let status = PaddingLabel(padding: 2.0)
        status.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var categoryLabel: PaddingLabel = {
        let categorylabel = PaddingLabel(padding: 3.0)
        categorylabel.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        categorylabel.textColor = .white
        categorylabel.translatesAutoresizingMaskIntoConstraints = false
        return categorylabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(sessionCalView)
        sessionCalView.addSubview(sessionDay)
        sessionCalView.addSubview(sessionMonth)
        self.addSubview(sessionTimeTzone)
        self.addSubview(sessionTitle)
        self.addSubview(sessionDescription)
        self.addSubview(presenterAvatar)
        self.addSubview(sessionPresneter)
        self.addSubview(statusView)
        self.addSubview(statusLabel)
        self.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            sessionCalView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0),
            sessionCalView.topAnchor.constraint(equalTo: self.topAnchor),
            sessionCalView.widthAnchor.constraint(equalToConstant: 60.0),
            sessionCalView.heightAnchor.constraint(equalToConstant: 60.0),
            sessionDay.centerXAnchor.constraint(equalTo: sessionCalView.centerXAnchor),
            sessionMonth.leadingAnchor.constraint(equalTo: sessionCalView.leadingAnchor),
            sessionMonth.trailingAnchor.constraint(equalTo: sessionCalView.trailingAnchor),
            sessionMonth.topAnchor.constraint(equalTo: sessionDay.bottomAnchor, constant: 3.0),
            sessionMonth.bottomAnchor.constraint(equalTo: sessionCalView.bottomAnchor, constant: -5.0),
            sessionTimeTzone.leadingAnchor.constraint(equalTo: sessionCalView.trailingAnchor, constant: 8.0),
            sessionTimeTzone.centerYAnchor.constraint(equalTo: sessionMonth.centerYAnchor),
            
            sessionTitle.topAnchor.constraint(equalTo: self.sessionCalView.bottomAnchor, constant: 15.0),
            sessionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0),
            sessionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0),
            
            categoryLabel.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: sessionTitle.bottomAnchor, constant: 8.0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18.0),
            
            sessionDescription.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0),
            sessionDescription.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            sessionDescription.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            
            statusView.leadingAnchor.constraint(equalTo: self.sessionTitle.leadingAnchor),
            statusView.widthAnchor.constraint(equalToConstant: 12.0),
            statusView.heightAnchor.constraint(equalToConstant: 12.0),

            statusLabel.leadingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: 2.0),
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            
            presenterAvatar.topAnchor.constraint(equalTo: sessionDescription.bottomAnchor, constant: 15.0),
            presenterAvatar.heightAnchor.constraint(equalToConstant: 30.0),
            presenterAvatar.widthAnchor.constraint(equalTo: presenterAvatar.heightAnchor),
            presenterAvatar.centerYAnchor.constraint(equalTo: self.statusView.centerYAnchor),
            presenterAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
            
            sessionPresneter.leadingAnchor.constraint(equalTo: presenterAvatar.trailingAnchor, constant: 2.0),
            sessionPresneter.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            sessionPresneter.centerYAnchor.constraint(equalTo: self.presenterAvatar.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sessionCalView.layer.cornerRadius = 5.0
        self.sessionCalView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.sessionCalView.layer.masksToBounds = true
        self.sessionCalView.applyShadow()
        
        self.statusView.layer.cornerRadius = 6
        self.statusView.layer.masksToBounds = true
        
        self.presenterAvatar.layer.cornerRadius = 15
        self.presenterAvatar.layer.masksToBounds = true
        
        self.categoryLabel.layer.cornerRadius = 3
        self.categoryLabel.layer.masksToBounds = true
    }
}
