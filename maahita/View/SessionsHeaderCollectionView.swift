//
//  SessionsHeaderCollectionView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 20/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionsHeaderCollectionView: UIView {
    
    let datasource = SessionsHeaderDataSource()
    
    lazy var viewModel : SessionsHeaderViewModel = {
        let viewModel = SessionsHeaderViewModel(dataSource: datasource)
        return viewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.delegate = self
        collectionview.dataSource = self.datasource
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var cardsCountIndicator: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.pageIndicatorTintColor = .lightGray
        pagecontrol.currentPageIndicatorTintColor = .cerulean
        pagecontrol.isUserInteractionEnabled = false
        pagecontrol.translatesAutoresizingMaskIntoConstraints = false
        return pagecontrol
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UserAuthService.instance.delegates?.append(self)
        
        addSubview(collectionView)
        addSubview(cardsCountIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardsCountIndicator.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            cardsCountIndicator.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 10.0),
            cardsCountIndicator.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -10.0)
        ])
        
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 30, right: 10)
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .horizontal
        flowLayout.invalidateLayout()
        
        self.datasource.livedata.addAndNotify(observer: self) { [weak self] in
            self?.reloadData()
        }
        
        self.datasource.feedbackdata.addAndNotify(observer: self) { [weak self] in
            self?.reloadData()
        }
        
        self.datasource.dashboarddata.addAndNotify(observer: self) { [weak self] in
            self?.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func updateUI() {
        self.viewModel.fetchHeaderData()
    }
    
    fileprivate func reloadData() {
        self.collectionView.reloadData()
        
        let pageCount = self.collectionView.numberOfItems(inSection: 0)
        self.cardsCountIndicator.numberOfPages = pageCount
        self.cardsCountIndicator.isHidden = !(pageCount > 1)
    }
}

extension SessionsHeaderCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round(index)
        self.cardsCountIndicator.currentPage = Int(roundedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calulateHeight = self.bounds.height - 35.0
        return CGSize(width: collectionView.bounds.width - 20.0, height: calulateHeight)
    }
}

extension SessionsHeaderCollectionView: AuthServiceDelegate {
    func refreshUser() {
        self.updateUI()
    }
}
