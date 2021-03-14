//
//  Feedback.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import Foundation
import Firebase

struct Feedback {
    var id: String
    var name: String?
    var value: Double
    
    init(snapshot : QueryDocumentSnapshot) {
        id = snapshot.documentID
        name = snapshot.get("name") as? String
        value = 3.0
    }
    
    init(snapshot : DocumentSnapshot) {
        id = snapshot.documentID
        name = snapshot.get("name") as? String
        value = 3.0
    }
}
