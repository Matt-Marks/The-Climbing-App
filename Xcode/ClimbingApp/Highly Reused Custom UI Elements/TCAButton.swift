//
//  TCAButton.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/25/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



//  Description:
//  ------------
//  This is a basic button with rounded corners, cenered title, and optional
//  icons to the left or right of the title.
//
//  Options:
//  --------
//  - title: String?
//    The title text, center in the button.
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
//  - titleColor: UIColor
//    The color of the title text.
//
//  - imageColor: UIColor
//    The color of the image.


import UIKit

class TCAButton: UIControl {
    
    
    // MARK: Options

    /// The title text, center in the button.
    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    /// The side the image appears on.
    public var imageAlignment: HorizontalEdge {
        get {
            return stack.arrangedSubviews.first == imageView ? .left : .right
        }
        set {
            updateImageAlignment()
        }
    }
        
    /// The image next to the title.
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if !stack.arrangedSubviews.contains(imageView) {
                stack.addArrangedSubview(imageView)
            }
        }
    }
    
    /// The font of both the title and the icon.
    public var font: UIFont {
        get {
            return titleLabel.font
        }
        set {
            titleLabel.font = newValue
            updateImageFont()
        }
    }
 
    /// The margins around the edges of the content.
    override var layoutMargins: UIEdgeInsets {
        get {
            return stack.layoutMargins
        }
        set {
            stack.layoutMargins = newValue
        }
    }
    
    /// The spacing between the image and the title.
    public var spacing: CGFloat {
        get {
            return stack.spacing
        }
        set {
            stack.spacing = newValue
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
    
    /// The color of the image.
    public var imageColor: UIColor {
        get {
            return imageView.tintColor
        }
        set {
            imageView.tintColor = newValue
        }
    }
    
    
    
    // MARK: Button Properties

    // We want the button to be tactile. So we make it shrink it is touched and
    // grow when it is untouched.
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The optional icon to the right of the title.
    private let imageView = UIImageView()
    
    /// The centered button title.
    private let titleLabel = UILabel()
    
    /// A horizontal stack view to hold the icons and title.
    private let stack = UIStackView()
    
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        titleLabel.adjustsFontForContentSizeCategory = true
        
        stack.addArrangedSubview(titleLabel)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateImageFont()
        updateImageAlignment()
    }
    

    
    // MARK: Helpers & Utilities
    
    /// If the user has set a SFSymbol as their image then we automatially make the
    /// size and weight of that image match size and weight of the title.
    /// If th user has set an image that is not an SFSymbol then this method has
    /// no effect. (We add this auxiliary method instead of making this adjustment
    /// when the font is set because there is no guarantee that the image has been
    /// set at the time the font is set.)
    private func updateImageFont()  {
        if imageView.image?.configuration != UIImage.SymbolConfiguration(font: font) {
            imageView.image = imageView.image?.withConfiguration(UIImage.SymbolConfiguration(font: font))
        }
    }
    
    /// If the user has set an image, this function makes sure the image is on the
    /// correct side in respect to the 'imageAlignment' option. If the user has not
    /// set an image then this methodhas no effet. (We add this auxiliary method
    /// instead of making this adjustment when the imageAlignment is set because\
    /// there is no guarantee that the image has been set at the time the
    /// imageAlignment is set.)
    private func updateImageAlignment() {
        
        // If the button has an image...
        if stack.arrangedSubviews.contains(imageView) {
            
            // If the image is on the wrong side for the given alignment...
            if (stack.arrangedSubviews.first == imageView && imageAlignment == .right) ||
                (stack.arrangedSubviews.last == imageView && imageAlignment == .left){
                
                // Flip order of arranged subviews.
                stack.removeArrangedSubview(imageView)
                stack.removeArrangedSubview(titleLabel)
                
                if imageAlignment == .left {
                    stack.addArrangedSubview(imageView)
                    stack.addArrangedSubview(titleLabel)
                } else {
                    stack.addArrangedSubview(titleLabel)
                    stack.addArrangedSubview(imageView)
                }
                
            }
            
            
        }
    }
}
