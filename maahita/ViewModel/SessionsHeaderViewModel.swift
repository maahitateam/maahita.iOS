//
//  SessionsHeaderViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

struct SessionsHeaderViewModel {
    weak var dataSource:  HeaderViewDataSource<MaahitaSession>?
    
    init(dataSource: HeaderViewDataSource<MaahitaSession>) {
        self.dataSource = dataSource
        DashboardService.instance.delegate = self
        FeedbackService.instance.feedbackDelegate = self
    }
    
    func fetchHeaderData() {
        DashboardService.instance.getLive()
        FeedbackService.instance.get()
        DashboardService.instance.dashboard()
    }
}

extension SessionsHeaderViewModel : DashboardServiceDelegate, FeedbackServiceDelegate {
    func refresh(feedback: [MaahitaSession]?) {
        self.dataSource?.feedbackdata.value = feedback
    }
    
    func refresh(dashboard: Dashboard?) {
        self.dataSource?.dashboarddata.value = dashboard
    }
    
    func refresh(livesessions: [MaahitaSession]?) {
        self.dataSource?.livedata.value = livesessions
    }
    
    func refresh(feedbacksessions: [MaahitaSession]?) {
        
    }
}
