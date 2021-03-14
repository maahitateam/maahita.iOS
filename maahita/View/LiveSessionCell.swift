//
//  LiveSessionCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class LiveSessionCell: UICollectionViewCell {
    
    var liveSession: SessionViewModel! {
        didSet {
            liveSession?.configureLive(self)
        }
    }
    
    lazy var animationView: UIView = {
        let animation = UIView()
        animation.backgroundColor = .clear
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    lazy var liveLabel: PaddingLabel = {
        let live = PaddingLabel(padding: 3.0)
        live.font = UIFont(name: "Comfortaa-Bold", size: 10.0)
        live.textAlignment = .center
        live.textColor = .white
        live.text = "Live"
        live.backgroundColor = .red
        live.translatesAutoresizingMaskIntoConstraints = false
        return live
    }()
       
    lazy var sessionTime: UILabel = {
        let time = UILabel()
        time.textColor = .darkGray
        time.font = UIFont(name: "Comfortaa-Regular", size: 10.0)
        time.textColor = .red
        time.sizeToFit()
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
    
    lazy var sessionPresenter: UILabel = {
        let presenter = UILabel()
        presenter.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        presenter.translatesAutoresizingMaskIntoConstraints = false
        return presenter
    }()
    
    lazy var joinButton: UIButton = {
        let join = UIButton()
        join.setTitle("Join", for: .normal)
        join.setTitleColor(.red, for: .normal)
        join.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 16.0)
        join.translatesAutoresizingMaskIntoConstraints = false
        join.isUserInteractionEnabled = true
        join.addTarget(self, action: #selector(attendSession), for: .touchUpInside)
        return join
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubview(animationView)
        addSubview(liveLabel)
        addSubview(sessionTime)
        addSubview(sessionTitle)
        addSubview(sessionPresenter)
        addSubview(joinButton)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 20.0),
            animationView.heightAnchor.constraint(equalToConstant: 20.0),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            animationView.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
            liveLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor),
            liveLabel.leadingAnchor.constraint(equalTo: animationView.trailingAnchor),
            liveLabel.widthAnchor.constraint(equalToConstant: 40.0),
            sessionTime.leadingAnchor.constraint(equalTo: liveLabel.trailingAnchor, constant: 8.0),
            sessionTime.centerYAnchor.constraint(equalTo: liveLabel.centerYAnchor),
            sessionTitle.topAnchor.constraint(equalTo: liveLabel.bottomAnchor, constant: 8.0),
            sessionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            sessionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            sessionPresenter.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            sessionPresenter.topAnchor.constraint(equalTo: sessionTitle.bottomAnchor, constant: 5.0),
            sessionPresenter.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            joinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            joinButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        liveLabel.layer.cornerRadius = 5.0
        liveLabel.layer.masksToBounds = true
        
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
        
        self.addCircularShape(view: animationView, viewBounds: animationView.bounds, radius: animationView.bounds.height/2 - 5)
    }
    
    fileprivate func addCircularShape(view: UIView, viewBounds: CGRect, radius: CGFloat) {
        //Removing all existing layers
        if let layers = view.layer.sublayers {
            for (_, layer) in layers.enumerated() {
                if let name = layer.name, name.contains("Custom") {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        
        let center = CGPoint(x: viewBounds.width/2, y: viewBounds.height/2)
        
        //Adding ripple layer
        let rippleLayer = CAShapeLayer()
        rippleLayer.name = "CustomLayerRipple"
        rippleLayer.path = circularPath.cgPath
        rippleLayer.fillColor = UIColor.red.cgColor
        rippleLayer.strokeColor = UIColor.red.withAlphaComponent(0.2).cgColor
        rippleLayer.lineWidth = 5
        rippleLayer.lineCap = .round
        rippleLayer.position = center
        view.layer.insertSublayer(rippleLayer, at: 0)
        
        //Adding ripple animation
        let rippleAnimation = CABasicAnimation(keyPath: "transform.scale")
        rippleAnimation.fromValue = 0.9
        rippleAnimation.toValue = 1.1
        rippleAnimation.duration = 0.8
        rippleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rippleAnimation.autoreverses = true
        rippleAnimation.repeatCount = Float.infinity
        rippleLayer.add(rippleAnimation, forKey: "ripple")
               
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "CustomLayerScore"
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.position = center
        view.layer.insertSublayer(shapeLayer, at: 1)
    }

    @objc func attendSession() {
        let meetingViewController = MeetingViewController(sessionID: self.liveSession.id,
                                                          meetingID: self.liveSession.meetingID ?? "",
                                                          title: self.liveSession.title, groupID: self.liveSession.groupID)
        NavigationUtility.presentOverCurrentContext(destination: meetingViewController, style: .fullScreen) { [weak self] in
            meetingViewController.joinMeeting(isPresenter: self?.liveSession?.isPresenter ?? false)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = joinButton.hitTest(joinButton.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }
}
