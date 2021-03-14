//
//  SessionViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import EventKit

enum SessionActionType: String {
    case Enroll
    case Attend
    case External
    case NoAction
}

class SessionViewModel {
    
    private let session: MaahitaSession
    
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
    
    var time : String {
        guard let date = session.sessiondate else { return "" }
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        return df.string(from: date)
    }
    
    var timewithzone : String {
        guard let date = session.sessiondate else { return "" }
        let df = DateFormatter()
        df.dateFormat = "hh:mm a z"
        return df.string(from: date)
    }
    
    var sessionDate: Date {
        self.session.sessiondate!
    }
    
    var presenter : String {
        return session.isPresenter ? "Me" : session.presenter ?? "TBD"
    }
    
    var categoryLabel: String? {
        return session.isPrivateSession ? session.groupName : session.sessiontheme
    }
    
    var categoryLabelColor: UIColor {
        return session.isPrivateSession ? UIColor(from: "#f42c2f") : UIColor(from: "#63625e")
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
    
    var sessionAction: SessionActionType = .Enroll
    
    var meetingID: String? {
        return session.meetingID
    }
    
    var isPresenter: Bool {
        return session.isPresenter
    }
    
    var groupID: String? {
        return session.groupID
    }
}

extension SessionViewModel {
    func configure(_ view: SessionViewProtocol) {
        view.sessionTitle.text = title
        
        let attributedString = NSMutableAttributedString(string: description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        view.sessionDescription.attributedText = attributedString
        view.sessionDay.text = day
        view.sessionMonth.text = month
        view.sessionTime.text = time
        view.sessionTimeTzone.text = timewithzone
        view.sessionPresneter.text = presenter
        view.statusLabel.text = session.status.statusText
        view.statusView.backgroundColor = session.status.statusColor
        view.statusLabel.textColor = session.status.statusColor
        view.categoryLabel.text = categoryLabel
        view.categoryLabel.backgroundColor = categoryLabelColor
        view.categoryLabel.sizeToFit()
    }
    
    func configureLive(_ view: LiveSessionCell) {
        view.sessionTitle.text = title
        view.sessionPresenter.text = presenter
        
        if let date = session.startdate {
            view.sessionTime.text = "Started \(date.timeAgoDisplay())"
        }
    }
    
    func configureFeedback(_ view: FeedbackRequestCell) {
        view.sessionTitle.text = title
        view.sessionPresenter.text = presenter
        
        if let _ = session.startdate {
            view.sessionTime.text = "\(day) \(month) \(timewithzone)"
        }
    }
    
    func action(userID: String) {
        SessionsService.instance.update(userID: userID, sessionID: self.session.sessionId, action: sessionAction, groupID: self.session.groupID)
    }
}
