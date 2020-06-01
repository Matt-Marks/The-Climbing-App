//
//  TCABannerCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/20/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCABannerCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    // MARK: Constants
    enum TCABannerCellDisplayStyle {
        case colorful
        case grayscale
    }
    
    struct Constants {
        static let pretileColor: UIColor = .accent
        static let titleColor: UIColor = .label
        static let messageColor: UIColor = .label
        static let buttonBackgroundColor: UIColor = .accent
        static let buttonTitleColor: UIColor = .white
                
        static let stackSpacing: CGFloat = 10
        static let buttonCornerRadius: CGFloat = 8
        static let horizontalEdgeMargin: CGFloat = 40
    }
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "TCABannerCell"
    
    
    // MARK: Options
    
    /// The coloring of the cell. If colorful the cell will display in full color,
    /// if grayscale, all the elements in the cell will be gray.
    public var displayStyle: TCABannerCellDisplayStyle = .colorful {
        didSet {
            pretitleLabel.textColor = displayStyle == .colorful ? Constants.pretileColor : .secondaryLabel
            titleLabel.textColor    = displayStyle == .colorful ? Constants.titleColor : .secondaryLabel
            messageLabel.textColor  = displayStyle == .colorful ? Constants.messageColor : .secondaryLabel
            //button.unselectedBackgoundColor = displayStyle == .colorful ? Constants.buttonBackgroundColor : .systemGray5
            //button.unselectedTitleTextColor = displayStyle == .colorful ? Constants.buttonTitleColor : .secondaryLabel
        }
    }
    
    /// The pretitle text.
    public var pretitle: String? {
        didSet {
            pretitleLabel.text = pretitle?.uppercased()
        }
    }
    
    /// The title text.
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// The message text.
    public var message: String? {
        didSet {
            messageLabel.text = message
        }
    }

    /// The button title. If nil, the button will be hidden.
    public var buttonTitle: String? {
        didSet {
            button.title = buttonTitle
            button.isHidden = buttonTitle == nil

        }
    }
    
    // MARK: UI Element Declarations
    
    /// The small label at the top.
    private var pretitleLabel = UILabel()
    
    /// The large title.
    private var titleLabel = UILabel()
    
    /// The message in the center.
    private var messageLabel = UILabel()
    
    /// The button below the message.
    private var button = TCAButton()

    /// The vetical stack that holds all the UIElements.
    private var stack = UIStackView()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup the cell.
        clipsToBounds = true
        layer.cornerRadius = .cellCornerRadius
        
        // Setup the UI Elements

        pretitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        pretitleLabel.textAlignment = .center
        
        titleLabel.font = UIFont.roundedFont(forTextStyle: .headline).bold()
        titleLabel.textAlignment = .center
        
        messageLabel.font = UIFont.roundedFont(forTextStyle: .body)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        button.layer.cornerRadius = Constants.buttonCornerRadius
    
        // Setup the stack.
        stack.layoutMargins = .init(
            top: .cellEdgeSpacing,
            left: Constants.horizontalEdgeMargin,
            bottom: .cellEdgeSpacing,
            right: Constants.horizontalEdgeMargin
        )
        stack.isLayoutMarginsRelativeArrangement = true
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.addArrangedSubview(pretitleLabel)
        stack.setCustomSpacing(0, after: pretitleLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(messageLabel)
        stack.addArrangedSubview(button)
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        
        defer {
            buttonTitle  = nil
            displayStyle = .colorful
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
