//
//  FeedbackRequestCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 22/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class FeedbackRequestCell: UICollectionViewCell {
   
    var feedbackSession: SessionViewModel! {
        didSet {
            self.feedbackSession.configureFeedback(self)
        }
    }
    
    lazy var feedbackLabel: PaddingLabel = {
        let live = PaddingLabel(padding: 3.0)
        live.font = UIFont(name: "Comfortaa-Bold", size: 10.0)
        live.textAlignment = .center
        live.textColor = .white
        live.text = "Feedback"
        live.backgroundColor = .cerulean
        live.sizeToFit()
        live.translatesAutoresizingMaskIntoConstraints = false
        return live
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
    
    lazy var sessionTime: UILabel = {
        let time = UILabel()
        time.textColor = .darkGray
        time.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        time.sizeToFit()
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    lazy var submitFeedback: UIButton = {
        let join = UIButton()
        join.setTitle("Submit", for: .normal)
        join.setTitleColor(.cerulean, for: .normal)
        join.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 16.0)
        join.translatesAutoresizingMaskIntoConstraints = false
        join.addTarget(self, action: #selector(doSubmitFeedback), for: .touchUpInside)
        return join
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubview(feedbackLabel)
        addSubview(sessionTitle)
        addSubview(sessionPresenter)
        addSubview(submitFeedback)
        
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
            feedbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            feedbackLabel.widthAnchor.constraint(equalToConstant: 60.0),
            feedbackLabel.heightAnchor.constraint(equalToConstant: 20.0),
            sessionTitle.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 5.0),
            sessionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            sessionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            sessionPresenter.leadingAnchor.constraint(equalTo: sessionTitle.leadingAnchor),
            sessionPresenter.topAnchor.constraint(equalTo: sessionTitle.bottomAnchor, constant: 5.0),
            sessionPresenter.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            submitFeedback.centerYAnchor.constraint(equalTo: sessionPresenter.centerYAnchor),
            submitFeedback.trailingAnchor.constraint(equalTo: sessionTitle.trailingAnchor),
            submitFeedback.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        feedbackLabel.layer.cornerRadius = 5.0
        feedbackLabel.layer.masksToBounds = true
               
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

    @objc func doSubmitFeedback() {
        let sessionViewController = SessionViewController(sessionID: feedbackSession.id, groupID: feedbackSession.groupID, isFeedbackRequest: true)
        NavigationUtility.presentOverCurrentContext(destination: sessionViewController, style: .overCurrentContext)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = submitFeedback.hitTest(submitFeedback.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }
}

