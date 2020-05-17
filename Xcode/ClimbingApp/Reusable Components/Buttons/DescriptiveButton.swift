//
//  DescriptiveButton.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/17/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a button with a left aligned icon, a bold title, and a subtitle for
// extra information.



import UIKit

class DescriptiveButton: UIControl {

    
    // MARK: Content Options
    
    /// Th icon to the left of the button.
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    /// The bold title at the top of the button.
    public var title: String = "Cell Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// The subtitle under the title of the button.
    public var subtitle: String = "Lorem ipsum dolor sit amet, dolores aliquam ut a tortor." {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    

    // MARK: Coloing Options
    
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
                iconImageView.tintColor = selectedIconTintColor
            }
        }
    }
    
    /// The color of the icon when the button is not marked as selected.
    public var unselectedIconTintColor: UIColor = .accent {
        didSet {
            if !isSelected {
                iconImageView.tintColor = unselectedIconTintColor
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
    
    /// The color of the subtitle text when the button is marked as selected.
    public var selectedSubtitleTextColor: UIColor = .white {
        didSet {
            if isSelected {
                subtitleLabel.textColor = selectedSubtitleTextColor
            }
        }
    }
    
    /// The color of the subtitle text when the button is not marked as selected.
    public var unselectedSubtitleTextColor: UIColor = .secondaryLabel {
        didSet {
            if !isSelected {
                subtitleLabel.textColor = unselectedSubtitleTextColor
            }
        }
    }
    
    
    
    // MARK: Button Properties
    
    override var isSelected: Bool {
        didSet {
            backgroundColor             = isSelected ? selectedBackgroundColor : unselectedBackgoundColor
            iconImageView.tintColor     = isSelected ? selectedIconTintColor : unselectedIconTintColor
            titleLabel.textColor        = isSelected ? selectedTitleTextColor : unselectedTitleTextColor
            subtitleLabel.textColor     = isSelected ? selectedSubtitleTextColor : unselectedSubtitleTextColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The icon to the left of the cell.
    private let iconImageView = UIImageView()
    
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
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])
        stack.addArrangedSubview(iconImageView)
        
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
        
        // Shortcut to apply default styles.
        isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
