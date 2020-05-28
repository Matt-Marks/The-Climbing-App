
//
//  TCAChartCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/19/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAChartCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "ChartCell"
    
    // MARK: Constants & Variables
    public var title: String = "Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subtitle: String = "Title" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var gradientBackground = CAGradientLayer()
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = .cellCornerRadius
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.font = UIFont.roundedFont(forTextStyle: .footnote)
        subtitleLabel.textColor = .white
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .cellEdgeSpacing),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .cellEdgeSpacing),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .cellEdgeSpacing),
        ])
        
        backgroundView = UIView()
        gradientBackground.colors = [UIColor.accent.cgColor, UIColor.secondaryAccent.cgColor]
        gradientBackground.startPoint = .init(x: 0.0, y: 0.0)
        gradientBackground.endPoint = .init(x: 1.5, y: 1.5)
        backgroundView!.layer.addSublayer(gradientBackground)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBackground.frame = backgroundView!.bounds
    }
}
