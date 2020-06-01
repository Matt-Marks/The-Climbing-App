//
//  TCADescriptiveButton.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/17/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



//  Description:
//  ------------
//  This is a button with a left aligned image, a bold title, and a subtitle for
//  extra information.
//
//  Options:
//  --------
//  - image: UIImage?
//    The icon to the left of the button.
//
//  - title: String?
//    The bold title at the top of the button.
//
//  - subtitle: String?
//    The subtitle under the title of the button.
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

class TCADescriptiveButton: UIControl {

    
    // MARK: Content Options
    
    /// The icon to the left of the button.
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    /// The bold title at the top of the button.
    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    /// The subtitle under the title of the button.
    public var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
        }
    }
    
    /// The color of the title text.
    public var imageColor: UIColor {
        get {
            return imageView.tintColor
        }
        set {
            imageView.tintColor = newValue
        }
    }
    
    
    /// The color of the title text.
    public var titleColor: UIColor {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }
    
    /// The color of the subtitle text.
    public var subtitleColor: UIColor {
        get {
            return subtitleLabel.textColor
        }
        set {
            subtitleLabel.textColor = newValue
        }
    }
 

    // MARK: Button Properties
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The icon to the left of the cell.
    private let imageView = UIImageView()
    
    /// The bold title at te top of the cell
    private let titleLabel = UILabel()
    
    /// The subtitle under the title of the cell.
    private let subtitleLabel = UILabel()
 
    /// The vertical stack that holds the title and subtitle labels.
    private let labelStack = UIStackView()
    
    /// The horizontal stack that holds the icon and the label stack.
    private let stack = UIStackView()
    
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = .cellCornerRadius
        
        // Setup Icon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        stack.addArrangedSubview(imageView)
        
        // The title and subtitle are placed in their own vertical stack.
        labelStack.axis = .vertical
        labelStack.spacing = 3
        labelStack.insetsLayoutMarginsFromSafeArea = false
        labelStack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // Setup title.
        titleLabel.text = title
        titleLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        labelStack.addArrangedSubview(titleLabel)
        
        // Setup subtitle.
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.roundedFont(forTextStyle: .footnote)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.adjustsFontForContentSizeCategory = true
        labelStack.addArrangedSubview(subtitleLabel)
        stack.addArrangedSubview(labelStack)
        
        // Setup the main stack that holds the icons and the label stack.
        stack.axis = .horizontal
        stack.spacing = .cellEdgeSpacing
        stack.alignment = .center
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: .cellEdgeSpacing),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: .cellEdgeSpacing),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -.cellEdgeSpacing),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.cellEdgeSpacing),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
