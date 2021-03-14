//
//  UITextFiled+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UITextField {
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UITextField {
    
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
    iconView.image = image
    let width = self.borderStyle == .none ? 45 : 35
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
    
    func setRightView(image: UIImage) {
      let iconView = UIImageView(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
      iconView.image = image
      let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
      iconContainerView.addSubview(iconView)
      rightView = iconContainerView
      rightViewMode = .always
      self.tintColor = .lightGray
    }
}
