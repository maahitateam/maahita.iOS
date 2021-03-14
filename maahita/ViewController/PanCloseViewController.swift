//
//  PanCloseViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 20/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

// Copied from internet
//
//  Interactive.swift
//  Interactive
//
//  Created by Shoaib Sarwar Cheema on 14/11/2016.
//  Copyright © 2016 The Soft Studio. All rights reserved.
//

import UIKit

class PanCloseViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "backArrow"), for: .normal)
        back.tintColor = .white
        back.setTitle("Back", for: .normal)
        back.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 15.0)
        back.setTitleColor(.white, for: .normal)
        back.centerTextAndImage(spacing: 5.0)
        back.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Medium", size: 17.0)
        title.text = "Session Request"
        title.textAlignment = .center
        title.textColor = .white
        title.sizeToFit()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var titleBackground: UIView = {
        let titleBG = UIView()
        titleBG.backgroundColor = .darkGray
        titleBG.translatesAutoresizingMaskIntoConstraints = false
        return titleBG
    }()
    
    let height = UIDevice.hasNotch ? 20.0 : 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGroupedBackground
        } else {
            self.view.backgroundColor = .groupTableViewBackground
        }
        
        self.view.addSubview(titleBackground)
        self.titleBackground.addSubview(backButton)
        self.titleBackground.addSubview(titleLabel)
        
        
        
        NSLayoutConstraint.activate([
            titleBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            titleBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
            titleBackground.heightAnchor.constraint(equalToConstant: CGFloat(60 + height)),
            backButton.heightAnchor.constraint(equalToConstant: 25.0),
            backButton.topAnchor.constraint(equalTo: self.titleBackground.topAnchor, constant: CGFloat(height + 25.0)),
            backButton.leadingAnchor.constraint(equalTo: self.titleBackground.leadingAnchor, constant: 20.0),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.titleBackground.centerXAnchor)])
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
