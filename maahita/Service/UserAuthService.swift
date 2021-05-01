//
//  UserAuthService.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

protocol AuthServiceDelegate {
    func refreshUser()
}

class UserAuthService {
    
    fileprivate static var service : UserAuthService?
    
    static var instance: UserAuthService {
        get {
            if service == nil {
                service = UserAuthService()
            }
            
            return service!
        }
    }
    
    var delegates: [AuthServiceDelegate]?
    
    fileprivate init()
    {
        self.delegates = [AuthServiceDelegate]()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let delegates = self.delegates {
                for delegate in delegates {
                    delegate.refreshUser()
                }
            }
        }
    }
    
    func userID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    var user : User? {
        get {
            return Auth.auth().currentUser
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void)
    {
        Auth.auth().signIn(withEmail: email, password: password) { (authresult, error) in
            completion(error == nil, error)
        }
    }
    
    func register(fullName: String, email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link(with: credential, completion: { (authresult, error) in
            if error != nil {
                completion(false, error)
            } else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fullName
                changeRequest?.commitChanges(completion: { [weak self] (error) in
                    if error != nil {
                        completion(false, error)
                    }
                    else {
                        if let delegates = self?.delegates {
                            for delegate in delegates {
                                delegate.refreshUser()
                            }
                        }
                        completion(true, nil)
                    }
                })
            }
        })
    }
    
    func verifyemail(completion: @escaping(Bool, Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            completion(error == nil, error)
        })
    }
    
    func changepassword(completion: @escaping(Bool, Error?) -> Void) {
        if let email = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                completion(error == nil, error)
            }
        }
    }
    
    func relogin(email: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
            if error != nil {
                completion(false, error)
                    return
                }
                completion(true, nil)
            })
    }
    
    func removeaccount(completion: @escaping(Bool, Error?) -> Void) {
        Auth.auth().currentUser?.delete(completion: { [weak self] (error) in
            if error != nil {
                completion(false, error)
                return
            }
            UserDefaults.standard.set(nil, forKey: Strings.EMAIL_ID)
            //After removing the user, sign-in anonymously
            self?.signInAnonymous()
            completion(true, nil)
        })
    }
    
    func signout() {
        do{
            try Auth.auth().signOut()
            signInAnonymous()
        } catch {
            
        }
    }
    
    func signInAnonymous() {
        Auth.auth().signInAnonymously { (auth, error) in
            if let delegates = self.delegates {
                for delegate in delegates {
                    delegate.refreshUser()
                }
            }
        }
    }
    
    func save(name: String, completion: @escaping(Bool, Error?) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: { [weak self](error) in
            if error != nil {
                completion(false, error)
            }
            else {
                if let delegates = self?.delegates {
                    for delegate in delegates {
                        delegate.refreshUser()
                    }
                }
                completion(true, nil)
            }
        })
    }
    
    func save(image: UIImage, completion: @escaping(Bool, Error?) -> Void) {
        guard let userid = UserAuthService.instance.userID() else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let storageRef = Storage.storage().reference()
        let uploadRef = storageRef.child("avatars").child("\(userid).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        uploadRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
              return
            }
            // access to download URL after upload.
            uploadRef.downloadURL { (url, error) in
              guard let downloadURL = url else {
                    return
                }
                
                //Save to database
                UserService.instance.setAvatar(userID: userid, photoURL: downloadURL.absoluteString)
                
                let changeRequest = UserAuthService.instance.user?.createProfileChangeRequest()
                changeRequest?.photoURL = downloadURL
                changeRequest?.commitChanges(completion: { [weak self](error) in
                    if error != nil {
                        completion(false, error)
                    }
                    else {
                        if let delegates = self?.delegates {
                            for delegate in delegates {
                                delegate.refreshUser()
                            }
                        }
                        completion(true, nil)
                    }
                })
            }
        }
    }
}
