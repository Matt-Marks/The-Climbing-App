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


import UIKit


// ********************************************************************** //
// MARK: - SectionHeaderReusableViewDelegate
// ********************************************************************** //
protocol SectionHeaderReusableViewDelegate {
    func auxiliaryButtonPressed(in sectionHeader: TCASectionHeader)
}

// ********************************************************************** //
// MARK: - TCASectionHeader
// ********************************************************************** //
class TCASectionHeader: UICollectionReusableView, ReuseIdentifiable {
        
    
    // MARK: Delegation
    public var delegate: SectionHeaderReusableViewDelegate?
    
    
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
            buttonLabel.text = buttonTitle
        }
    }
    
    /// The icon for the auxiliary button.
    public var buttonIcon: UIImage? {
        didSet {
            buttonLabel.icon = buttonIcon
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
    
    /// The right hand size button. We use a label with a tap gesture recognizer
    /// instead of a button becauset the
    private let buttonLabel = TCAIconLabel()
    
    
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
        separator.heightAnchor.constraint(equalToConstant: .separatorHeight).isActive = true
        stack.addArrangedSubview(separator)
        separator.isHidden = true
        
        
        // The title label is placed under the separator.
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.roundedFont(forTextStyle: .title2).bold()
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
        // We add a tap geature to the label to mimic a UIButton.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGeatureRecognized))
        buttonLabel.isUserInteractionEnabled = true
        buttonLabel.textColor = .accent
        buttonLabel.addGestureRecognizer(tapGesture)
        buttonLabel.adjustsFontForContentSizeCategory = true
        buttonLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // The title and the right side button are placed in a horiznotal stack
        // which is then placed inside of the main stack. An extra UIView is placed
        // between the titleLabel and the buttonLabel to allow the title and the
        // button to be aligned to the left and right respectivly.
        let titleButtonStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), buttonLabel])
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
    private func tapGeatureRecognized(_ sender: UITapGestureRecognizer) {
        print("aiposuhdfuipoashdiusahdi")
        delegate?.auxiliaryButtonPressed(in: self)
    }
    
}
