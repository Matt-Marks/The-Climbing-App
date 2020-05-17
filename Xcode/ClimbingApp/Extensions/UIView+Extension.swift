//
//  UIView+Extension.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/30/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: Animations
    
    /// Shrinks the UIView by a little bit over 0.1 seconds.
    /// Used mainly for cell selection animations.
    func animateShrink() {
        
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: {
                let scale = (self.bounds.width - 7.0)/self.bounds.width
                self.transform = .init(scaleX: scale, y: scale)
        })
    }
    
    /// Expands the UIView by a little bit over 0.1 seconds.
    /// Used mainly for cell selection animations.
    func animateGrow() {
        
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: {
                self.transform = .identity
        })
    }
    
}
