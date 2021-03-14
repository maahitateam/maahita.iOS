//
//  DashboardService.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 22/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

protocol DashboardServiceDelegate {
    func refresh(dashboard: Dashboard?)
    func refresh(livesessions: [MaahitaSession]?)
    func refresh(feedbacksessions: [MaahitaSession]?)
}

class DashboardService {
    
    let collection = "sessions"
    
    fileprivate static var service : DashboardService?
    
    fileprivate var dbStore: Firestore?
    
    fileprivate var sessionsCollection: CollectionReference?
    
    static var instance: DashboardService {
        get {
            if service == nil {
                service = DashboardService()
            }
            
            return service!
        }
    }
    
    fileprivate init()
    {
        self.dbStore = Firestore.firestore()
        self.sessionsCollection = self.dbStore?.collection(collection)
    }
    
    var delegate: DashboardServiceDelegate?
    
    func dashboard() {
        self.dbStore?.collection(collection).addSnapshotListener({ (snapshot, error) in
            if error != nil {
                self.delegate?.refresh(dashboard: nil)
            } else {
                var enrolled: Int = 0
                var attended: Int = 0
                
                for document in snapshot!.documents {
                    let enrollments = document.get("enrollments") as? [String]
                    let attendees = document.get("attendees") as? [String]
                    
                    if let uID = UserAuthService.instance.user?.uid, !uID.isEmpty {
                        let firstIndex = enrollments?.firstIndex(of: uID) ?? -1
                        if firstIndex >= 0 {
                            enrolled += 1
                        }
                        
                        let first = attendees?.firstIndex(of: uID) ?? -1
                        if first >= 0 {
                            attended += 1
                        }
                    }
                }
                
                self.delegate?.refresh(dashboard: Dashboard(enrolled: enrolled, attended: attended, completed: 0))
            }
        })
    }
    
    func getLive() {
        self.sessionsCollection?.whereField("status", isEqualTo: SessionStatus.Started.rawValue)
            .addSnapshotListener { (query, error) in
                if error != nil {
                    self.delegate?.refresh(livesessions: nil)
                } else {
                    let sessions = query?.documents.map({ MaahitaSession(snapshot: $0) })
                    self.delegate?.refresh(livesessions: sessions)
                }
        }
    }
}
