//
//  FeedbackViewModel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

class FeedbackCellViewModel {
    private var feedback: Feedback
    
    init(feedback: Feedback) {
        self.feedback = feedback
    }
}

extension FeedbackCellViewModel {
    func configure(_ view: FeedbackCell) {
        
    }
    
    func set(value: Double) {
        feedback.value = value
    }
}
