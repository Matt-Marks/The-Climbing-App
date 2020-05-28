//
//  Iconlabel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a wrapper around a UILabel to allow us to place an icon to its left
// or right.



import UIKit

class TCAIconLabel: UIView {
    
    
    
    // MARK: Constants
    struct Constants {
        
        /// The spacing between the text and the icon.
        static let spacing: CGFloat = 4
    }
    
    
    
    // MARK: Appearance Options
    
    /// The text contaned in the label.
    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    /// The icon that will appear to the left or right of the label.
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    /// The font of the label.
    public var font: UIFont? {
        didSet {
            textLabel.font = font
        }
    }
    
    /// The color of the text within the label.
    public var textColor: UIColor = .label {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    /// The color of the icon within the label.
    public var iconColor: UIColor = .label {
        didSet {
            iconImageView.tintColor = iconColor
        }
    }
    
    /// The layout margins remapped to the layout margins of the stack.
    public override var layoutMargins: UIEdgeInsets {
        get {
            return stack.layoutMargins
        }
        set {
            stack.layoutMargins = newValue
        }
    }
    
    /// The alignment of the icon within the label.
    /// The icon will appear to the left or right of the label.
    public var iconAlignment: HorizontalEdge = .left {
        didSet {
            switch iconAlignment {
            case .left:
                stack.semanticContentAttribute = .forceRightToLeft
            case .right:
                stack.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    
    /// A boolean representing if the font will changhe for accessability settings.
    public var adjustsFontForContentSizeCategory: Bool = false {
        didSet {
            textLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The label that holds the text.
    private let textLabel = UILabel()
    
    /// The image view that holds the icon.
    private let iconImageView = UIImageView()
    
    /// The horizontal stack view that contains the text and the icon.
    private let stack = UIStackView()
    
    
    
    // MARK: Initilization
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Constants.spacing
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        stack.addArrangedSubview(textLabel)
        stack.addArrangedSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
