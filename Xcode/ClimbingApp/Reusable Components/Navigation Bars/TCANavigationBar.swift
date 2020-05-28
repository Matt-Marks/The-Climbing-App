//
//  TCANavigationBar.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/25/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCANavigationBar: UIView {
    
    enum TCANavigationBarSizeClass {
        case large
        case compact
    }

    // MARK: Options
    public var pretitle: String = "PRETITLE" {
        didSet {
            pretitleLabel.text = pretitle.uppercased()
        }
    }
    
    public var title: String = "Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var sizeClass: TCANavigationBarSizeClass = .large {
        didSet {
            pretitleLabel.textAlignment = sizeClass == .large ? .left : .center
            titleLabel.textAlignment = sizeClass == .large ? .left : .center
            titleLabel.font = UIFont.roundedFont(forTextStyle: sizeClass == .large ? .largeTitle : .headline).bold()
        }
    }
    
    // MARK: UIElement Declarations
    
    /// The small label above the title.
    private var pretitleLabel = UILabel()
    
    /// The large title label.
    private var titleLabel = UILabel()
    
    /// The separator bar at the bottom.
    private var separator = UIView()
    
    /// The stack that holds the pretile and the title.
    private var stack = UIStackView()
    
    // MARK: Initialization
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        // Setup the stack
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.insetsLayoutMarginsFromSafeArea = true
        stack.layoutMargins = .init(top: .navigationBarSpacing, left: .screenEdgeSpacing, bottom: .navigationBarSpacing, right: .screenEdgeSpacing)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // Setup the pretitle label
        pretitleLabel.text = pretitle
        pretitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        pretitleLabel.textColor = .secondaryLabel
        stack.addArrangedSubview(pretitleLabel)
        
        // Setup the large title label
        titleLabel.text = title
        titleLabel.font = UIFont.roundedFont(forTextStyle: .largeTitle).bold()
        stack.addArrangedSubview(titleLabel)
        
        // Add the separator to the bottom.
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: .screenEdgeSpacing),
            separator.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -.screenEdgeSpacing),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: .separatorHeight)
        
        ])
        
        defer {
            sizeClass = .large
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
