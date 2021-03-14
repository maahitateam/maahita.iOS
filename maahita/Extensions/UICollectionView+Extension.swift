//
//  UICollectionView+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UICollectionView {
    func getCell(with cellClass: AnyClass, at indexPath: IndexPath) -> UICollectionViewCell {
        let cellTypeName = NSStringFromClass(cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: cellTypeName)
        return self.dequeueReusableCell(withReuseIdentifier: cellTypeName, for: indexPath)
    }
    
    func getSupplementaryView(with viewClass: AnyClass, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableViewName = NSStringFromClass(viewClass)
        
        self.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableViewName)
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableViewName, for: indexPath)
    }
}
