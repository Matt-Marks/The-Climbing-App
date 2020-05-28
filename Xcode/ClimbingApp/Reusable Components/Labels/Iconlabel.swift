//
//  Iconlabel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAIconLabel: UIView {
    
    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    public var font: UIFont? {
        didSet {
            textLabel.font = font
        }
    }
    
    public var textColor: UIColor = .label {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    public var iconColor: UIColor = .label {
        didSet {
            iconImageView.tintColor = iconColor
        }
    }
    
    public var iconAlignment: HorizontalEdge = .left {
        didSet {
            switch iconAlignment {
            case .left:
                stack.semanticContentAttribute = .forceLeftToRight
            case .right:
                stack.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    
    public var adjustsFontForContentSizeCategory: Bool = false {
        didSet {
            textLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        }
    }
    
    private let textLabel = UILabel()
    private let iconImageView = UIImageView()
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 4
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
