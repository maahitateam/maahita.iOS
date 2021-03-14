//
//  GenericDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 17/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
