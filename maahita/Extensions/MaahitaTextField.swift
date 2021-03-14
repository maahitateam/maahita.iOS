//
//  MaahitaTextField.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

@IBDesignable
class MaahitaTextField: UITextField {
    
    var rightImageTapHandler: () -> Void = {}
    
    var rightViewToggle : Bool = false
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        //textRect.size.width = textRect.size.width - rightPadding
        return textRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += leftPadding + 5
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x = textRect.origin.x - rightPadding
        //textRect.size.width = textRect.size.width - rightPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
            updateRightView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
            updateRightView()
        }
    }
    
    @IBInspectable var rightToggleImage: UIImage?
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var imageColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
            updateRightView()
        }
    }
    
    @IBInspectable var borderBottom : Bool = false {
        didSet {
            addLineToView(view: self, position:.LINE_POSITION_BOTTOM, color: nil, width: 0.5)
        }
    }
    
    @IBInspectable var borderTop : Bool = false {
        didSet {
            addLineToView(view: self, position:.LINE_POSITION_TOP, color: nil, width: 0.5)
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: imageColor])
    }
    
    func updateRightView() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(rec:)))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: imageColor])
    }
    
    @objc func rightImageTapped(rec: UITapGestureRecognizer) {
        rightViewToggle = !rightViewToggle
        self.rightViewToggled(toggle: rightViewToggle)
    }
    
    func rightViewToggled (toggle : Bool){
        if toggle , let image = rightToggleImage {
            rightView = nil
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(rec:)))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
            rightView = imageView
        } else if let image = rightImage {
            rightView = nil
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(rec:)))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
        
        rightImageTapHandler()
    }
    
    func rightViewToggledWithoutHandler (toggle : Bool){
        if toggle , let image = rightToggleImage {
            rightView = nil
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(rec:)))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
            rightView = imageView
        } else if let image = rightImage {
            rightView = nil
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = imageColor
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(rec:)))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor?, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color ?? self.borderColor
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        default:
            break
        }
    }
}
