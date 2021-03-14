//
//  UITableView+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UITableView {
    func getCell(with cellClass: AnyClass, at indexPath: IndexPath) -> UITableViewCell {
        let cellTypeName = NSStringFromClass(cellClass)
        self.register(cellClass, forCellReuseIdentifier: cellTypeName)
        return self.dequeueReusableCell(withIdentifier: cellTypeName, for: indexPath)
    }
    
    func getHeader(with viewClass: AnyClass) -> UITableViewHeaderFooterView? {
        let viewTypeName = NSStringFromClass(viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: viewTypeName)
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewTypeName)
    }
}
