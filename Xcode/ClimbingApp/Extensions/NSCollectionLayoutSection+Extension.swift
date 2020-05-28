//
//  NSCollectionLayoutSection+Extension.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/19/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    
    
    /// Creates and returns a preconfigured vertical section.
    ///
    /// - Parameters:
    ///     - columns: The number of columns in the secion. Defaults to 1.
    ///     - header: If true a header will be added to the section. Defaults to true.
    ///     - itemheight: The height of each item within the section.
    ///     - sectionWidth: The with of the section. Defaults to the collection's width.
    ///     - topInset: The top content inset for the section. Defalts to .underSectionHeaderSpacing.
    ///     - bottomIndet: The bottom content inset for the section. Defaults to zero.
    ///
    /// - Returns:
    ///     - A preconfigured NSCollectionLayoutSection for the given parameters.
    class func vertical(
        columns: Int = 1,
        header: Bool = true,
        itemHeight: NSCollectionLayoutDimension,
        sectionWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0),
        topInset: CGFloat = .underSectionHeaderSpacing,
        bottomInset: CGFloat = 0
    ) -> NSCollectionLayoutSection {
        
        // Setup section.
        let size = NSCollectionLayoutSize(
            widthDimension: sectionWidth,
            heightDimension: itemHeight
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: size,
            subitem: item,
            count: columns
        )
                
        group.interItemSpacing = .fixed(.interGroupSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = .interGroupSpacing
        
        section.contentInsets = .init(
            top: topInset,
            leading: .screenEdgeSpacing,
            bottom: bottomInset,
            trailing: .screenEdgeSpacing
        )
        
        // Add header if needed.
        if header {
            section.addHeaderItem()
        }
        
        return section
    }
    
    
    /// Creates and returns a preconfigured scrollable horizontal section.
    ///
    /// - Parameters:
    ///     - rows: The number of rows in the secion. Defaults to 1.
    ///     - header: If true a header will be added to the section. Defaults to true.
    ///     - itemWidth: The width of each item within the section.
    ///     - sectionHeight: The height of the section.
    ///     - topInset: The top content inset for the section. Defalts to .underSectionHeaderSpacing.
    ///     - bottomIndet: The bottom content inset for the section. Defaults to zero.
    ///
    /// - Returns:
    ///     - A preconfigured NSCollectionLayoutSection for the given parameters.
    class func horizontal(
        rows: Int = 1,
        header: Bool = true,
        itemWidth: NSCollectionLayoutDimension,
        sectionHeight: NSCollectionLayoutDimension,
        topInset: CGFloat = .underSectionHeaderSpacing,
        bottomInset: CGFloat = 0
    )  -> NSCollectionLayoutSection {
        
        // Setup section.
        let size = NSCollectionLayoutSize(
            widthDimension: itemWidth,
            heightDimension: sectionHeight
        
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size,
            subitem: item,
            count: rows
        )
        
        group.interItemSpacing = .fixed(.interGroupSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
             
        section.interGroupSpacing = .interGroupSpacing
        
        section.contentInsets = .init(
            top: topInset,
            leading: .screenEdgeSpacing,
            bottom: bottomInset,
            trailing: .screenEdgeSpacing
        )
        
        
        
        // Add header if needed.
        if header {
            section.addHeaderItem()
        }
        
        return section
    }
    
    
    /// Adds a bountry supplementary item large enough to fit a
    /// 'TCASectionHeader' to the section.
    func addHeaderItem() {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(80)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        self.boundarySupplementaryItems.insert(headerItem, at: 0)
    }

    
}
