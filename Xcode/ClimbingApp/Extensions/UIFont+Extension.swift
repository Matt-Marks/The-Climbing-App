//
//  UIFont+Extension.swift
//  ClimbingApp
//
//  Created by Matt Marks on 1/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    
    
    class func preferredFont(forTextStyle style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
    
    
    
    /// A shortcut for the rounded system font.
    ///
    /// - Parameters:
    ///     - textStyle: The text style of the font.
    ///
    /// - Returns:
    ///     - Rounded system font for the given text style.
    class func roundedFont(forTextStyle textStyle: TextStyle) -> UIFont {
        if let descriptor = UIFont.preferredFont(forTextStyle: textStyle).fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
    
    /// A shortcut for the rounded system font.
    ///
    /// - Parameters:
    ///     - size: The intended font point size.
    ///     - weight: The intended font weight.
    ///
    /// - Returns:
    ///     - Rounded system font for the given font size and weight.
    class func roundedFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        if let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
    /// Makes the current font bold if possible.
    func bold() -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(.traitBold)
        return UIFont.init(descriptor: descriptor!, size: 0)
    }
    
}
