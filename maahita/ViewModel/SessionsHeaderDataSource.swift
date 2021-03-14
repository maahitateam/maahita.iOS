//
//  SessionsHeaderDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

protocol SessionsHeaderDataSourceDelegate {
    func attend(session: SessionViewModel?)
    func open(session: SessionViewModel?)
}

class SessionsHeaderDataSource: HeaderViewDataSource<MaahitaSession>, UICollectionViewDataSource {
    var cardsCount : Int {
        get {
            return (self.livedata.value?.count ?? 0) + (self.feedbackdata.value?.count ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let livesessionsCount = self.livedata.value?.count ?? 0
        
        if (livesessionsCount > indexPath.item) {
            guard let cell: LiveSessionCell = collectionView.getCell(with: LiveSessionCell.self, at: indexPath) as? LiveSessionCell else {
                preconditionFailure("Invalid cell type")
            }
            if let livesession = self.livedata.value?[indexPath.item] {
                cell.liveSession = SessionViewModel(session: livesession)
            }
            return cell
        } else if cardsCount > indexPath.item {
            guard let cell: FeedbackRequestCell = collectionView.getCell(with: FeedbackRequestCell.self, at: indexPath) as? FeedbackRequestCell else {
                preconditionFailure("Invalid cell type")
            }
            let index = indexPath.item - livesessionsCount
            if let feedbackSession = self.feedbackdata.value?[index] {
                cell.feedbackSession = SessionViewModel(session: feedbackSession)
            }
            return cell
        }
        else {
            guard let cell: DashboardCell = collectionView.getCell(with: DashboardCell.self, at: indexPath) as? DashboardCell else {
                preconditionFailure("Invalid cell type")
            }
            
            if let dashboard = self.dashboarddata.value {
                cell.dashboardViewModel = DashboardViewModel(dashboard: dashboard)
            }
            
            return cell
        }
    }
}
