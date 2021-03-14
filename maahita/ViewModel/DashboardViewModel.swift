//
//  DashboardViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 22/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class DashboardViewModel {
    
    private let dashboard: Dashboard
    
    init(dashboard: Dashboard) {
        self.dashboard = dashboard
    }
}

extension DashboardViewModel {
    func configure(_ view: DashboardCell) {
        view.statsView.refreshView(dashboard: dashboard)
    }
}
