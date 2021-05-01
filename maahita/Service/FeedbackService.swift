//
//  FeedbackService.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

protocol FeedbackServiceDelegate {
    func refresh(feedback: [MaahitaSession]?)
}

class FeedbackService {
    
    let collection = "feedback"
    
    fileprivate static var service : FeedbackService?
    
    fileprivate var dbStore: Firestore?
    
    static var instance: FeedbackService {
        get {
            if service == nil {
                service = FeedbackService()
            }
            
            return service!
        }
    }
    
    var feedbackDelegate: FeedbackServiceDelegate?
    
    fileprivate init()
    {
        
    }
    
    func get() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            let calendar = Calendar.current
            let fivedaysAgo = calendar.date(byAdding: .day, value: -5, to: Date())!
            self.dbStore = Firestore.firestore()
            self.dbStore?.collectionGroup("feedback")
                .whereField("issubmitted", isEqualTo: false)
                .whereField("requestedon", isGreaterThanOrEqualTo: fivedaysAgo)
                .whereField("id", isEqualTo: user.uid)
                .addSnapshotListener { (query, error) in
                    if error != nil {
                        self.feedbackDelegate?.refresh(feedback: nil)
                    } else {
                        var sessions: [MaahitaSession] = []
                        for doc in query!.documents {
                            doc.reference.parent.parent?.getDocument(completion: { [weak self](snapshot, error) in
                                if let docSnapshot = snapshot {
                                    sessions.append(MaahitaSession(snapshot: docSnapshot))
                                    self?.feedbackDelegate?.refresh(feedback: sessions)
                                }
                            })
                        }
                        self.feedbackDelegate?.refresh(feedback: sessions)
                    }
            }
        }
        else {
            self.feedbackDelegate?.refresh(feedback: nil)
        }
    }
    
    func getQuestions(completion: @escaping(([Feedback]?) -> Void)) {
        self.dbStore?.collection("feedbackquestions").getDocuments(completion: { (snapshot, error) in
            if error != nil {
                completion(nil)
            } else {
                let questions = snapshot?.documents.map({ Feedback(snapshot: $0) })
                completion(questions)
            }
        })
    }
    
    func submitFeedback(sessionID: String, groupID: String?, feedback: [Feedback], completion: @escaping((Bool)->Void)) {
        
        let total = feedback.map { $0.value }.reduce(0, +)
        let count = feedback.count
        let overallRating = count > 0 ? total / Double(count) : 0.0
        
        let feedbackData = Dictionary(uniqueKeysWithValues: feedback.map{ ($0.id, $0.value) })
        
        guard let userid = UserAuthService.instance.userID() else { return }
        
        self.dbStore?.collection("sessions/\(sessionID)/feedback")
            .document(userid)
            .updateData(feedbackData, completion: { [weak self] (error) in
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                
                self?.dbStore?.collection("sessions/\(sessionID)/feedback")
                    .document(userid)
                    .updateData(["overall": overallRating,
                                 "issubmitted": true,
                                 "submittedon": FieldValue.serverTimestamp()], completion: { (error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                        completion(false)
                                        return
                                    }
                                    completion(true)
                    })
            })
    }
}
