//
//  UIViewController+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 16/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UIViewController {
    func showToast(message : String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25.0),
            toastLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25.0),
            toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80.0),
            toastLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIViewController {

    // MARK: IS SWIPABLE - FUNCTION
    func isSwipable() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    // MARK: HANDLE PAN GESTURE - FUNCTION
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        let minY = view.frame.height * 0.135
        var originalPosition = CGPoint.zero

        if panGesture.state == .began {
            originalPosition = view.center
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(x: 0.0, y: translation.y)

            if panGesture.location(in: view).y > minY {
                view.frame.origin = originalPosition
            }

            if view.frame.origin.y <= 0.0 {
                view.frame.origin.y = 0.0
            }
        } else if panGesture.state == .ended {
            if view.frame.origin.y >= view.frame.height * 0.5 {
                UIView.animate(withDuration: 0.2
                     , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin = originalPosition
                })
            }
        }
    }

}
