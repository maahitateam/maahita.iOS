//
//  SessionViewProtocol.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

protocol SessionViewProtocol {
    var sessionCalView: UIView { get set }
    var sessionDay: UILabel { get set }
    var sessionMonth: UILabel { get set }
    var sessionTime: UILabel { get set }
    var sessionTimeTzone: UILabel { get set }
    var sessionTitle: UILabel { get set }
    var sessionDescription: UILabel { get set }
    var sessionPresneter: PaddingLabel { get set }
    var statusView: UIView { get set }
    var statusLabel: PaddingLabel { get set }
    var categoryLabel: PaddingLabel { get set }
}
