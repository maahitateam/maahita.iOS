//
//  SessionsViewController.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase

class SessionsViewController: UIViewController {
    
    let dataSource = SessionsDataSource()
    
    lazy var viewModel : SessionsViewModel = {
        let viewModel = SessionsViewModel(dataSource: dataSource)
        return viewModel
    }()
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self.dataSource
        collectionview.bounces = false
        collectionview.alwaysBounceVertical = false
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
       
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "maahita")
        logo.contentMode = .scaleAspectFit
        logo.tintColor = UIColor.gray.withAlphaComponent(0.5)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    lazy var noDataLabel: UILabel = {
        let nodata = UILabel()
        nodata.text = "Currently no sessions have been scheduled. stay in touch, we will come back soon."
        nodata.textAlignment = .center
        nodata.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        nodata.numberOfLines = 0
        nodata.lineBreakMode = .byWordWrapping
        nodata.textColor = .darkGray
        nodata.sizeToFit()
        nodata.translatesAutoresizingMaskIntoConstraints = false
        return nodata
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        UserAuthService.instance.delegates?.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGroupedBackground
        } else {
            self.view.backgroundColor = .groupTableViewBackground
        }
        
        self.view.addSubview(self.logoImage)
        self.view.addSubview(self.noDataLabel)
        self.view.addSubview(self.collectionView)            
        
        self.edgesForExtendedLayout = .all
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100.0),
            self.logoImage.widthAnchor.constraint(equalToConstant: 100.0),
            self.logoImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            self.logoImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10.0),
            self.noDataLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noDataLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.noDataLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12.0),
            self.noDataLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12.0)
        ])
        
        self.collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
       
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.invalidateLayout()
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
            let items = self?.collectionView.numberOfItems(inSection: 0) ?? 0
            self?.noDataLabel.isHidden = items > 0
        }
        
        self.updateUI()
        
        Messaging.messaging().subscribe(toTopic: "maahitaNotifications") { error in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func updateUI() {
        self.viewModel.fetchSessions()
    }
}

extension SessionsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let user = UserAuthService.instance.user, !user.isAnonymous, indexPath.item == 0 {
            let requestViewController = SessionRequestViewController()
            NavigationUtility.presentOverCurrentContext(destination: requestViewController, style: .overCurrentContext) {
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SessionCell else { return }
            
            let sessionViewController = SessionViewController(sessionID: cell.maahitaSession.id, groupID: cell.maahitaSession.groupID)
            NavigationUtility.presentOverCurrentContext(destination: sessionViewController, style: .overCurrentContext) {
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let user = UserAuthService.instance.user, !user.isAnonymous, indexPath.item == 0 {
            return CGSize(width: collectionView.bounds.width-20.0, height: 50.0)
        }
        
        return CGSize(width: collectionView.bounds.width-20.0, height: 120.0)
    }
}

extension SessionsViewController: AuthServiceDelegate {
    func refreshUser() {
        self.updateUI()
    }
}
