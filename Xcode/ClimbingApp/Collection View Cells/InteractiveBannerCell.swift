//
//  InteractiveBannerCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//


//  Description:
//  ------------
//  A UICollectionViewCell used to display a notification or information type
//  banner. For example, this is used as the 'Start a Session' banner among other
//  things.


import UIKit

class MMBannerCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Public Members
    
    /// The small caps text on the very top.
    public var smallTitle: String? {
        didSet {
            smallLabel.text = smallTitle?.uppercased()
        }
    }
    
    /// The large prominent text.
    public var largeTitle: String? {
        didSet {
            largeLabel.text = largeTitle
        }
    }
    
    /// Some extra information between the title and the button.
    public var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    /// The button at the bottom.
    public var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle ?? "Button")
        }
    }
    
    /// Redirects to the buttons 'addTarget' function.
    public func addTarget(_ target: Any?, action: Selector, for event: UIControl.Event) {
        button.addTarget(target, action: action, for: event)
    }
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "MMBannerCollectionViewCell"
    
    
    // MARK: Constants & Variables
    
    struct Constants {
        static let stackSpacing: CGFloat = 5
        static let maxSubtitleWidth: CGFloat = 240
        static let buttonSize: CGSize = .init(width: 140, height: 35)
        static let defaultSmallTitle: String = "SMALL TITLE"
        static let defaultLargeTitle: String = "Large Title"
        static let defaultSubtitle: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        static let defaultButtonTitle: String = "Button"
    }
    
    /// The small caps text on the very top.
    private let smallLabel = UILabel()
    
    /// The large prominent text.
    private let largeLabel = UILabel()
    
    /// Some extra information between the title and the button.
    private let subtitleLabel = UILabel()
    
    /// The button at the bottom.
    private let button = MMButton()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup the cell.
        contentView.backgroundColor = .fill
        
        // The entire cell is spanned by one vertical stack.
        let stack = UIStackView()
        stack.layoutMargins = .init(top: .margin, left: .margin, bottom: .margin, right: .margin)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // First stack item.
        smallLabel.text = Constants.defaultSmallTitle
        smallLabel.textColor = .secondaryAccent
        smallLabel.font = .smallCaps
        stack.addArrangedSubview(smallLabel)
        stack.setCustomSpacing(Constants.stackSpacing, after: smallLabel)
        
        // Second stack item.
        largeLabel.text = Constants.defaultLargeTitle
        largeLabel.textColor = .label
        largeLabel.font = .headline
        stack.addArrangedSubview(largeLabel)
        stack.setCustomSpacing(Constants.stackSpacing, after: largeLabel)
        
        // Third Stack item.
        subtitleLabel.text = Constants.defaultSubtitle
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = .subheadline
        subtitleLabel.numberOfLines = .zero
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maxSubtitleWidth).isActive = true
        stack.addArrangedSubview(subtitleLabel)
        stack.setCustomSpacing(Constants.stackSpacing + 7, after: subtitleLabel)
        
        // Final Stack Item.
        button.isSelected = true
        button.setTitle(Constants.defaultButtonTitle)
        button.layer.cornerRadius = 9
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: Constants.buttonSize.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonSize.height).isActive = true
        stack.addArrangedSubview(button)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.applyCornerRadius()
    }
    
}
