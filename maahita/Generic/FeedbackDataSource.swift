//
//  FeedbackDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

class FeedbackDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    var session: DynamicValue<MaahitaSession> = DynamicValue(MaahitaSession())
}
