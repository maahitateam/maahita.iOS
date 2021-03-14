//
//  MeetingViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import JitsiMeet
import SwiftyJWT

class MeetingViewController : UIViewController {
    
    let jitsiServerURL = "https://meet.jit.si/"
    
    lazy var jitsiMeetView: JitsiMeetView = {
        let jitsiView = JitsiMeetView()
        jitsiView.translatesAutoresizingMaskIntoConstraints = false
        return jitsiView
    }()
    
    var sessionID: String
    var meetingID: String
    var meetingtitle: String
    var groupID: String?
    
    init(sessionID: String, meetingID: String, title: String, groupID: String?) {
        self.sessionID = sessionID
        self.meetingID = meetingID
        self.meetingtitle = title
        self.sessionID = sessionID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(jitsiMeetView)
        jitsiMeetView.delegate = self
        
        NSLayoutConstraint.activate([
            jitsiMeetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            jitsiMeetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            jitsiMeetView.topAnchor.constraint(equalTo: self.view.topAnchor),
            jitsiMeetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    @objc func canRotate() -> Void {}
    
    func joinMeeting(isPresenter: Bool) {
//        if isPresenter {
//            var token: String?
//
//            if let user = UserAuthService.instance.user, !user.isAnonymous {
//                let alg = JWTAlgorithm.hs256("maahitaauthenticationsecretGSHOggudJaTlIMrYzaNCOAAOJBI3")
//                let headerWithKeyId = JWTHeader.init(keyId: "maahitakeyid")
//                var payload = JWTPayload()
//                payload.customFields = ["context": EncodableValue(value: ["user": EncodableValue(value: ["avatar": EncodableValue(value: user.photoURL),
//                                                                                   "name": EncodableValue(value: user.displayName ?? "Presenter"),
//                                                                                   "email": EncodableValue(value: user.email),
//                                                                                   "id": EncodableValue(value: user.uid)])]),
//                      "aud": EncodableValue(value: "maahitamobile"),
//                      "iss": EncodableValue(value: "maahitajwttokenapplicationid"),
//                      "sub": EncodableValue(value: "meet.jit.si"),
//                      "room": EncodableValue(value: self.meetingID)]
//
//                let jwtWithKeyId = try? JWT.init(payload: payload, algorithm: alg, header: headerWithKeyId)
//                token = jwtWithKeyId?.rawString
//            }
//
//            let meetingOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//                builder.serverURL = URL(string: self.jitsiServerURL)
//                builder.room = self.meetingID
//                builder.audioOnly = false
//                builder.audioMuted = true
//                builder.videoMuted = true
//                builder.token = token ?? ""
//                builder.subject = self.meetingtitle
//                builder.setFeatureFlag("live-streaming.enabled", withBoolean: false)
//                builder.setFeatureFlag("invite.enabled", withBoolean: false)
//                builder.setFeatureFlag("recording.enabled", withBoolean: false)
//                builder.setFeatureFlag("pip.enabled", withBoolean: false)
//                builder.welcomePageEnabled = false
//            }
//
//            self.jitsiMeetView.join(meetingOptions)
//        } else {
            var userInfo = JitsiMeetUserInfo(displayName: "Guest user", andEmail: nil, andAvatar: nil)
            
            if let user = UserAuthService.instance.user, !user.isAnonymous {
                let displayName = user.displayName ?? "māhita mobile"
                let avatarURL = user.photoURL
                
                userInfo = JitsiMeetUserInfo(displayName: displayName, andEmail: nil, andAvatar: avatarURL)
            }
            
            let meetingOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.serverURL = URL(string: self.jitsiServerURL)
                builder.room = self.meetingID
                builder.audioOnly = false
                builder.audioMuted = true
                builder.videoMuted = true
                builder.userInfo = userInfo
                builder.subject = self.meetingtitle
                builder.setFeatureFlag("live-streaming.enabled", withBoolean: false)
                builder.setFeatureFlag("invite.enabled", withBoolean: false)
                builder.setFeatureFlag("recording.enabled", withBoolean: false)
                builder.setFeatureFlag("pip.enabled", withBoolean: false)
                builder.welcomePageEnabled = false
            }
            
            self.jitsiMeetView.join(meetingOptions)
        }
//    }
}

extension MeetingViewController: JitsiMeetViewDelegate {
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        guard let user = UserAuthService.instance.user, !user.isAnonymous else { return }
        SessionsService.instance.update(userID: user.uid, sessionID: self.sessionID, action: .Attend, groupID: self.groupID)
    }
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        self.dismiss(animated: true) {
            
        }
    }
}
