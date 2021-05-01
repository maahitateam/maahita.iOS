//
//  SessionViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase


class SessionViewController: PanCloseViewController {

    var sessionViewModel : SessionDetailViewModel? {
        didSet {
            self.updateUI()
        }
    }
    
    var authService: UserAuthService?
    
    var isFeedbackRequest = false
    
    var sessionID: String?
    var groupID: String?
    
    init(sessionID: String, groupID: String?, isFeedbackRequest: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        self.authService = UserAuthService.instance
        self.authService?.delegates?.append(self)
        
        self.titleLabel.text = "Details"
        
        SessionsService.instance.sessionDelegate = self
        SessionsService.instance.get(sessionID: sessionID, groupID: groupID)
        self.isFeedbackRequest = isFeedbackRequest
        
        if self.isFeedbackRequest {
            self.titleLabel.text = "Feedback Request"
        }
        
        self.sessionID = sessionID
        self.groupID = groupID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var sessionTitleView: SessionView = {
        let sessView = SessionView()
        sessView.translatesAutoresizingMaskIntoConstraints = false
        return sessView
    }()
    
    lazy var sessionControl: SessionPresenterControl = {
        let control = SessionPresenterControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var sessionFeedback: SessionFeedbackView = {
        let feedbackview = SessionFeedbackView()
        feedbackview.translatesAutoresizingMaskIntoConstraints = false
        return feedbackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(sessionTitleView)
        
        if self.isFeedbackRequest {
            self.view.addSubview(sessionFeedback)
            self.sessionFeedback.setup(sessionID: self.sessionID, groupID: self.groupID)
        } else {
            self.sessionControl.delegate = self
            self.view.addSubview(sessionControl)
        }
        
        NSLayoutConstraint.activate([
            sessionTitleView.topAnchor.constraint(equalTo: self.titleBackground.bottomAnchor),
            sessionTitleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sessionTitleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
        ])
        
        if self.isFeedbackRequest {
            NSLayoutConstraint.activate([
                sessionFeedback.topAnchor.constraint(equalTo: sessionTitleView.bottomAnchor),
                sessionFeedback.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                sessionFeedback.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                sessionFeedback.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                sessionControl.topAnchor.constraint(equalTo: sessionTitleView.bottomAnchor),
                sessionControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                sessionControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                sessionControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.sessionTitleView.layer.cornerRadius = 10.0
        self.sessionTitleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        self.sessionTitleView.applyShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension SessionViewController: AuthServiceDelegate {
    
    func refreshUser() {
        self.updateUI()
    }

    fileprivate func updateUI() {
        sessionViewModel?.configure(self.sessionTitleView)
        sessionControl.sessionViewModel = self.sessionViewModel
    }
}

extension SessionViewController: SessionDelegate {
    func refresh(session: MaahitaSession?) {
        if let session = session {
            self.sessionViewModel = SessionDetailViewModel(session: session)
        }
    }
}

extension SessionViewController: SessionPresenterControlDelegate {
    func doShare() {
        var sharemessage = [Any]()
        if sessionViewModel?.isPresenter ?? false {
            sharemessage.append("Hey, I am giving a session on ")
        } else {
            sharemessage.append("Hey, I found a session on ")
        }
        let screenshot = self.sessionTitleView.takeScreenshot()
        sharemessage.append(screenshot)
        sharemessage.append("Topic : \(sessionViewModel?.title ?? "")")
        sharemessage.append("Date : \(sessionViewModel?.day ?? "") \(sessionViewModel?.monthtime ?? "")")
        sharemessage.append("Do check out māhita app for details.")

        //Generate DeepLink
        let dynamicLink = "https://mobile.maahita.com/sess?=\(sessionViewModel?.id ?? "")"
        guard let link = URL(string: dynamicLink) else { return }
        let dynamicLinksDomainURIPrefix = "https://mobile.maahita.com"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.mobile.maahita")
        linkBuilder?.iOSParameters?.appStoreID = "1513759832"
        linkBuilder?.iOSParameters?.minimumAppVersion = "1.2"
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.mobile.maahita")
        linkBuilder?.androidParameters?.minimumVersion = 10

        linkBuilder?.options = DynamicLinkComponentsOptions()
        linkBuilder?.options?.pathLength = .short

        linkBuilder?.shorten(completion: { [weak self] (url, warnings, error) in
            sharemessage.append(url!)
            let activityVC = UIActivityViewController(activityItems: sharemessage, applicationActivities: nil)
            activityVC.title = "Share Session"
            activityVC.excludedActivityTypes = [.print, .airDrop, .assignToContact, .copyToPasteboard, .postToVimeo, .addToReadingList, .message, .postToWeibo]
            activityVC.popoverPresentationController?.sourceView = self?.view
            self?.present(activityVC, animated: true, completion: nil)
        })
    }
}
