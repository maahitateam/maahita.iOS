//
//  MeetingViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import JitsiMeetSDK
import SwiftyJWT
import SwiftyCrypto

class MeetingViewController : UIViewController {
    
    fileprivate var _isPresenter: Bool = false
    
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
        self._isPresenter = isPresenter
        var token: String = ""
        
        guard let jaasData = self.readJaasProperties(),
              let jaasServerURL = jaasData["JaasServerURL"] as? String,
              let jaasAppID = jaasData["JaasAPPID"] as? String,
              let jaasKID = jaasData["JaasKID"] as? String,
              let jaasPrivateKey = jaasData["JaasPrivateKey"] as? String else {
            return
        }
        
        guard let rsaKey = try? RSAKey(base64String: jaasPrivateKey, keyType: .PRIVATE) else { return }
        
        let user = UserAuthService.instance.user
        let alg = JWTAlgorithm.rs256(rsaKey)
        let headerWithKeyId = JWTHeader(keyId: jaasKID)
        var payload = JWTPayload()
        let nbf = Int(Date().timeIntervalSince1970)
        let exp = Int(Date().addingTimeInterval(2 * 60 * 60).timeIntervalSince1970)
        payload.customFields = ["context": EncodableValue(value: ["user": EncodableValue(value: ["avatar": EncodableValue(value: user?.photoURL),
                                                                                                 "name": EncodableValue(value: user?.displayName ?? "māhita user"),
                                                                                                 "email": EncodableValue(value: user?.email),
                                                                                                 "id": EncodableValue(value: user?.uid),
                                                                                                 "moderator": EncodableValue(value: isPresenter.description)]),
                                                                  "features": EncodableValue(value: ["livestreaming": "false",
                                                                                                     "recording": "false",
                                                                                                     "outbound-call": "false",
                                                                                                     "transcription": "false"])]),
                                "room": EncodableValue(value: self.meetingID),
                                "aud": EncodableValue(value: "jitsi")
        ]
        payload.issuer = "chat"
        payload.subject = jaasAppID
        payload.expiration = exp
        payload.notBefore = nbf
        
        guard let jwtWithKeyId = JWT(payload: payload, algorithm: alg, header: headerWithKeyId) else { return }
        token = jwtWithKeyId.rawString
        let meetingOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.serverURL = URL(string: jaasServerURL)
            builder.token = token
            builder.room = "\(jaasAppID)/\(self.meetingID)"
            builder.subject = self.meetingtitle
            builder.audioMuted = true
            builder.videoMuted = true
            builder.audioOnly = false
            builder.setFeatureFlag("live-streaming.enabled", withBoolean: false)
            builder.setFeatureFlag("invite.enabled", withBoolean: false)
            builder.setFeatureFlag("recording.enabled", withBoolean: false)
            builder.setFeatureFlag("pip.enabled", withBoolean: false)
            builder.welcomePageEnabled = false
        }
        
        self.jitsiMeetView.join(meetingOptions)
    }
    
    fileprivate func readJaasProperties() -> [String: Any]? {
        guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else { return nil }
        guard let plistXML = FileManager.default.contents(atPath: plistPath) else { return nil }
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        guard let plistData = try? PropertyListSerialization.propertyList(from: plistXML,
                                                                          options: .mutableContainersAndLeaves,
                                                                          format: &propertyListFormat) as? [String: Any] else { return nil }
        return plistData
    }
}

extension MeetingViewController: JitsiMeetViewDelegate {
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        guard let user = UserAuthService.instance.user, !user.isAnonymous else { return }
        SessionsService.instance.update(userID: user.uid, sessionID: self.sessionID, action: .Attend, groupID: self.groupID)
    }
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        self.dismiss(animated: true, completion: nil)
    }
}
