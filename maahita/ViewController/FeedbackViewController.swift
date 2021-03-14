//
//  FeedbackViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 21/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

class FeedbackViewController: UITableView {
    
//    let dataSource = SessionFeedbackDataSource()
    
//    lazy var viewModel : FeedbackViewModel = {
//        let viewModel = FeedbackViewModel(dataSource: dataSource)
//        return viewModel
//    }()
    
    var authService: UserAuthService?
    
    init(sessionID: String) {
        super.init(frame: CGRect.zero, style: .grouped)
        backgroundColor = .clear
        let source = SessionFeedbackDataSource()
        dataSource = source
        delegate = source
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    lazy var sessionTitleView: SessionView = {
//        let sessView = SessionView()
//        sessView.translatesAutoresizingMaskIntoConstraints = false
//        return sessView
//    }()
    
//    lazy var actionButton: UIButton = {
//        let action = UIButton()
//        action.setTitle("Submit", for: .normal)
//        action.backgroundColor = .cerulean
//        action.setTitleColor(.white, for: .normal)
//        action.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
//        action.translatesAutoresizingMaskIntoConstraints = false
//        action.addTarget(self, action: #selector(doSubmit), for: .touchUpInside)
//        return action
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if #available(iOS 13.0, *) {
//            self.view.backgroundColor = .systemGroupedBackground
//        } else {
//            self.view.backgroundColor = .groupTableViewBackground
//            self.isSwipable()
//        }
//
//        self.tableView.dataSource = self.dataSource
//        self.tableView.delegate = self.dataSource
//        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
//        self.tableView.estimatedSectionHeaderHeight = 100
        
//        self.view.addSubview(sessionTitleView)
//        self.view.addSubview(actionButton)
//
//        NSLayoutConstraint.activate([
//            sessionTitleView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            sessionTitleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            sessionTitleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//
//            actionButton.topAnchor.constraint(equalTo: sessionTitleView.bottomAnchor, constant: 30.0),
//            actionButton.heightAnchor.constraint(equalToConstant: 50.0),
//            actionButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 2),
//            actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//        ])
        
//        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
//            self?.tableView.reloadData()
//        }
//    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        self.sessionTitleView.layer.cornerRadius = 10.0
//        self.sessionTitleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//
//        self.sessionTitleView.applyShadow()
//
//        self.actionButton.layer.cornerRadius = 10.0
//        self.actionButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
//
//        self.actionButton.applyShadow()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setNeedsStatusBarAppearanceUpdate()
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
//
//    @objc func doSubmit() {
//
//    }
}
