//
//  ProgressViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 19/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

enum PopupType {
    case Error
    case Warning
    case Info
    case Confirmation
    case Progress
}

class AlertViewController: UIViewController {
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blur = UIVisualEffectView(effect: effect)
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blur.backgroundColor = UIColor.ceruleanThree.withAlphaComponent(0.30)
        blur.alpha = 0.55
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    lazy var progressBGView: UIView = {
        let progressbg = UIView()
        progressbg.backgroundColor = .white
        progressbg.translatesAutoresizingMaskIntoConstraints = false
        progressbg.layer.cornerRadius = 10.0
        progressbg.layer.shadowColor = UIColor.black.cgColor
        progressbg.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        progressbg.layer.cornerRadius = 10.0
        progressbg.layer.shadowRadius = 2.0
        progressbg.layer.shadowOpacity = 0.25
        progressbg.layer.masksToBounds = false
        progressbg.layer.shadowPath = UIBezierPath(roundedRect: progressbg.bounds, cornerRadius: progressbg.layer.cornerRadius).cgPath
        return progressbg
    }()
    
    lazy var progressAnimation: UIProgressView = {
        let animation = UIProgressView()
        animation.progressTintColor = .lightGray
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    init(popupType: PopupType) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.view.addSubview(blurView)
        self.view.addSubview(progressBGView)
        self.view.addSubview(progressAnimation)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            progressBGView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progressBGView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            progressBGView.heightAnchor.constraint(equalToConstant: 200.0),
            progressBGView.widthAnchor.constraint(equalTo: progressBGView.heightAnchor),
            progressAnimation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progressAnimation.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            progressAnimation.heightAnchor.constraint(equalToConstant: 80.0),
            progressBGView.widthAnchor.constraint(equalTo: progressAnimation.heightAnchor)
        ])
    }
}
