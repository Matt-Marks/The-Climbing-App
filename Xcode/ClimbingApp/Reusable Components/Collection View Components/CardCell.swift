//
//  CardCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/1/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    
    static let reuseIdentifier: String = "CardCell"
    
    
    // MARK: Constants & Variables
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    public var pretitle: String = "Pre-Title"{
        didSet {
            pretitleLabel.text = pretitle.uppercased()
        }
    }
    
    public var title: String = "Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var selectedBackgroundColor: UIColor = .accent {
        didSet {
            if isSelected {
                contentView.backgroundColor = selectedBackgroundColor
            }
        }
    }
    
    public var unselectedBackgoundColor: UIColor = .cellBackgound {
        didSet {
            if !isSelected {
                contentView.backgroundColor = unselectedBackgoundColor
            }
        }
    }
    
    public var selectedIconTintColor: UIColor = .white {
        didSet {
            if isSelected {
                iconImageView.tintColor = selectedIconTintColor
            }
        }
    }
    
    public var unselectedIconTintColor: UIColor = .accent {
        didSet {
            if !isSelected {
                iconImageView.tintColor = unselectedIconTintColor
            }
        }
    }
    
    public var selectedPretitleTextColor: UIColor = .white {
        didSet {
            if isSelected {
                pretitleLabel.textColor = selectedPretitleTextColor
            }
        }
    }
    
    public var unselectedPretitleTextColor: UIColor = .secondaryLabel {
        didSet {
            if !isSelected {
                pretitleLabel.textColor = unselectedPretitleTextColor
            }
        }
    }
    
    public var selectedTitleTextColor: UIColor = .white {
        didSet {
            if isSelected {
                titleLabel.textColor = selectedTitleTextColor
            }
        }
    }
    
    public var unselectedTitleTextColor: UIColor = .label {
        didSet {
            if !isSelected {
                titleLabel.textColor = unselectedTitleTextColor
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor  = isSelected ? selectedBackgroundColor : unselectedBackgoundColor
            iconImageView.tintColor      = isSelected ? selectedIconTintColor : unselectedIconTintColor
            pretitleLabel.textColor      = isSelected ? selectedPretitleTextColor : unselectedPretitleTextColor
            titleLabel.textColor         = isSelected ? selectedTitleTextColor : unselectedTitleTextColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    private var iconImageView = UIImageView()
    private var pretitleLabel = UILabel()
    private var titleLabel = UILabel()
    

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.layer.cornerRadius = .cellCornerRadius
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(iconImageView)
        stack.setCustomSpacing(.cellEdgeSpacing, after: iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        pretitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        titleLabel.font = UIFont.roundedFont(forTextStyle: .title3).bold()
        pretitleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.adjustsFontForContentSizeCategory = true
        
        stack.addArrangedSubview(iconImageView)
        stack.addArrangedSubview(pretitleLabel)
        stack.addArrangedSubview(titleLabel)
        
        isSelected = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
