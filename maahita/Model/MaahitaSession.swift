//
//  MaahitaSession.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

enum SessionStatus : Int {
    case Created = 1
    case Enrolled = 2
    case Started = 3
    case Completed = 4
    case Cancelled = 5
}

extension SessionStatus {
    var statusText: String {
        get {
            switch self {
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
    }
    
    var statusColor: UIColor {
        get {
            switch self {
                case .Created:
                    return UIColor(from: "#f42c2f")
                case .Enrolled:
                    return UIColor(from: "#65aa49")
                case .Started:
                    return UIColor(from: "#8135b7")
                case .Completed:
                    return UIColor(from: "#103eb5")
                case .Cancelled:
                    return UIColor(from: "#63625e")
            }
        }
    }
}

struct MaahitaSession {
    
    var sessionId:String
    var title: String?
    var description: String?
    var sessiontheme: String?
    var duration: String?
    var status: SessionStatus
    var presenterid: String?
    var presenter: String?
    var sessiondate: Date?
    var meetingID: String?
    var isEnrolled: Bool?
    var noofEnrollments: Int?
    var startdate: Date?
    var isPresenter: Bool = false
    var groupID: String?
    var groupName: String?
    var isPrivateSession: Bool = false
    
    init() {
        self.sessionId = ""
        self.status = .Created
    }
    
    init(snapshot : QueryDocumentSnapshot) {
        sessionId = snapshot.documentID
        title = snapshot.get("title") as? String
        description = snapshot.get("description") as? String
        sessiontheme = snapshot.get("theme") as? String
        duration = snapshot.get("duration") as? String
        presenterid = snapshot.get("presenterid") as? String
        presenter = snapshot.get("presenter") as? String
        meetingID = snapshot.get("meetingID") as? String
        
        if let timestamp = snapshot.get("date") as? FirebaseFirestore.Timestamp {
            sessiondate = timestamp.dateValue()
        }
        
        if let startedts = snapshot.get("startedon") as? FirebaseFirestore.Timestamp {
            startdate = startedts.dateValue()
        }
        
        status = SessionStatus(rawValue: (snapshot.get("status") as? Int) ?? 1) ?? .Created
        
        let enrollments = snapshot.get("enrollments") as? [String]
        noofEnrollments = enrollments?.count ?? 0
        
        if let uID = Auth.auth().currentUser?.uid, !uID.isEmpty {
            if status == .Created {
                let firstIndex = enrollments?.firstIndex(of: uID) ?? -1
                if firstIndex >= 0 {
                    isEnrolled = true
                    status = .Enrolled
                }
            }
           
            if let presenterID = snapshot.get("presenterid") as? String, presenterID == uID {
                isPresenter = true
            }
            
            groupID = snapshot.get("groupid") as? String
            groupName = snapshot.get("groupname") as? String
            if groupID?.isEmpty ?? false {
                isPrivateSession = true
            }
        }
    }
    
    init(snapshot : DocumentSnapshot) {
        sessionId = snapshot.documentID
        title = snapshot.get("title") as? String
        description = snapshot.get("description") as? String
        sessiontheme = snapshot.get("theme") as? String
        duration = snapshot.get("duration") as? String
        presenterid = snapshot.get("presenterid") as? String
        presenter = snapshot.get("presenter") as? String
        meetingID = snapshot.get("meetingID") as? String
        
        if let timestamp = snapshot.get("date") as? FirebaseFirestore.Timestamp {
            sessiondate = timestamp.dateValue()
        }
        
        if let startedts = snapshot.get("startedon") as? FirebaseFirestore.Timestamp {
            startdate = startedts.dateValue()
        }
        
        status = SessionStatus(rawValue: (snapshot.get("status") as? Int) ?? 1) ?? .Created
        
        let enrollments = snapshot.get("enrollments") as? [String]
        noofEnrollments = enrollments?.count ?? 0
        
        if let uID = Auth.auth().currentUser?.uid, !uID.isEmpty {
            if status == .Created {
                let firstIndex = enrollments?.firstIndex(of: uID) ?? -1
                if firstIndex >= 0 {
                    isEnrolled = true
                    status = .Enrolled
                }
            }
           
            if let presenterID = snapshot.get("presenterid") as? String, presenterID == uID {
                isPresenter = true
            }
            
            groupID = snapshot.get("groupid") as? String
            groupName = snapshot.get("groupname") as? String
            if groupID?.isEmpty ?? false {
                isPrivateSession = true
            }
        }
    }
}
