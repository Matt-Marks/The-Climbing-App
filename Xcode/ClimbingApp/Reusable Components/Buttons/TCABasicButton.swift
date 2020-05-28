//
//  TCABasicButton.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/25/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a basic button with rounded corners, cenered title, and optional
// icons to the left or right of the title.



import UIKit

class TCABasicButton: UIControl {
    
    
    
    // MARK: Content Options

    /// The title text, center in the button.
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// The icon to the left of the title.
    public var leftIcon: UIImage? {
        didSet {
            leftIconImageView.image = leftIcon
            stack.insertArrangedSubview(leftIconImageView, at: 0)
        }
    }
    
    /// The icon to the right of the title.
    public var rightIcon: UIImage? {
        didSet {
            rightIconImageView.image = rightIcon
            stack.addArrangedSubview(rightIconImageView)
        }
    }
    
    
    
    // MARK: Coloring Options
    
    /// The background color of the button when it is marked as selected.
    public var selectedBackgroundColor: UIColor = .accent {
        didSet {
            if isSelected {
                backgroundColor = selectedBackgroundColor
            }
        }
    }
    
    /// The background color of the button when it is not marked as selected.
    public var unselectedBackgoundColor: UIColor = .cellBackgound {
        didSet {
            if !isSelected {
                backgroundColor = unselectedBackgoundColor
            }
        }
    }
    
    /// The color of the left or right icons when the button is marked as selected.
    public var selectedIconTintColor: UIColor = .white {
        didSet {
            if isSelected {
                leftIconImageView.tintColor = selectedIconTintColor
                rightIconImageView.tintColor = selectedIconTintColor
            }
        }
    }
    
    /// The color of the left or right icons when the button is not marked as selected.
    public var unselectedIconTintColor: UIColor = .accent {
        didSet {
            if !isSelected {
                leftIconImageView.tintColor = unselectedIconTintColor
                rightIconImageView.tintColor = unselectedIconTintColor
            }
        }
    }
    
    /// The color of the title text when the button is marked as selected.
    public var selectedTitleTextColor: UIColor = .white {
        didSet {
            if isSelected {
                titleLabel.textColor = selectedTitleTextColor
            }
        }
    }
    
    /// The color of the title text when the button is not marked as selected.
    public var unselectedTitleTextColor: UIColor = .label {
        didSet {
            if !isSelected {
                titleLabel.textColor = unselectedTitleTextColor
            }
        }
    }
    
    
    
    // MARK: Button Properties

    override var isSelected: Bool {
        didSet {
            backgroundColor              = isSelected ? selectedBackgroundColor : unselectedBackgoundColor
            leftIconImageView.tintColor  = isSelected ? selectedIconTintColor : unselectedIconTintColor
            rightIconImageView.tintColor = isSelected ? selectedIconTintColor : unselectedIconTintColor
            titleLabel.textColor         = isSelected ? selectedTitleTextColor : unselectedTitleTextColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The optional icon to the right of the title.
    private let leftIconImageView = UIImageView()
        
    /// The optional icon to the right of the title.
    private let rightIconImageView = UIImageView()
    
    /// The centered button title.
    private let titleLabel = UILabel()
    
    /// A horizontal stack view to hold the icons and title.
    private let stack = UIStackView()
    
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        // Setup the tite.
        titleLabel.text = title
        titleLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        stack.addArrangedSubview(titleLabel)
        
        
        // Spacing above and below the title.
        stack.layoutMargins = .init(top: 6, left: 10, bottom: 6, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        
        // Make the stack ignore the edgs the phone if it is cut off by one.
        stack.insetsLayoutMarginsFromSafeArea = false
        
        // Prevent stack from bocking touch events.
        stack.isUserInteractionEnabled = false
        
        // Basic Setup.
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Shortcut to apply default styles.
        defer {
            isSelected = false
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
