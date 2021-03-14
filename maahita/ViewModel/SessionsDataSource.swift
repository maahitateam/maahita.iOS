//
//  SessionsDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 17/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionsDataSource: GenericDataSource<MaahitaSession>, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            return (data.value?.count ?? 0) + 1
        }
        
        return data.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let user = UserAuthService.instance.user, !user.isAnonymous {
            
            if indexPath.item == 0 {
                guard let cell = collectionView.getCell(with: AddSessionCell.self, at: indexPath) as? AddSessionCell else {
                    preconditionFailure("Invalid cell type")
                }
                return cell
            } else {
                guard let cell = collectionView.getCell(with: SessionCell.self, at: indexPath) as? SessionCell else {
                    preconditionFailure("Invalid cell type")
                }
                if let session = data.value?[indexPath.item - 1] {
                    cell.maahitaSession = SessionViewModel(session: session)
                }
                
                return cell
            }
        } else {
            guard let cell = collectionView.getCell(with: SessionCell.self, at: indexPath) as? SessionCell else {
                preconditionFailure("Invalid cell type")
            }
            if let session = data.value?[indexPath.item] {
                cell.maahitaSession = SessionViewModel(session: session)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.getSupplementaryView(with: SessionsHeaderView.self, viewForSupplementaryElementOfKind: kind, at: indexPath) as? SessionsHeaderView else {
            preconditionFailure("Invalid cell type")
        }
        return headerView
    }
}
