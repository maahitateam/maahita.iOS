//
//  PaddedLabel.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    init(padding: CGFloat) {
        super.init(frame: CGRect.zero)
        
        self.topInset = padding
        self.bottomInset = padding
        self.leftInset = padding
        self.rightInset = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 5.0
    var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
