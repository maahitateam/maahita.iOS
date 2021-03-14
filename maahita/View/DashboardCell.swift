//
//  DashboardCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    
    var dashboardViewModel: DashboardViewModel! {
        didSet {
            self.dashboardViewModel.configure(self)
        }
    }
    
    lazy var statsView: StatsView = {
        let statsview = StatsView()
        statsview.translatesAutoresizingMaskIntoConstraints = false
        return statsview
    }()
    
    lazy var cellHeader: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        title.text = "Dashboard"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white

        addSubview(cellHeader)
        addSubview(statsView)
        
        NSLayoutConstraint.activate([
            cellHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            cellHeader.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
            cellHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            cellHeader.heightAnchor.constraint(equalToConstant: 20.0),
            statsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            statsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            statsView.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: 8.0),
            statsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
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
