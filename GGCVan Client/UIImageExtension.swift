//
//  UIImageExtension.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-12-05.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Resize the image to be the required size, stretching it as needed.
    ///
    /// - parameter newSize:      The new size of the image.
    /// - parameter contentMode:  The `UIViewContentMode` to be applied when resizing image.
    ///                           Either `.scaleToFill`, `.scaleAspectFill`, or `.scaleAspectFit`.
    ///
    /// - returns:                Return `UIImage` of resized image.
    
    func scaled(to newSize: CGSize, contentMode: UIViewContentMode = .scaleToFill) -> UIImage? {
        if contentMode == .scaleToFill {
            return filled(to: newSize)
        } else if contentMode == .scaleAspectFill || contentMode == .scaleAspectFit {
            let horizontalRatio = size.width  / newSize.width
            let verticalRatio   = size.height / newSize.height
            
            let ratio: CGFloat!
            if contentMode == .scaleAspectFill {
                ratio = min(horizontalRatio, verticalRatio)
            } else {
                ratio = max(horizontalRatio, verticalRatio)
            }
            
            let sizeForAspectScale = CGSize(width: size.width / ratio, height: size.height / ratio)
            let image = filled(to: sizeForAspectScale)
            if contentMode == .scaleAspectFill {
                let subRect = CGRect(
                    x: floor((sizeForAspectScale.width - newSize.width) / 2.0),
                    y: floor((sizeForAspectScale.height - newSize.height) / 2.0),
                    width: newSize.width,
                    height: newSize.height)
                return image?.cropped(to: subRect)
            }
            return image
        }
        return nil
    }
    
    /// Resize the image to be the required size, stretching it as needed.
    ///
    /// - parameter newSize:   The new size of the image.
    ///
    /// - returns:             Resized `UIImage` of resized image.
    
    func filled(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Crop the image to be the required size.
    ///
    /// - parameter bounds:    The bounds to which the new image should be cropped.
    ///
    /// - returns:             Cropped `UIImage`.
    
    func cropped(to bounds: CGRect) -> UIImage? {
        var rect = bounds
        rect.size.width *= scale
        rect.size.height *= scale
        
        if let imageRef = cgImage?.cropping(to: rect) {
            return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        } else {
            return nil
        }
    }
    
    /// Resize the image to fill the rectange of the specified size, preserving the aspect ratio, trimming if needed.
    ///
    /// - parameter newSize:   The new size of the image.
    ///
    /// - returns:             Return `UIImage` of resized image.
    
    func scaledAspectFill(to newSize: CGSize) -> UIImage? {
        return scaled(to: newSize, contentMode: .scaleAspectFill);
    }
    
    /// Resize the image to fit within the required size, preserving the aspect ratio, with no trimming taking place.
    ///
    /// - parameter newSize:   The new size of the image.
    ///
    /// - returns:             Return `UIImage` of resized image.
    
    func scaledAspectFit(to newSize: CGSize) -> UIImage? {
        return scaled(to: newSize, contentMode: .scaleAspectFit)
    }
    
}
