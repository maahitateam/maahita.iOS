//
//  UIView+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 18/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UIView {
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.cornerRadius = 10.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}

extension UIDevice {

    /// Returns 'true' if the device has a notch
   static var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow else { return false }
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

extension UIControl {
    func listen(_ action: @escaping () -> (), for controlEvents: UIControl.Event) -> AnyObject {
        let sleeve = ClosureSleeve(attachTo: self, closure: action, controlEvents: controlEvents)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        return sleeve
    }
    
    func listenOnce(_ action: @escaping () -> (), for controlEvents: UIControl.Event) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action, controlEvents: controlEvents)
        addTarget(sleeve, action: #selector(ClosureSleeve.invokeOnce), for: controlEvents)
    }
    
    func unlisten(sleeve: AnyObject) {
        guard let sleeve = sleeve as? ClosureSleeve else { return }
        self.removeTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: sleeve.controlEvents)
    }
}

private class ClosureSleeve {
    let closure: () -> ()
    let controlEvents:UIControl.Event
    let attachedTo: UIControl
    
    init(attachTo: UIControl, closure: @escaping () -> (), controlEvents:UIControl.Event) {
        self.attachedTo = attachTo
        self.closure = closure
        self.controlEvents = controlEvents
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke() {
        closure()
    }
    
    @objc func invokeOnce() {
        closure()
        attachedTo.unlisten(sleeve: self)
    }
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    func rightTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetAmount)
    }
}

extension UIView {
    func showMaahitaToast(message: String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.showToast(message: message)
        }
    }
}
