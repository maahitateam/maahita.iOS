//
//  SessionRequest.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 29/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation

struct SessionRequest {
    let title: String
    let description: String
    let sessiontheme: String
    let presenterid: String?
    let presenter: String?
    let sessiondate: Date
    let isStreamingRequired: Bool
}
