//
//  UIImage+Extension.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 19/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

extension UIImage {
    func getArrayOfBytesFromJpeg() -> NSMutableArray?
    {
        guard let imageData = self.jpegData(compressionQuality: 0.1) else { return nil }
        
        // the number of elements:
        let count = imageData.count / MemoryLayout.size(ofValue: UInt8.self)

        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)

        // copy bytes into array
        imageData.copyBytes(to: &bytes, count: count * MemoryLayout.size(ofValue: UInt8.self))

        let byteArray:NSMutableArray = NSMutableArray()

        for byte in bytes {
            byteArray.add(NSNumber(value: byte))
        }

        return byteArray
    }
}
