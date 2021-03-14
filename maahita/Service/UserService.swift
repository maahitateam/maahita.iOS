//
//  UserService.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 20/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

protocol UserDelegate {
    func refresh(user: MaahitaUser?)
}

class UserService {

    let collection = "users"
    
    fileprivate static var service : UserService?
    
    fileprivate var dbStore: Firestore?
    
    static var instance: UserService {
        get {
            if service == nil {
                service = UserService()
            }
            
            return service!
        }
    }
    
    fileprivate init()
    {
        self.dbStore = Firestore.firestore()
    }
    
    func get(userID: String, completion: @escaping(MaahitaUser?) -> Void) {
        self.dbStore?.collection(collection).document(userID).getDocument(completion: { (snapshot, error) in
            if error == nil {
                let uID = snapshot?.documentID ?? ""
                let email = snapshot?.get("email") as? String ?? ""
                let displayname = snapshot?.get("displayName") as? String ?? ""
                let avatarURL = snapshot?.get("avatar") as? String ?? ""
                
                let user = MaahitaUser(uID: uID, emailID: email, displayName: displayname, avatarURL: avatarURL)
                completion(user)
            }
        })
    }
    
    func getAvatar(userID: String, completion: @escaping(String?) -> Void) {
        self.dbStore?.collection(collection).document(userID).getDocument(completion: { (snapshot, error) in
            if error == nil {
                let avatarURL = snapshot?.get("avatar") as? String
                completion(avatarURL)
            }
        })
    }
    
    func setAvatar(userID: String, photoURL: String) {
        
        let updates = ["avatar" : photoURL]
        
        self.dbStore?.collection(collection).document(userID).setData(updates, merge: true)
    }
}
