//
//  LocationCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "LocationCell"
    
    
    public var enviroment: Enviroment = .indoors {
        didSet {
            enviromentLabel.text = enviroment.name.uppercased()
        }
    }
    
    public var name: String = "Location Name" {
        didSet {
            nameLabel.text = name
        }
    }
    
    
    private var enviromentLabel = UILabel()
    private var nameLabel = UILabel()
    
    private var climbsLabel = Iconlabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.clipsToBounds = true
        
        contentView.layer.cornerRadius = .cellCornerRadius
        
        contentView.backgroundColor = .cellBackgound
        
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "generic.gym")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .cellEdgeSpacing),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .cellEdgeSpacing)
        ])
        
        enviromentLabel.textColor = .white
        nameLabel.textColor = .white
        enviromentLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        nameLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        enviromentLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontForContentSizeCategory = true
        
        stack.addArrangedSubview(enviromentLabel)
        stack.addArrangedSubview(nameLabel)
        
        
        climbsLabel.text = "147 Climbs"
        climbsLabel.icon = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        climbsLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        climbsLabel.iconColor = .white
        climbsLabel.textColor = .white
        climbsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(climbsLabel)
        NSLayoutConstraint.activate([
            climbsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -.cellEdgeSpacing),
            climbsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.cellEdgeSpacing)
        ])

        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
