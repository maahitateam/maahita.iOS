//
//  HeaderViewDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

class HeaderViewDataSource<T> : NSObject {
    var livedata: DynamicValue<[T]> = DynamicValue([])
    var feedbackdata: DynamicValue<[T]> = DynamicValue([])
    var dashboarddata: DynamicValue<Dashboard> = DynamicValue(Dashboard(enrolled: 0, attended: 0, completed: 0))
}
