//
//  SectionHeaderReusableView.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/19/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//


//  Description:
//  ------------
//  Used as section headers in UICollectionViews throughout the application.
//
//  Options:
//  --------
//  - title: String?
//    The title of the section.
//
//  - subtitle: String?
//    Extra information under the title.
//
//  - showsSeparator: Bool
//    If true, a separator bar will be drawn at the top of the section header.
//
//  - buttonTitle: String?
//    Sets the title of the button to the right of the section header.
//
//  - buttonImage: UIImage?
//    The icon for the auxiliary button.
//
//  - buttonImageAlignment: HorizontalEdge
//    Sets which side of the button the icon is on.


import UIKit


// ********************************************************************** //
// MARK: - SectionHeaderReusableViewDelegate
// ********************************************************************** //
protocol TCASectionHeaderDelegate {
    func auxiliaryButtonPressed(in sectionHeader: TCASectionHeader)
}

// ********************************************************************** //
// MARK: - TCASectionHeader
// ********************************************************************** //
class TCASectionHeader: UICollectionReusableView, ReuseIdentifiable {
        
    
    // MARK: Delegation
    public var delegate: TCASectionHeaderDelegate?
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "SectionHeaderReusableView"
    

    // MARK: Constants & Variables
    
    /// The title of the section.
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// Extra information under the title.
    public var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    /// If true, a separator bar will be drawn at the top of the section header.
    public var showsSeparator: Bool = false {
        didSet {
            stack.setCustomSpacing(showsSeparator ? 10 : 0, after: separator)
            separator.isHidden = !showsSeparator
        }
    }
    
    /// Sets the title of the button to the right of the section header.
    public var buttonTitle: String? {
        didSet {
            button.title = buttonTitle
        }
    }
    
    /// The icon for the auxiliary button.
    public var buttonImage: UIImage? {
        didSet {
            button.image = buttonImage
        }
    }
    
    /// Sets which side of the button the icon is on.
    public var buttonImageAlignment: HorizontalEdge = .left {
        didSet {
            button.imageAlignment = buttonImageAlignment
        }
    }
    
    /// The main stack that contains everything.
    private let stack = UIStackView()
    
    /// The bold title.
    private let titleLabel = UILabel()
    
    /// The small text under the title.
    private let subtitleLabel = UILabel()
    
    /// The separator at the top.
    private let separator = UIView()
    
    /// The right hand size button.
    private let button = TCAButton()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // The stack fills the whole header.
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Top item of the stack is the separator.
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: .dividerHeight).isActive = true
        stack.addArrangedSubview(separator)
        separator.isHidden = true
        
        
        // The title label is placed under the separator.
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.roundedFont(forTextStyle: .title2).bold()
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
        // The button to the right.
        button.isUserInteractionEnabled = true
        button.titleColor = .accent
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // The title and the right side button are placed in a horiznotal stack
        // which is then placed inside of the main stack. An extra UIView is placed
        // between the titleLabel and the button to allow the title and the
        // button to be aligned to the left and right respectivly.
        let titleButtonStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), button])
        titleButtonStack.axis = .horizontal
        titleButtonStack.distribution = .equalSpacing
        stack.addArrangedSubview(titleButtonStack)
        
        // Finally, the subtitle goes under everything.
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.font = .roundedFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        stack.addArrangedSubview(subtitleLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc
    private func buttonPressed(_ sender: TCAButton) {
        delegate?.auxiliaryButtonPressed(in: self)
    }
    
}
