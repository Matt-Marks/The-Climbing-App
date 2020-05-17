//
//  MMInactiveSectionCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/30/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class MMInactiveSectionCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: Public Memebers
    
    /// The large prominent text.
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// Some extra information under the title.
    public var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "MMInactiveSectionCell"
    
    
    // MARK: Constants & Variables
    struct Constants {
        static let stackSpacing: CGFloat = 5
        static let maxSubtitleWidth: CGFloat = 240
        static let defaultTitle: String = "Title"
        static let defaultSubtitle: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    /// The large prominent text.
    private let titleLabel = UILabel()
    
    /// Some extra information under the title.
    private let subtitleLabel = UILabel()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // The entire cell is spanned by one vertical stack.
        let stack = UIStackView()
        stack.layoutMargins = .init(top: 0, left: .margin, bottom: 0, right: .margin)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        // First stack item.
        titleLabel.text = Constants.defaultTitle
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .headline
        stack.addArrangedSubview(titleLabel)
        
        // Second Stack item.
        subtitleLabel.text = Constants.defaultSubtitle
        subtitleLabel.textColor = .tertiaryLabel
        subtitleLabel.font = .subheadline
        subtitleLabel.numberOfLines = .zero
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maxSubtitleWidth).isActive = true
        stack.addArrangedSubview(subtitleLabel)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
