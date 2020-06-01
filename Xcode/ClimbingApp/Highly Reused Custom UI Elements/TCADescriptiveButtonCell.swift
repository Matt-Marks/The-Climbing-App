//
//  TCADescriptiveButtonCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/1/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a wrapper around the DescriptiveButton which allows us to use it
// as a cell in a UICollectionView.
//
//  Options:
//  --------
//  - image: UIImage?
//    The icon to the left of the cell.
//
//  - title: String?
//    The bold title at the top of the cell.
//
//  - subtitle: String?
//    The subtitle under the title of the cell.
//
//  - imageColor: UIColor
//    The color of the title text.
//
//  - titleColor: UIColor
//    The color of the title text.
//
//  - subtitleColor: UIColor
//    The color of the subtitle text.


import UIKit

class TCADescriptiveButtonCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "DescriptiveButtonCell"
    
        /// The icon to the left of the button.
    public var image: UIImage? {
        get {
            return descriptiveButton.image
        }
        set {
            descriptiveButton.image = newValue
        }
    }
    
    /// The bold title at the top of the button.
    public var title: String? {
        get {
            return descriptiveButton.title
        }
        set {
            descriptiveButton.title = newValue
        }
    }
    
    /// The subtitle under the title of the button.
    public var subtitle: String? {
        get {
            return descriptiveButton.subtitle
        }
        set {
            descriptiveButton.subtitle = newValue
        }
    }
    
    /// The color of the title text.
    public var imageColor: UIColor {
        get {
            return descriptiveButton.imageColor
        }
        set {
            descriptiveButton.imageColor = newValue
        }
    }
    
    
    /// The color of the title text.
    public var titleColor: UIColor {
        get {
            return descriptiveButton.titleColor
        }
        set {
            descriptiveButton.titleColor = newValue
        }
    }
    
    /// The color of the subtitle text.
    public var subtitleColor: UIColor {
        get {
            return descriptiveButton.subtitleColor
        }
        set {
            descriptiveButton.subtitleColor = newValue
        }
    }

    
    // MARK: Cell Properties
    override var isHighlighted: Bool {
        didSet {
            descriptiveButton.isHighlighted = isHighlighted
        }
    }
    
    
    // MARK: UI Element Declarations
    
    /// The entire cell consists of this one button.
    public let descriptiveButton = TCADescriptiveButton()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = .cellCornerRadius
        clipsToBounds = true
        
        contentView.addSubview(descriptiveButton)
        descriptiveButton.isUserInteractionEnabled = false
        descriptiveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptiveButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptiveButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptiveButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptiveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
