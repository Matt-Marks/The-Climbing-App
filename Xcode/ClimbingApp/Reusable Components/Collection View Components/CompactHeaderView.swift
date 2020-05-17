//
//  CompactHeaderView.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/25/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class CompactHeaderView: UIView {

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
    
    private var pretitleLabel = UILabel()
    private var titleLabel = UILabel()
    
    private var separator = UIView()
    private var stack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
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
        
        pretitleLabel.textAlignment = .center
        pretitleLabel.text = pretitle
        pretitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        pretitleLabel.textColor = .secondaryLabel
        
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = UIFont.roundedFont(forTextStyle: .headline).bold()

        
        stack.addArrangedSubview(pretitleLabel)
        stack.addArrangedSubview(titleLabel)
        
        
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: .screenEdgeSpacing),
            separator.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -.screenEdgeSpacing),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: .separatorHeight)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
