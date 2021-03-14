//
//  UIColor_Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 12/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(from hexString: String) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(ciColor: .gray)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
    
    @nonobjc class var themeColor: UIColor {
        return UIColor(from: "#1c4489")
    }
    
    @nonobjc class var irishGreen: UIColor {
        return UIColor(red: 0.0, green: 133.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deepTeal: UIColor {
        return UIColor(red: 0.0, green: 68.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tangerine: UIColor {
        return UIColor(red: 1.0, green: 143.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var sunflowerYellow: UIColor {
        return UIColor(red: 1.0, green: 218.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var scarlet: UIColor {
        return UIColor(red: 214.0 / 255.0, green: 8.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueberry: UIColor {
        return UIColor(red: 92.0 / 255.0, green: 44.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var marineBlue: UIColor {
        return UIColor(red: 0.0, green: 36.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkishBlue: UIColor {
        return UIColor(red: 0.0, green: 51.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cobaltBlue: UIColor {
        return UIColor(red: 0.0, green: 56.0 / 255.0, blue: 174.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cerulean: UIColor {
        return UIColor(red: 0.0, green: 100.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var ceruleanTwo: UIColor {
        return UIColor(red: 0.0, green: 138.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var charcoalGrey: UIColor {
        return UIColor(red: 66.0 / 255.0, green: 68.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueyGrey: UIColor {
        return UIColor(red: 150.0 / 255.0, green: 151.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var beige: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 207.0 / 255.0, blue: 205.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var ceruleanThree: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 197.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var oceanBlue: UIColor {
        return UIColor(red: 0.0, green: 101.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var navyBlue: UIColor {
        return UIColor(red: 0.0, green: 28.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black0: UIColor {
        return UIColor(white: 0.0, alpha: 0.0)
    }
    
    @nonobjc class var black60: UIColor {
        return UIColor(white: 0.0, alpha: 0.6)
    }
    
    @nonobjc class var white23: UIColor {
        return UIColor(white: 1.0, alpha: 0.23)
    }
    
    @nonobjc class var white90: UIColor {
        return UIColor(white: 1.0, alpha: 0.9)
    }
    
    @nonobjc class var brownishGrey: UIColor {
        return UIColor(white: 112.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black16: UIColor {
        return UIColor(white: 0.0, alpha: 0.16)
    }
    
    @nonobjc class var pumpkinOrange: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 138.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 21.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var rouge: UIColor {
        return UIColor(red: 168.0 / 255.0, green: 36.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var celltopshade: UIColor {
        return UIColor(from: "#294d9b")
    }
    
    @nonobjc class var black53: UIColor {
        return UIColor(white: 0.0, alpha: 0.53)
    }
    
    @nonobjc class var white50: UIColor {
        return UIColor(white: 1.0, alpha: 0.5)
    }
}
