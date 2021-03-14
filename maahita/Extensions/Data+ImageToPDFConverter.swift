//
//  Data+ImageToPDFConverter.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 30/07/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

let defaultResolution: Int = 72

extension NSData {
    
//    class func convertImageToPDF(image: UIImage) -> NSData? {
//        return convertImageToPDF(image: image, resolution: 96)
//    }
//
//    class func convertImageToPDF(image: UIImage, resolution: Double) -> NSData? {
//        return convertImageToPDF(image: image, horizontalResolution: resolution, verticalResolution: resolution)
//    }
//
//    class func convertImageToPDF(image: UIImage, horizontalResolution: Double, verticalResolution: Double) -> NSData? {
//
//        if horizontalResolution <= 0 || verticalResolution <= 0 {
//            return nil;
//        }
//
//        let pageWidth: Double = Double(image.size.width) * Double(image.scale) * Double(defaultResolution) / horizontalResolution
//        let pageHeight: Double = Double(image.size.height) * Double(image.scale) * Double(defaultResolution) / verticalResolution
//
//        let pdfFile: NSMutableData = NSMutableData()
//
//        guard let pdfConsumer = CGDataConsumer(data: pdfFile as CFMutableData) else { return nil }
//
//        var mediaBox: CGRect = CGRect(x: 0, y: 0, width: CGFloat(pageWidth), height: CGFloat(pageHeight))
//
//        guard let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil) else { return nil }
//
//        pdfContext.beginPage(mediaBox: &mediaBox)
//        CGContextDrawImage(pdfContext, mediaBox, image.cgImage)
//        pdfContext.endPage()
//
//
//        return pdfFile
//    }
//
//    class func convertImageToPDF(image: UIImage, resolution: Double, maxBoundRect: CGRect, pageSize: CGSize) -> NSData? {
//
//        if resolution <= 0 {
//            return nil
//        }
//
//        var imageWidth: Double = Double(image.size.width) * Double(image.scale) * Double(defaultResolution) / resolution
//        var imageHeight: Double = Double(image.size.height) * Double(image.scale) * Double(defaultResolution) / resolution
//
//        let sx: Double = imageWidth / Double(maxBoundRect.size.width)
//        let sy: Double = imageHeight / Double(maxBoundRect.size.height)
//
//        if sx > 1 || sy > 1 {
//            let maxScale: Double = sx > sy ? sx : sy
//            imageWidth = imageWidth / maxScale
//            imageHeight = imageHeight / maxScale
//        }
//
//        let imageBox: CGRect = CGRectMake(maxBoundRect.origin.x, maxBoundRect.origin.y + maxBoundRect.size.height - CGFloat(imageHeight), CGFloat(imageWidth), CGFloat(imageHeight));
//
//        let pdfFile: NSMutableData = NSMutableData()
//
//        let pdfConsumer: CGDataConsumerRef = CGDataConsumerCreateWithCFData(pdfFile as CFMutableDataRef)
//
//        var mediaBox: CGRect = CGRectMake(0, 0, pageSize.width, pageSize.height);
//
//        let pdfContext: CGContextRef = CGPDFContextCreate(pdfConsumer, &mediaBox, nil)
//
//        CGContextBeginPage(pdfContext, &mediaBox)
//        CGContextDrawImage(pdfContext, imageBox, image.CGImage)
//        CGContextEndPage(pdfContext)
//
//        return pdfFile
//    }
}
