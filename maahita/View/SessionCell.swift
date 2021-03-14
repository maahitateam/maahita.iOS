//
//  SessionCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionCell: UICollectionViewCell, SessionViewProtocol {
    
    var maahitaSession: SessionViewModel! {
        didSet {
            maahitaSession.configure(self)
        }
    }
    
    lazy var sessionCalView: UIView = {
        let calView = UIView()
        calView.backgroundColor = .red
        calView.translatesAutoresizingMaskIntoConstraints = false
        return calView
    }()
    
    lazy var sessionTimeTzone: UILabel = {
        return UILabel()
    }()
    
    lazy var sessionDay: UILabel = {
        let day = UILabel()
        day.textColor = .white
        day.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        day.textAlignment = .center
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
    
    lazy var sessionTime: UILabel = {
        let time = UILabel()
        time.textColor = .darkGray
        time.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        time.textAlignment = .center
        time.numberOfLines = 2
        time.lineBreakMode = .byWordWrapping
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    lazy var sessionTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var sessionDescription: UILabel = {
        let desc = UILabel()
        desc.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        desc.numberOfLines = 2
        desc.lineBreakMode = .byTruncatingTail
        desc.translatesAutoresizingMaskIntoConstraints = false
        return desc
    }()
    
    lazy var sessionPresneter: PaddingLabel = {
        let presenter = PaddingLabel(padding: 1.0)
        presenter.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        presenter.textAlignment = .right
        presenter.translatesAutoresizingMaskIntoConstraints = false
        return presenter
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
        
        addSubview(sessionCalView)
        sessionCalView.addSubview(sessionDay)
        sessionCalView.addSubview(sessionMonth)
        addSubview(sessionTime)
        addSubview(sessionTitle)
        addSubview(sessionDescription)
        addSubview(sessionPresneter)
        addSubview(statusView)
        addSubview(statusLabel)
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            sessionCalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            sessionCalView.topAnchor.constraint(equalTo: topAnchor),
            sessionCalView.widthAnchor.constraint(equalToConstant: 60.0),
            sessionCalView.heightAnchor.constraint(equalToConstant: 60.0),
            sessionDay.leadingAnchor.constraint(equalTo: sessionCalView.leadingAnchor),
            sessionDay.trailingAnchor.constraint(equalTo: sessionCalView.trailingAnchor),
            sessionDay.topAnchor.constraint(equalTo: sessionCalView.topAnchor, constant: 8.0),
            sessionMonth.leadingAnchor.constraint(equalTo: sessionCalView.leadingAnchor),
            sessionMonth.trailingAnchor.constraint(equalTo: sessionCalView.trailingAnchor),
            sessionMonth.topAnchor.constraint(equalTo: sessionDay.bottomAnchor, constant: 8.0),
            sessionTime.leadingAnchor.constraint(equalTo: sessionCalView.leadingAnchor),
            sessionTime.trailingAnchor.constraint(equalTo: sessionCalView.trailingAnchor),
            sessionTime.topAnchor.constraint(equalTo: sessionCalView.bottomAnchor, constant: 8.0),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18.0),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            sessionTitle.leadingAnchor.constraint(equalTo: sessionCalView.trailingAnchor, constant: 8.0),
            sessionTitle.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5.0),
            sessionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            sessionDescription.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            sessionDescription.topAnchor.constraint(equalTo: sessionTitle.bottomAnchor, constant: 5.0),
            sessionDescription.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            sessionPresneter.topAnchor.constraint(equalTo: sessionDescription.bottomAnchor, constant: 5.0),
            sessionPresneter.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            sessionPresneter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            statusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            statusView.widthAnchor.constraint(equalToConstant: 10.0),
            statusView.heightAnchor.constraint(equalToConstant: 10.0),
            statusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            statusLabel.leadingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: 2.0),
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusLabel.trailingAnchor.constraint(greaterThanOrEqualTo: sessionPresneter.leadingAnchor, constant: 10.0)
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
        
        self.categoryLabel.layer.cornerRadius = 3.0
        self.categoryLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.categoryLabel.layer.masksToBounds = true
        
        self.sessionCalView.layer.shadowColor = UIColor.black.cgColor
        self.sessionCalView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.sessionCalView.layer.cornerRadius = 10.0
        self.sessionCalView.layer.shadowRadius = 2.0
        self.sessionCalView.layer.shadowOpacity = 0.25
        self.sessionCalView.layer.masksToBounds = false
        self.sessionCalView.layer.shadowPath = UIBezierPath(roundedRect: self.sessionCalView.bounds, cornerRadius: self.sessionCalView.layer.cornerRadius).cgPath
        
        statusView.layer.cornerRadius = 5.0
        statusView.layer.masksToBounds = true
        
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
