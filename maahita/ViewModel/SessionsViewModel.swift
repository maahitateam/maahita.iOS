//
//  SessionsViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 17/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

struct SessionsViewModel {
    
    let collection = "sessions"
    let maahitaGroup = "maahita-group"
    let collectionGroup = "group-sessions"
    
    fileprivate var dbStore = Firestore.firestore()
    
    weak var dataSource: GenericDataSource<MaahitaSession>? {
        didSet {
            dataSource?.data.value?.sort(by: { (session1, session2) -> Bool in
                return session1.sessiondate! > session2.sessiondate!
            })
        }
    }
    
    init(dataSource: GenericDataSource<MaahitaSession>) {
        self.dataSource = dataSource
    }
    
    func fetchSessions() {
        self.dataSource?.data.value = []
        self.dbStore.collection(collection).whereField("date", isGreaterThanOrEqualTo: Calendar.current.startOfDay(for: Date())).addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                self.dataSource?.data.value?.removeAll(where: { !$0.isPrivateSession })
                return
            }
            
            if error != nil {
                self.dataSource?.data.value?.removeAll(where: { !$0.isPrivateSession })
            } else {
                let sessions = documents.map({ MaahitaSession(snapshot: $0) })
                self.dataSource?.data.value = sessions
            }
        }
        
        if let userID = UserAuthService.instance.user?.uid {
            self.dbStore.collectionGroup(collectionGroup)
                .whereField("subscribers", arrayContains: userID)
                .whereField("date", isGreaterThanOrEqualTo: Calendar.current.startOfDay(for: Date())).addSnapshotListener { (query, error) in
                guard let documents = query?.documents else {
                    self.dataSource?.data.value?.removeAll(where: { $0.isPrivateSession })
                    return
                }
                
                if error != nil {
                    self.dataSource?.data.value?.removeAll(where: { $0.isPrivateSession })
                } else {
                    let sessions = documents.map({ MaahitaSession(snapshot: $0) })
                    self.dataSource?.data.value?.append(contentsOf: sessions)
                }
            }
        }
    }
    
    func fetchCompletedSessions() {
        self.dataSource?.data.value = []
        self.dbStore.collection(collection)
            .whereField("status", isGreaterThan: SessionStatus.Started.rawValue)
            .addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                self.dataSource?.data.value?.removeAll(where: { !$0.isPrivateSession })
                return
            }
            
            if error != nil {
                self.dataSource?.data.value?.removeAll(where: { !$0.isPrivateSession })
            } else {
                let sessions = documents.map({ MaahitaSession(snapshot: $0) })
                self.dataSource?.data.value = sessions
            }
        }
        
        if let userID = UserAuthService.instance.user?.uid {
            self.dbStore.collectionGroup(collectionGroup)
                .whereField("status", isGreaterThan: SessionStatus.Started.rawValue)
                .whereField("subscribers", arrayContains: userID)
                .addSnapshotListener { (query, error) in
                guard let documents = query?.documents else {
                    self.dataSource?.data.value?.removeAll(where: { $0.isPrivateSession })
                    return
                }
                
                if error != nil {
                    self.dataSource?.data.value?.removeAll(where: { $0.isPrivateSession })
                } else {
                    let sessions = documents.map({ MaahitaSession(snapshot: $0) })
                    self.dataSource?.data.value?.append(contentsOf: sessions)
                }
            }
        }
    }
}
