//
//  SessionsService.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

protocol SessionDelegate {
    func refresh(session: MaahitaSession?)
}

class SessionsService {
    
    let collection = "sessions"
    let maahitaGroup = "maahita-group"
    let collectionGroup = "group-sessions"
    
    fileprivate static var service : SessionsService?
    
    fileprivate var dbStore: Firestore?
    
    fileprivate var collectionQuery: Query?
    fileprivate var groupQuery: Query?
    
    static var instance: SessionsService {
        get {
            if service == nil {
                service = SessionsService()
            }
            
            return service!
        }
    }
    
    fileprivate init()
    {
        self.dbStore = Firestore.firestore()
    }
    
    var sessionDelegate: SessionDelegate?
    
    func get(sessionID: String, groupID: String?) {
        if groupID != nil {
            self.dbStore?.collection("\(maahitaGroup)/\(groupID!)/\(collectionGroup)").document(sessionID).addSnapshotListener({ (snapshot, error) in
                if error != nil {
                    self.sessionDelegate?.refresh(session: nil)
                } else {
                    let session =  MaahitaSession(snapshot: snapshot!)
                    self.sessionDelegate?.refresh(session: session)
                }
            })
        } else {
            self.dbStore?.collection(collection).document(sessionID)
                .addSnapshotListener({ (snapshot, error) in
                    if error != nil {
                        self.sessionDelegate?.refresh(session: nil)
                    } else {
                        let session =  MaahitaSession(snapshot: snapshot!)
                        self.sessionDelegate?.refresh(session: session)
                    }
                })
        }
    }
    
    func update(userID: String, sessionID: String, action: SessionActionType, groupID: String?) {
        
        let key = action == .Enroll ? "enrollments" : "attendees"
        let updates = [key : FieldValue.arrayUnion([userID])]
        
        if groupID != nil {
            self.dbStore?.collection("\(maahitaGroup)/\(groupID!)/\(collectionGroup)").document(sessionID).updateData(updates) {
                (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } else {
            self.dbStore?.collection(collection).document(sessionID).updateData(updates) {
                (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func save(sessionRequest: SessionRequest, completion: @escaping((Bool) -> Void)) {
        let data: [String: Any] = ["date": Timestamp(date: sessionRequest.sessiondate),
                                   "description":sessionRequest.description,
                                   "livestreaming": sessionRequest.isStreamingRequired,
                                   "presenterid": sessionRequest.presenterid,
                                   "presentername": sessionRequest.presenter,
                                   "requestedby": UserAuthService.instance.userID(),
                                   "requestedon": Timestamp(date: Date()),
                                   "title": sessionRequest.title]
        self.dbStore?.collection("sessionrequests").addDocument(data: data, completion: { (error) in
            
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    func startSession(sessionID: String, title: String, groupID: String?, completion: @escaping((Bool) -> Void)) {
        let data: [String: Any] = ["startedon": Timestamp(date: Date()),
                                   "status": SessionStatus.Started.rawValue,
                                   "meetingID": UUID().uuidString]
        
        self.updatesession(sessionID: sessionID, groupID: groupID, data: data) { (updated) in
            if updated {
                self.sendNotification(title: "Session has been started",
                                      description: "\(title) session has been started by the presenter.", completion: completion)
            }
        }
    }
    
    func stopSession(sessionID: String, groupID: String?, completion: @escaping((Bool) -> Void)) {
        let data: [String: Any] = ["completedon": Timestamp(date: Date()),
                                   "status": SessionStatus.Completed.rawValue]
        
        self.updatesession(sessionID: sessionID, groupID: groupID, data: data) { (updated) in
            if updated {
                var sessionRef: DocumentReference? = nil
                if groupID != nil {
                    sessionRef = self.dbStore?.collection("\(self.maahitaGroup)/\(groupID!)/\(self.collectionGroup)").document(sessionID)
                } else {
                    sessionRef = self.dbStore?.collection(self.collection).document(sessionID)
                }
                
                sessionRef?.getDocument(completion: { (docsnapshot, error) in
                    guard let attendees = docsnapshot?.get("attendees") as? [String] else { return }
                    
                    let updateBatch = self.dbStore?.batch()
                    for attendee in attendees {
                        let data: [String: Any] = ["issubmitted": false, "requestedon": FieldValue.serverTimestamp(), "id": attendee]
                        guard let docref = sessionRef?.collection("feedback").document(attendee) else { return }
                        updateBatch?.setData(data, forDocument: docref)
                    }
                    
                    updateBatch?.commit(completion: { (error) in
                        completion(true)
                    })
                })
            }
        }
    }
    
    func cancelSession(sessionID: String, title: String, groupID: String?, completion: @escaping((Bool) -> Void)) {
        let data: [String: Any] = ["cancelledon": Timestamp(date: Date()),
                                   "status": SessionStatus.Cancelled.rawValue]
        
        self.updatesession(sessionID: sessionID, groupID: groupID, data: data) { (updated) in
            if updated {
                self.sendNotification(title: "Session has been cancelled",
                                      description: "\(title) session has been cancelled due to some unprecedented reasons. Sorry for the inconvenience. We will update you soon.", completion: completion)
            }
        }
    }
    
    fileprivate func updatesession(sessionID: String, groupID: String?, data: [String: Any], completion: @escaping((Bool) -> Void)) {
        var sessionCollection: CollectionReference? = nil
        if groupID != nil {
             sessionCollection = self.dbStore?.collection("\(maahitaGroup)/\(groupID!)/\(collectionGroup)")
        } else {
            sessionCollection = self.dbStore?.collection(collection)
        }
            self.dbStore?.collection(collection).document(sessionID).updateData(data, completion: { (error) in
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                
                completion(true)
            })
    }
    
    fileprivate func sendNotification(title: String, description: String, completion: @escaping((Bool) -> Void)) {
        let data: [String: Any] = ["date": Timestamp(date: Date()),
                                   "title": title,
                                   "description": description]
        self.dbStore?.collection("notificationrequest").addDocument(data: data, completion: { (error) in
            
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
        })
    }
}
