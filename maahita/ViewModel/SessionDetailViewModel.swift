//
//  SessionDetailViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 20/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import EventKit

class SessionDetailViewModel {

    private var session: MaahitaSession
    
    init(session: MaahitaSession) {
        self.session = session
    }
    
    var id: String {
        return session.sessionId
    }
    
    var title: String {
        return session.title ?? ""
    }
    
    var description: String {
        return session.description ?? ""
    }
    
    var day : String {
        guard let date = session.sessiondate else { return "" }
        let df = DateFormatter()
        df.dateFormat = "dd"
        return df.string(from: date)
    }
    
    var month : String {
        guard let date = session.sessiondate else { return "" }
        let df = DateFormatter()
        df.dateFormat = "MMM"
        return df.string(from: date)
    }
    
    var monthtime : String {
        guard let date = session.sessiondate else { return "" }
        let df = DateFormatter()
        df.dateFormat = "hh:mm a z"
        return df.string(from: date)
    }
    
    var sessionDate: Date {
        self.session.sessiondate!
    }
    
    var status : String {
        switch session.status {
            case .Created:
                return "New"
            case .Enrolled:
                return "Enrolled"
            case .Started:
                return "Started"
            case .Completed:
                return "Completed"
            case .Cancelled:
                return "Cancelled"
        }
    }
    
    var presenter : String {
        return session.presenter ?? "TBD"
    }
    
    var presenterID : String? {
        return session.presenterid
    }
    
    var isActionEnabled: Bool {
        if session.status == .Started {
            sessionAction = .Attend
            return true
        } else if session.status == .Enrolled  && !session.isPresenter {
            sessionAction = .Attend
            return false
        } else if session.status == .Created && !session.isPresenter {
            sessionAction = .Enroll
            return true
        }
        sessionAction = .NoAction
        return false
    }
    
    var sessionStatus: SessionStatus {
        return session.status
    }
    
    var sessionAction: SessionActionType = .Enroll
    
    var meetingID: String? {
        return session.meetingID
    }
    
    var isPresenter: Bool {
        return session.isPresenter
    }
    
    var sessionTheme: String {
        if let groupname = session.groupName, !groupname.isEmpty {
            return groupname
        } else {
            return session.sessiontheme ?? ""
        }
    }
    
    var categoryLabelColor: UIColor {
        return session.isPrivateSession ? UIColor(from: "#f42c2f") : UIColor(from: "#63625e")
    }
    
    var groupID: String? {
        return session.groupID
    }
}

extension SessionDetailViewModel {
    
    func configure(_ view: SessionView) {
        view.sessionTitle.text = title
        
        let attributedString = NSMutableAttributedString(string: description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        view.sessionDescription.attributedText = attributedString
        view.sessionDay.text = day
        view.sessionMonth.text = month
        view.sessionTimeTzone.text = monthtime
        view.sessionPresneter.text = presenter
        view.categoryLabel.text = sessionTheme
        view.categoryLabel.backgroundColor = categoryLabelColor
        view.categoryLabel.sizeToFit()
        
        if let presenterid = presenterID, !presenterid.isEmpty {
          UserService.instance.getAvatar(userID: presenterid, completion: { (url) in
                if let avatarURL = url {
                    view.presenterAvatar.cacheImage(urlString: avatarURL)
                }
          })
        }
        view.statusLabel.text = session.status.statusText
        view.statusView.backgroundColor = session.status.statusColor
        view.statusLabel.textColor = session.status.statusColor
    }
    
    func action(userID: String) {
        SessionsService.instance.update(userID: userID, sessionID: self.id, action: sessionAction, groupID: self.session.groupID)
    }
    
    func submitFeedback() {
//        FeedbackService.instance.submitFeedback()
    }
}
