//
//  SessionPresenterControl.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 27/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import EventKit
import Firebase

enum SessionAction: Int {
    case Enroll
    case Attend
    case Start
    case Stop
    case Cancel
    case AddToCalendar
    case Share
    case NoAction
}

protocol SessionPresenterControlDelegate  {
    func doShare()
}

class SessionPresenterControl : UIView {
    
    var delegate: SessionPresenterControlDelegate?
    
    let eventStore = EKEventStore()
    
    var sessionAction: SessionAction = .NoAction
    
    var sessionViewModel : SessionDetailViewModel? {
        didSet {
            self.updateUI()
        }
    }
    
    lazy var sessionControlTable: UITableView = {
        let controlTable = UITableView(frame: CGRect.zero, style: .grouped)
        controlTable.backgroundColor = .clear
        controlTable.tableFooterView = UIView()
        controlTable.delegate = self
        controlTable.dataSource = self
        controlTable.separatorStyle = .none
        controlTable.translatesAutoresizingMaskIntoConstraints = false
        return controlTable
    }()
    
    lazy var controlsCollection: UICollectionView = {
        let controls = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        controls.showsVerticalScrollIndicator = false
        controls.showsHorizontalScrollIndicator = false
        controls.backgroundColor = .clear
        controls.delegate = self
        controls.dataSource = self
        controls.translatesAutoresizingMaskIntoConstraints = false
        return controls
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(sessionControlTable)
        
        NSLayoutConstraint.activate([
            sessionControlTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            sessionControlTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            sessionControlTable.topAnchor.constraint(equalTo: topAnchor),
            sessionControlTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateUI() {
        self.sessionControlTable.reloadData()
        self.controlsCollection.reloadData()
    }
}

extension SessionPresenterControl: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let status = sessionViewModel?.sessionStatus {
            if status.rawValue <= SessionStatus.Started.rawValue {
                if sessionViewModel?.isPresenter ?? false {
                    return 2
                } else {
                    return 1
                }
            } else if status == .Completed {
                return 2
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let status = sessionViewModel?.sessionStatus {
            if status.rawValue <= SessionStatus.Started.rawValue {
                    if section == 0 {
                        return 1
                    } else {
                        return 0
                    }
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(with: UITableViewCell.self, at: indexPath)
        cell.backgroundColor = .clear
        if indexPath.row == 0 {
            cell.addSubview(controlsCollection)
            
            guard let flowLayout = controlsCollection.collectionViewLayout as? UICollectionViewFlowLayout else {
                preconditionFailure("Error occurred")
            }
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
            flowLayout.minimumLineSpacing = 10.0
            flowLayout.invalidateLayout()
            
            NSLayoutConstraint.activate([
                controlsCollection.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                controlsCollection.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                controlsCollection.topAnchor.constraint(equalTo: cell.topAnchor),
                controlsCollection.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
            ])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95.0
        } else {
            return 40.0
        }
    }
}

extension SessionPresenterControl: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let status = sessionViewModel?.sessionStatus, status.rawValue <= SessionStatus.Started.rawValue {
            if sessionViewModel?.isPresenter ?? false {
                return status == .Started ? 5 : 4
            } else {
                return 3
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SessionActionCell = collectionView.getCell(with: SessionActionCell.self, at: indexPath) as?  SessionActionCell else {
            preconditionFailure("Invalid action cell type")
        }
        if let status = sessionViewModel?.sessionStatus {
            if status.rawValue <= SessionStatus.Started.rawValue {
                if sessionViewModel?.isPresenter ?? false {
                    if indexPath.item == 0 {
                        if status == .Started {
                            cell.setup(title: "Attend", titleColor: .white, bgColor: .cerulean)
                        } else {
                            cell.setup(title: "Start", titleColor: .white, bgColor: .cerulean)
                        }
                    } else if indexPath.item == 1 {
                        cell.setup(title: "Share", titleColor: .brown)
                    } else if indexPath.item == 2 {
                        cell.setup(title: "Add to calendar", titleColor: .blueyGrey)
                    } else if indexPath.item == 3 && status == .Started {
                        cell.setup(title: "Stop", titleColor: .white, bgColor: .scarlet)
                    } else {
                        cell.setup(title: "Cancel", titleColor: .scarlet)
                    }
                } else {
                        if indexPath.item == 0 {
                            cell.backgroundColor = .cerulean
                            if status == .Started {
                                cell.setup(title: "Attend", titleColor: .white, bgColor: .cerulean)
                            } else if status == .Enrolled {
                                cell.setup(title: "No Action", titleColor: .white, bgColor: .blueyGrey)
                            } else {
                                cell.setup(title: "Enroll", titleColor: .white, bgColor: .cerulean)
                            }
                        } else if indexPath.row == 1 {
                            cell.setup(title: "Share", titleColor: .brown, bgColor: .white)
                        } else if indexPath.row == 2 {
                            cell.setup(title: "Add to calendar", titleColor: .blueyGrey, bgColor: .white)
                        }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let status = sessionViewModel?.sessionStatus {
            if status.rawValue <= SessionStatus.Started.rawValue {
                if sessionViewModel?.isPresenter ?? false {
                    if indexPath.item == 0 {
                        if status == .Started {
                            self.sessionAction = .Attend
                        } else {
                            self.sessionAction = .Start
                        }
                    } else if indexPath.item == 1 {
                        self.sessionAction = .Share
                    } else if indexPath.item == 2 {
                        self.sessionAction = .AddToCalendar
                    } else if indexPath.item == 3 && status == .Started {
                        self.sessionAction = .Stop
                    } else {
                        self.sessionAction = .Cancel
                    }
                } else {
                        if indexPath.item == 0 {
                            if status == .Started {
                                self.sessionAction = .Attend
                            } else if status == .Enrolled {
                                self.sessionAction = .NoAction
                            } else {
                                self.sessionAction = .Enroll
                            }
                        } else if indexPath.row == 1 {
                            self.sessionAction = .Share
                        } else if indexPath.row == 2 {
                            self.sessionAction = .AddToCalendar
                        }
                }
            }
        }
        
        self.doSomeAction()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40.0) / 3
        return CGSize(width: width, height: 40.0)
    }
    
    fileprivate func doSomeAction() {
        switch self.sessionAction {
            case .Start:
                self.startSession()
            case .Stop:
                self.stopSession()
            case .Enroll:
                self.enrollSession()
            case .Attend:
                self.attendSession()
            case .Share:
                self.delegate?.doShare()
            case .AddToCalendar:
                self.addToCalendar()
            case .Cancel:
                self.cancelSession()
            default:
                return
        }
    }
    
    fileprivate func startSession() {
        MaahitaAlertView.instance.askConfirmation(message: "Are you sure, you would like to start the session?", yesAction: {
            SessionsService.instance.startSession(sessionID: self.sessionViewModel!.id, title: self.sessionViewModel!.title, groupID: self.sessionViewModel?.groupID) { (completed) in
                if completed {
                    MaahitaAlertView.instance.showInformation(message: "Session has been started succesfully. Please press Attend and wait for an administrator to allow you in classroom") { [weak self] in
                        self?.updateUI()
                    }
                } else {
                    MaahitaAlertView.instance.showError(message: "Oops... something went wrong. Please contact māhita team") { [weak self] in
                        self?.updateUI()
                    }
                }
            }
        }) {
            
        }
    }
    
    fileprivate func stopSession() {
        MaahitaAlertView.instance.askConfirmation(message: "Are you sure, you would like to stop the session?", yesAction: {
            SessionsService.instance.stopSession(sessionID: self.sessionViewModel!.id, groupID: self.sessionViewModel?.groupID) { (completed) in
                if completed {
                    MaahitaAlertView.instance.showInformation(message: "Session has been stopped succesfully") { [weak self] in
                        self?.updateUI()
                    }
                } else {
                    MaahitaAlertView.instance.showError(message: "Oops... something went wrong. Please contact māhita team") { [weak self] in
                        self?.updateUI()
                    }
                }
            }
        }) {
            
        }
    }
    
    fileprivate func enrollSession() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            self.sessionViewModel?.action(userID: user.uid)
            self.updateUI()
        } else {
            let loginViewController = LoginViewController()
            NavigationUtility.presentOverCurrentContext(destination: loginViewController)
        }
    }
    
    fileprivate func attendSession() {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            let meetingViewController = MeetingViewController(sessionID: self.sessionViewModel?.id ?? "",
                                                              meetingID: self.sessionViewModel?.meetingID ?? "",
                                                              title: self.sessionViewModel?.title ?? "", groupID: nil)
            NavigationUtility.presentOverCurrentContext(destination: meetingViewController, style: .fullScreen) { [weak self] in
                meetingViewController.joinMeeting(isPresenter: self?.sessionViewModel?.isPresenter ?? false)
            }
        } else {
            let loginViewController = LoginViewController()
            NavigationUtility.presentOverCurrentContext(destination: loginViewController)
        }
    }
    
    fileprivate func addToCalendar() {
        let calendar = eventStore.defaultCalendarForNewEvents
        guard let startDate = self.sessionViewModel?.sessionDate else { return }

        let endDate = startDate.addingTimeInterval(1 * 60 * 60)

        let event = EKEvent(eventStore: eventStore)
        event.calendar = calendar

        event.title = self.sessionViewModel?.title
        event.startDate = startDate
        event.endDate = endDate

        do {
            try eventStore.save(event, span: .thisEvent)
            self.showMaahitaToast(message: "Added this session to calendar")
        }
        catch {
            self.showMaahitaToast(message: "Failed to add to calendar")
        }
    }
    
    fileprivate func cancelSession() {
        MaahitaAlertView.instance.askConfirmation(message: "Are you sure, you would like to cancel the session?", yesAction: {
            SessionsService.instance.cancelSession(sessionID: self.sessionViewModel!.id, title: self.sessionViewModel!.title, groupID: self.sessionViewModel?.groupID) { (completed) in
                if completed {
                    MaahitaAlertView.instance.showInformation(message: "Session has been cancelled succesfully") { [weak self] in
                        self?.updateUI()
                    }
                } else {
                    MaahitaAlertView.instance.showError(message: "Oops... something went wrong. Please contact māhita team") { [weak self] in
                        self?.updateUI()
                    }
                }
            }
        }) {
            
        }
    }
}
