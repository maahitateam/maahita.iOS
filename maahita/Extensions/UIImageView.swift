//
//  UIImageView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 15/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(urlString: String){
        guard let url = URL(string: urlString) else {
            self.image = UIImage(named: "avatar")
            return
        }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data!) else {
                        self.image = UIImage(named: "avatar")
                        return
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}
