//
//  SessionFeedbackView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/08/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionFeedbackView : UIView {
    
    var sessionID: String?
    var groupID: String?
    
    var feedbackQuestions: [Feedback]! {
        didSet {
            DispatchQueue.main.async {
                self.feedbackTable.reloadData()
            }
        }
    }
    
    lazy var feedbackTable: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.backgroundColor = .clear
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var submitBackground: UIView = {
        let  submitbg = UIView()
        submitbg.backgroundColor = .cerulean
        submitbg.translatesAutoresizingMaskIntoConstraints = false
        return submitbg
    }()
    
    lazy var submitButton: UIButton = {
        let submit = UIButton()
        submit.setTitle("Send", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        submit.tintColor = .white
        submit.sizeToFit()
        submit.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        submit.translatesAutoresizingMaskIntoConstraints = false
        return submit
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(feedbackTable)
        self.addSubview(submitBackground)
        self.submitBackground.addSubview(submitButton)
        
         let height = UIDevice.hasNotch ? 20.0 : 0.0
        
        NSLayoutConstraint.activate([
            feedbackTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedbackTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            feedbackTable.topAnchor.constraint(equalTo: topAnchor),
            feedbackTable.bottomAnchor.constraint(equalTo: bottomAnchor),
            submitBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -1.0),
            submitBackground.heightAnchor.constraint(equalToConstant: 50.0),
            submitBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            submitBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-(height + 20.0))),
            submitButton.centerYAnchor.constraint(equalTo: submitBackground.centerYAnchor),
            submitButton.trailingAnchor.constraint(equalTo: submitBackground.trailingAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 120.0)
        ])
        
        FeedbackService.instance.getQuestions { (feedback) in
            self.feedbackQuestions = feedback
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.submitBackground.layer.borderColor = UIColor.white.cgColor
        self.submitBackground.layer.borderWidth = 1.0
        self.submitBackground.layer.cornerRadius = 10.0
        self.submitBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.submitBackground.layer.masksToBounds = true
        self.submitBackground.layer.shadowColor = UIColor.black.cgColor
        self.submitBackground.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.submitBackground.layer.cornerRadius = 10.0
        self.submitBackground.layer.shadowRadius = 1.0
        self.submitBackground.layer.shadowOpacity = 0.25
        self.submitBackground.layer.masksToBounds = false
        self.submitBackground.layer.shadowPath = UIBezierPath(roundedRect: self.submitBackground.bounds, cornerRadius: self.submitBackground.layer.cornerRadius).cgPath
    }
}

extension SessionFeedbackView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedbackQuestions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(with: FeedbackCell.self, at: indexPath) as? FeedbackCell else {
            preconditionFailure("Invalid cell type")
        }
        cell.feedback = self.feedbackQuestions[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func setup(sessionID: String?, groupID: String?) {
        self.sessionID = sessionID
        self.groupID = groupID
    }
    
    @objc func submitForm() {
        FeedbackService.instance.submitFeedback(sessionID: self.sessionID!, groupID: self.groupID, feedback: self.feedbackQuestions) { (submitted) in
            if submitted {
                NavigationUtility.popViewController()
            } else {
                MaahitaAlertView.instance.showError(message: "Oops... something went wrong. Please try again later") { [weak self] in
                    NavigationUtility.popViewController()
                }
            }
        }
    }
}

extension SessionFeedbackView: FeedbackCellDelegate {
    func updateFeedback(feedback: Feedback) {
        
        for (index, element) in self.feedbackQuestions.enumerated() {
            if element.id == feedback.id
            {
                self.feedbackQuestions[index].value = feedback.value
            }
        }
    }
}
