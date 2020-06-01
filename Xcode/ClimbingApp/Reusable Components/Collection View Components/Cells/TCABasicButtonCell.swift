//
//  BasicButtonCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/1/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a wrapper around the BasicButton which allows us to use it
// as a cell in a UICollectionView.
//
//  Options:
//  --------
//  - title: String?
//    The title text, center in the cell.
//
//  - imageAlignment: HorizontalEdge
//    The side the image appears on.
//
//  - image: UIImage?
//    The image next to the title.
//
//  - font: UIFont
//    The font of both the title and the icon.
//
//  - layoutMargins: UIEdgeInsets
//    The margins around the edges of the content.
//
//  - spacing: CGFloat
//    The spacing between the image and the title.
//
//  - textColor: UIColor
//    The color of the title text.
//
//  - imageColor: UIColor
//    The color of the image.



import UIKit

class TCAButtonCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "BasicButtonCell"
    
    /// The title text, center in the button.
    public var title: String? {
        get {
            return button.title
        }
        set {
            button.title = newValue
        }
    }
    
    /// The side the image appears on.
    public var imageAlignment: HorizontalEdge {
        get {
            return button.imageAlignment
        }
        set {
            button.imageAlignment = newValue
        }
    }
    
    /// The image next to the title.
    public var image: UIImage? {
        get {
            return button.image
        }
        set {
            button.image = newValue
        }
    }
    
    /// The font of both the title and the icon.
    public var font: UIFont {
        get {
            return button.font
        }
        set {
            button.font = newValue
        }
    }
    
    /// The margins around the edges of the content.
    override var layoutMargins: UIEdgeInsets {
        get {
            return button.layoutMargins
        }
        set {
            button.layoutMargins = newValue
        }
    }
    
    /// The spacing between the image and the title.
    public var spacing: CGFloat {
        get {
            return button.spacing
        }
        set {
            button.spacing = newValue
        }
    }
    
    /// The color of the title text.
    public var textColor: UIColor {
        get {
            return button.textColor
        }
        set {
            button.textColor = newValue
        }
    }
    
    /// The color of the image.
    public var imageColor: UIColor {
        get {
            return button.imageColor
        }
        set {
            button.imageColor = newValue
        }
    }
    
    
    // MARK: Cell Properties
    override var isHighlighted: Bool {
        didSet {
            button.isHighlighted = isHighlighted
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The entire cell consists of this one button.
    public let button = TCAButton()
    
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = .cellCornerRadius
        clipsToBounds = true
        
        contentView.addSubview(button)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
