//
//  FeedbackCell.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

protocol FeedbackCellDelegate {
    func updateFeedback(feedback: Feedback)
}

class FeedbackCell: UITableViewCell {

    var delegate: FeedbackCellDelegate?
    
    var feedback: Feedback! {
        didSet {
            self.feedbackQuestion.text = feedback.name
            self.feedbackView.rating = feedback.value
        }
    }
    
    lazy var feedbackQuestion: UILabel = {
        let presenter = UILabel()
        presenter.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        presenter.textColor = .darkGray
        presenter.sizeToFit()
        presenter.translatesAutoresizingMaskIntoConstraints = false
        return presenter
    }()
    
    lazy var feedbackView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.fillMode = StarFillMode.half.rawValue
        cosmosView.starSize = 30.0
        cosmosView.starMargin = 5.0
        cosmosView.didFinishTouchingCosmos = didTouchCosmos
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        return cosmosView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        addSubview(feedbackQuestion)
        addSubview(feedbackView)
        
        NSLayoutConstraint.activate([
            feedbackQuestion.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            feedbackQuestion.trailingAnchor.constraint(equalTo: trailingAnchor),
            feedbackQuestion.topAnchor.constraint(equalTo: topAnchor),
            feedbackView.topAnchor.constraint(equalTo: feedbackQuestion.bottomAnchor, constant: 10.0),
            feedbackView.leadingAnchor.constraint(equalTo: feedbackQuestion.centerXAnchor, constant: -20.0),
            feedbackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            feedbackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didTouchCosmos(_ rating: Double) {
        self.feedback.value = rating
        self.delegate?.updateFeedback(feedback: self.feedback)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = feedbackView.hitTest(feedbackView.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }
}

