//
//  SessionRequestViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 28/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

class SessionRequestViewController: PanCloseViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var sessionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Title"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sessionTitleTextField: PaddedTextField = {
        let floor = PaddedTextField()
        floor.font = UIFont.systemFont(ofSize: 14.0)
        floor.backgroundColor = .white
        floor.placeholder = "Enter a session title"
        floor.autocorrectionType = .no
        floor.returnKeyType = .done
        floor.borderStyle = .roundedRect
        floor.translatesAutoresizingMaskIntoConstraints = false
        return floor
    }()
    
    lazy var sessionSubjectLabel: UILabel = {
        let subject = UILabel()
        subject.font = UIFont.systemFont(ofSize: 12.0)
        subject.text = "Subject / Theme"
        subject.textColor = .darkGray
        subject.translatesAutoresizingMaskIntoConstraints = false
        return subject
    }()
    
    lazy var sessionSubjectTextField: PaddedTextField = {
        let floor = PaddedTextField()
        floor.font = UIFont.systemFont(ofSize: 14.0)
        floor.backgroundColor = .white
        floor.placeholder = "Enter a subject area"
        floor.autocorrectionType = .no
        floor.returnKeyType = .done
        floor.borderStyle = .roundedRect
        floor.translatesAutoresizingMaskIntoConstraints = false
        return floor
    }()
    
    lazy var sessionDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Description"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sessionDescriptionTextField: PaddedTextView = {
        let finding = PaddedTextView()
        finding.font = UIFont.systemFont(ofSize: 14.0)
        finding.backgroundColor = .white
        finding.autocorrectionType = .no
        finding.autocapitalizationType = .sentences
        finding.translatesAutoresizingMaskIntoConstraints = false
        return finding
    }()
    
    lazy var sessionDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Date & Time (Session duration is minimum 40 min)"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var datePicker :UIDatePicker!
    
    lazy var sessionDateTextField: PaddedTextField = {
        let dateField = PaddedTextField()
        dateField.font = UIFont.systemFont(ofSize: 14.0)
        dateField.backgroundColor = .white
        dateField.placeholder = "Select a date"
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.minimumDate = Date(timeIntervalSinceNow: 60 * 60 * 48)
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        dateField.inputView = datePicker
        dateField.translatesAutoresizingMaskIntoConstraints = false
        return dateField
    }()
    
    lazy var contactLabel: UILabel = {
        let contact = UILabel()
        contact.font = UIFont.systemFont(ofSize: 12.0)
        contact.text = "Contact (Email/ Mobile)"
        contact.textColor = .darkGray
        contact.translatesAutoresizingMaskIntoConstraints = false
        return contact
    }()
    
    lazy var contactTextField: PaddedTextField = {
        let contact = PaddedTextField()
        contact.font = UIFont.systemFont(ofSize: 14.0)
        contact.backgroundColor = .white
        contact.placeholder = "Enter mobile/ email"
        contact.autocorrectionType = .no
        contact.returnKeyType = .done
        contact.borderStyle = .roundedRect
        contact.translatesAutoresizingMaskIntoConstraints = false
        return contact
    }()
    
    
    lazy var presenterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Would like to present this session?"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var presenterSwitch: UISwitch = {
        let presenterswitch = UISwitch()
        presenterswitch.onTintColor = .ceruleanThree
        presenterswitch.tintColor = .blueyGrey
        presenterswitch.translatesAutoresizingMaskIntoConstraints = false
        return presenterswitch
    }()
    
    lazy var livestreamingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Do you need live streaming?"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var livestreamingSwitch: UISwitch = {
        let livestreamingswitch = UISwitch()
        livestreamingswitch.onTintColor = .ceruleanThree
        livestreamingswitch.tintColor = .blueyGrey
        livestreamingswitch.translatesAutoresizingMaskIntoConstraints = false
        return livestreamingswitch
    }()
    
    lazy var submitBackground: UIView = {
        let  submitbg = UIView()
        submitbg.backgroundColor = .cerulean
        submitbg.translatesAutoresizingMaskIntoConstraints = false
        return submitbg
    }()
    
    lazy var submitButton: UIButton = {
        let submit = UIButton()
        submit.setTitle("Send", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        submit.setImage(UIImage(named: "send"), for: .normal)
        submit.tintColor = .white
        submit.sizeToFit()
        submit.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        submit.translatesAutoresizingMaskIntoConstraints = false
        return submit
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = .white
        
        
        self.view.addSubview(sessionTitleLabel)
        self.view.addSubview(sessionTitleTextField)
        self.view.addSubview(sessionSubjectLabel)
        self.view.addSubview(sessionSubjectTextField)
        self.view.addSubview(sessionDescription)
        self.view.addSubview(sessionDescriptionTextField)
        self.view.addSubview(sessionDateLabel)
        self.view.addSubview(sessionDateTextField)
        self.view.addSubview(contactLabel)
        self.view.addSubview(contactTextField)
        self.view.addSubview(presenterLabel)
        self.view.addSubview(livestreamingLabel)
        self.view.addSubview(presenterSwitch)
        self.view.addSubview(livestreamingSwitch)
        self.view.addSubview(submitBackground)
        self.submitBackground.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            sessionTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionTitleLabel.topAnchor.constraint(equalTo: self.titleBackground.bottomAnchor, constant: 10.0),
            sessionTitleLabel.heightAnchor.constraint(equalToConstant: 14.0),
            sessionTitleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionTitleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionTitleTextField.topAnchor.constraint(equalTo: self.sessionTitleLabel.bottomAnchor, constant: 5.0),
            sessionTitleTextField.heightAnchor.constraint(equalToConstant: 45.0),
            sessionSubjectLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionSubjectLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionSubjectLabel.topAnchor.constraint(equalTo: self.sessionTitleTextField.bottomAnchor, constant: 15.0),
            sessionSubjectLabel.heightAnchor.constraint(equalToConstant: 14.0),
            sessionSubjectTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionSubjectTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionSubjectTextField.topAnchor.constraint(equalTo: self.sessionSubjectLabel.bottomAnchor, constant: 5.0),
            sessionSubjectTextField.heightAnchor.constraint(equalToConstant: 45.0),
            sessionDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionDescription.topAnchor.constraint(equalTo: self.sessionSubjectTextField.bottomAnchor, constant: 15.0),
            sessionDescription.heightAnchor.constraint(equalToConstant: 18.0),
            sessionDescriptionTextField.topAnchor.constraint(equalTo: self.sessionDescription.bottomAnchor, constant: 5.0),
            sessionDescriptionTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionDescriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionDescriptionTextField.heightAnchor.constraint(equalToConstant: 80.0),
            sessionDateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionDateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionDateLabel.topAnchor.constraint(equalTo: self.sessionDescriptionTextField.bottomAnchor, constant: 15.0),
            sessionDateLabel.heightAnchor.constraint(equalToConstant: 18.0),
            sessionDateTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            sessionDateTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            sessionDateTextField.topAnchor.constraint(equalTo: self.sessionDateLabel.bottomAnchor, constant: 5.0),
            sessionDateTextField.heightAnchor.constraint(equalToConstant: 45.0),
            contactLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            contactLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            contactLabel.topAnchor.constraint(equalTo: self.sessionDateTextField.bottomAnchor, constant: 15.0),
            contactLabel.heightAnchor.constraint(equalToConstant: 18.0),
            contactTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            contactTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            contactTextField.topAnchor.constraint(equalTo: self.contactLabel.bottomAnchor, constant: 5.0),
            contactTextField.heightAnchor.constraint(equalToConstant: 45.0),
            presenterLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            presenterLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            presenterLabel.topAnchor.constraint(equalTo: self.contactTextField.bottomAnchor, constant: 20.0),
            presenterLabel.heightAnchor.constraint(equalToConstant: 18.0),
            livestreamingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            livestreamingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            livestreamingLabel.topAnchor.constraint(equalTo: self.presenterLabel.bottomAnchor, constant: 25.0),
            livestreamingLabel.heightAnchor.constraint(equalToConstant: 18.0),
            presenterSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            presenterSwitch.centerYAnchor.constraint(equalTo: presenterLabel.centerYAnchor),
            livestreamingSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            livestreamingSwitch.centerYAnchor.constraint(equalTo: livestreamingLabel.centerYAnchor),
            submitBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -1.0),
            submitBackground.heightAnchor.constraint(equalToConstant: 50.0),
            submitBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            submitBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: CGFloat(-(self.height + 20.0))),
            submitButton.centerYAnchor.constraint(equalTo: submitBackground.centerYAnchor),
            submitButton.trailingAnchor.constraint(equalTo: submitBackground.trailingAnchor, constant: -10.0),
            submitButton.widthAnchor.constraint(equalToConstant: 120.0)
        ])
        
        self.sessionTitleTextField.delegate = self
        self.sessionSubjectTextField.delegate = self
        self.sessionDateTextField.delegate = self
        self.contactTextField.delegate = self
        
        sessionDescriptionTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(endTextEditing))
        sessionDateTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(datePickerDone))
        
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            self.contactTextField.text = user.email
        }
    }
    
    @objc func endTextEditing() {
        self.view.endEditing(true)
    }
    
    @objc func datePickerDone() {
        self.sessionDateTextField.resignFirstResponder()
    }
    
    @objc func dateChanged() {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyy hh:mm a"
        self.sessionDateTextField.text = df.string(from: datePicker.date)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.sessionTitleTextField.layer.cornerRadius = 5.0
        self.sessionTitleTextField.layer.masksToBounds = true
        self.sessionTitleTextField.layer.borderColor = UIColor.brownishGrey.cgColor
        self.sessionTitleTextField.layer.borderWidth = 1.0
        
        self.sessionDescriptionTextField.layer.cornerRadius = 5.0
        self.sessionDescriptionTextField.layer.masksToBounds = true
        self.sessionDescriptionTextField.layer.borderColor = UIColor.brownishGrey.cgColor
        self.sessionDescriptionTextField.layer.borderWidth = 1.0
        
        self.sessionSubjectTextField.layer.cornerRadius = 5.0
        self.sessionSubjectTextField.layer.masksToBounds = true
        self.sessionSubjectTextField.layer.borderColor = UIColor.brownishGrey.cgColor
        self.sessionSubjectTextField.layer.borderWidth = 1.0
        
        self.sessionDateTextField.layer.cornerRadius = 5.0
        self.sessionDateTextField.layer.masksToBounds = true
        self.sessionDateTextField.layer.borderColor = UIColor.brownishGrey.cgColor
        self.sessionDateTextField.layer.borderWidth = 1.0
        
        self.contactTextField.layer.cornerRadius = 5.0
        self.contactTextField.layer.masksToBounds = true
        self.contactTextField.layer.borderColor = UIColor.brownishGrey.cgColor
        self.contactTextField.layer.borderWidth = 1.0
        
        self.submitBackground.layer.borderColor = UIColor.white.cgColor
        self.submitBackground.layer.borderWidth = 1.0
        self.submitBackground.layer.cornerRadius = 10.0
        self.submitBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.submitBackground.layer.masksToBounds = true
        self.submitBackground.layer.shadowColor = UIColor.black.cgColor
        self.submitBackground.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.submitBackground.layer.cornerRadius = 10.0
        self.submitBackground.layer.shadowRadius = 1.0
        self.submitBackground.layer.shadowOpacity = 0.25
        self.submitBackground.layer.masksToBounds = false
        self.submitBackground.layer.shadowPath = UIBezierPath(roundedRect: self.submitBackground.bounds,
                                                              cornerRadius: self.submitBackground.layer.cornerRadius).cgPath
        
        self.submitButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25.0)
        self.submitButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.submitButton.bounds.width - 25.0, bottom: 0, right: 0)
    }
    
    
    @objc func submitForm() {
        
        if sessionTitleTextField.text?.isEmpty ?? false {
            MaahitaAlertView.instance.showError(message: "Please provide a title for the session") {
                return
            }
            return
        }
        
        if sessionSubjectTextField.text?.isEmpty ?? false {
            MaahitaAlertView.instance.showError(message: "Please provide a subject area for the session") {
                return
            }
            return
        }
        
        if sessionDescriptionTextField.text?.isEmpty ?? false {
            MaahitaAlertView.instance.showError(message: "Please provide complete description for the session") {
                return
            }
            return
        }
        
        if sessionDateTextField.text?.isEmpty ?? false {
            MaahitaAlertView.instance.showError(message: "Please select a date") {
                return
            }
            return
        }
        
        if contactTextField.text?.isEmpty ?? false {
            MaahitaAlertView.instance.showError(message: "Please provide your contact to discuss about the session") {
                return
            }
            return
        }
        
        var presenterID: String? = nil
        var presenter: String? = nil
        
        if let user = UserAuthService.instance.user, !user.isAnonymous,  self.presenterSwitch.isOn {
            presenterID = user.uid
            presenter = user.displayName
        }
        
        let request = SessionRequest(title: sessionTitleTextField.text!,
                                     description: sessionDescriptionTextField.text!,
                                     sessiontheme: sessionSubjectTextField.text!,
                                     presenterid: presenterID,
                                     presenter: presenter,
                                     sessiondate: self.datePicker.date,
                                     isStreamingRequired: self.livestreamingSwitch.isOn)
        
        SessionsService.instance.save(sessionRequest: request) { (saved) in
            if saved {
                MaahitaAlertView.instance.showInformation(message: "Request has been saved successfully. māhita team will reach you for more details.") {
                    return
                }
            } else {
                MaahitaAlertView.instance.showError(message: "Error occured while saving the request. Please try again later") {
                    return
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension SessionRequestViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
