//
//  TCAConstants.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

// ********************************************************************** //
// MARK: - UIColors
// ********************************************************************** //
extension UIColor {
    
    /// The accent color used throughout the application.
    static let accent: UIColor = .systemBlue
    
    /// A secondary accent color used throughout the application.
    static let secondaryAccent: UIColor = .systemTeal
    
    /// The background color many UICollectionViewCell's throughout the application.
    static let cellBackgound: UIColor = .quaternarySystemFill
    
}

// ********************************************************************** //
// MARK: - CGFloats
// ********************************************************************** //
extension CGFloat {

    // The corner radius of all collection view cells.
    static let cellCornerRadius: CGFloat = 13
    
    // The specing content and edge of every collection view cell.
    static let cellEdgeSpacing: CGFloat = 13.0
    
    // The spacing between the content of the app and the edge of the screen.
    static let screenEdgeSpacing: CGFloat = 20.0
    
    // The spacing between collection view sections.
    static let interSectionSpacing: CGFloat = 30.0
    
    // The spacing between collection view items.
    static let interItemSpacing: CGFloat = 15.0
    
    // The specing between collection view groups.
    static let interGroupSpacing: CGFloat = 15.0
    
    // The spacing between the bottom of a collection view section header and the
    // section itself.
    static let underSectionHeaderSpacing: CGFloat = 10.0
    
    // The height of all seperator bars used in the app.
    static let separatorHeight: CGFloat = 0.5
    
    // The spacing above and below the text in the large and compact heade views.
    static let navigationBarSpacing: CGFloat = 18.0
    
}

