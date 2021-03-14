//
//  MaahitaAlertView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 29/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

enum MaahitaAlertType {
    case Information
    case Warning
    case Error
    case Confirmation
}

class MaahitaAlertView: UIView {
    static var instance: MaahitaAlertView {
        get {
            return MaahitaAlertView()
        }
    }
    
    lazy var alertIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "infoIcon")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var alertMessage: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Comfortaa-Medium", size: 16.0)
        title.textColor = .charcoalGrey
        title.numberOfLines = 0
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var yesActionButton: UIButton = {
        let yesButton = UIButton()
        yesButton.setTitle("Yes", for: .normal)
        yesButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        yesButton.setTitleColor(.ceruleanTwo, for: .normal)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        return yesButton
    }()
    
    lazy var noActionButton: UIButton = {
        let noButton = UIButton()
        noButton.setTitle("No", for: .normal)
        noButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 14.0)
        noButton.setTitleColor(.scarlet, for: .normal)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        return noButton
    }()
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var actionPane: UIView = {
        let actionpane = UIView()
        actionpane.backgroundColor = .clear
        actionpane.translatesAutoresizingMaskIntoConstraints = false
        return actionpane
    }()
    
    init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundColor = .black60
        
        self.addSubview(messageView)
        self.messageView.addSubview(alertIcon)
        self.messageView.addSubview(actionPane)
        self.messageView.addSubview(alertMessage)
        
        NSLayoutConstraint.activate([
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            messageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertIcon.heightAnchor.constraint(equalToConstant: 70.0),
            alertIcon.widthAnchor.constraint(equalTo: alertIcon.heightAnchor),
            alertIcon.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            alertIcon.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 25.0),
            alertMessage.topAnchor.constraint(equalTo: alertIcon.bottomAnchor, constant: 16.0),
            alertMessage.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 30.0),
            alertMessage.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -30.0),
            actionPane.topAnchor.constraint(equalTo: alertMessage.bottomAnchor, constant: 16.0),
            actionPane.leadingAnchor.constraint(equalTo: messageView.leadingAnchor),
            actionPane.trailingAnchor.constraint(equalTo: messageView.trailingAnchor),
            actionPane.heightAnchor.constraint(equalToConstant: 60.0),
            actionPane.bottomAnchor.constraint(equalTo: messageView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(message: String, yesAction: @escaping(() -> Void)) {
        self.alertMessage.text = message
        self.alertIcon.image = UIImage(named: "close")
        self.alertIcon.tintColor = .scarlet
        
        self.yesActionButton.unlisten(sleeve: self)
        self.noActionButton.unlisten(sleeve: self)
        self.yesActionButton.removeFromSuperview()
        self.noActionButton.removeFromSuperview()
        
        self.actionPane.addSubview(yesActionButton)
        yesActionButton.setTitle("OK", for: .normal)
        
        yesActionButton.listenOnce({
            self.removeFromSuperview()
            yesAction()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([yesActionButton.centerXAnchor.constraint(equalTo: actionPane.centerXAnchor),
                                     yesActionButton.centerYAnchor.constraint(equalTo: actionPane.centerYAnchor),
                                     yesActionButton.centerXAnchor.constraint(equalTo: actionPane.centerXAnchor),
                                     yesActionButton.widthAnchor.constraint(equalToConstant: 50.0)])
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func showWarning(message: String, yesAction: @escaping(() -> Void)) {
        self.alertMessage.text = message
        self.alertIcon.image = UIImage(named: "alert")
        self.alertIcon.tintColor = .pumpkinOrange
        
        self.yesActionButton.unlisten(sleeve: self)
        self.noActionButton.unlisten(sleeve: self)
        self.yesActionButton.removeFromSuperview()
        self.noActionButton.removeFromSuperview()
        
        self.actionPane.addSubview(yesActionButton)
        yesActionButton.setTitle("OK", for: .normal)
        
        yesActionButton.listenOnce({
            self.removeFromSuperview()
            yesAction()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([yesActionButton.centerXAnchor.constraint(equalTo: actionPane.centerXAnchor),
                                     yesActionButton.centerYAnchor.constraint(equalTo: actionPane.centerYAnchor),
                                     yesActionButton.centerXAnchor.constraint(equalTo: actionPane.centerXAnchor),
                                     yesActionButton.widthAnchor.constraint(equalToConstant: 50.0)])
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func showInformation(message: String, yesAction: @escaping(() -> Void)) {
        self.alertMessage.text = message
        self.alertIcon.image = UIImage(named: "infoIcon")
        self.alertIcon.tintColor = .ceruleanTwo
        
        self.yesActionButton.unlisten(sleeve: self)
        self.noActionButton.unlisten(sleeve: self)
        self.yesActionButton.removeFromSuperview()
        self.noActionButton.removeFromSuperview()
        
        self.actionPane.addSubview(yesActionButton)
        yesActionButton.setTitle("OK", for: .normal)
        
        yesActionButton.listenOnce({
            self.removeFromSuperview()
            yesAction()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([yesActionButton.centerXAnchor.constraint(equalTo: actionPane.centerXAnchor),
                                     yesActionButton.centerYAnchor.constraint(equalTo: actionPane.centerYAnchor),
                                     yesActionButton.widthAnchor.constraint(equalToConstant: 50.0)])
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func askConfirmation(message: String, yesAction: @escaping(() -> Void), noAction: @escaping(() -> Void)) {
        self.alertMessage.text = message
        self.alertIcon.image = UIImage(named: "questionIcon")
        self.alertIcon.tintColor = .ceruleanTwo
        
        self.yesActionButton.unlisten(sleeve: self)
        self.noActionButton.unlisten(sleeve: self)
        self.yesActionButton.removeFromSuperview()
        self.noActionButton.removeFromSuperview()
        
        self.actionPane.addSubview(yesActionButton)
        self.actionPane.addSubview(noActionButton)
        
        yesActionButton.listenOnce({
            self.removeFromSuperview()
            yesAction()
        }, for: .touchUpInside)

        noActionButton.listenOnce({
            self.removeFromSuperview()
            noAction()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([yesActionButton.trailingAnchor.constraint(equalTo: actionPane.trailingAnchor, constant: -60.0),
                                     yesActionButton.centerYAnchor.constraint(equalTo: actionPane.centerYAnchor),
                                     yesActionButton.widthAnchor.constraint(equalToConstant: 50.0),
                                     noActionButton.leadingAnchor.constraint(equalTo: actionPane.leadingAnchor, constant: 60.0),
                                     noActionButton.centerYAnchor.constraint(equalTo: actionPane.centerYAnchor),
                                     noActionButton.widthAnchor.constraint(equalToConstant: 50.0)])
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func askConfirmation(message: String, okAction: @escaping(() -> Void)) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.layer.cornerRadius = 10.0
        messageView.layer.masksToBounds = true
        
        messageView.layer.shadowColor = UIColor.black16.cgColor
        messageView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        messageView.layer.cornerRadius = 10.0
        messageView.layer.shadowRadius = 1.0
        messageView.layer.shadowPath = UIBezierPath(roundedRect: messageView.bounds, cornerRadius: messageView.layer.cornerRadius).cgPath
    }
}
