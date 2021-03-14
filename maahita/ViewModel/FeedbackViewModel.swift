//
//  FeedbackViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

struct FeedbackViewModel {
    weak var dataSource: FeedbackDataSource<Feedback>?
    
    init(dataSource: FeedbackDataSource<Feedback>) {
        self.dataSource = dataSource
    }
    
    func fetchFeedback() {
        FeedbackService.instance.get()
    }
    
    func submitFeedback() {
        
    }
}
