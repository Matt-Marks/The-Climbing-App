//
//  TCALocationCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCALocationCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: Constants
    struct Constants {
        static let climbsLabelIconName = "chevron.right"
    }
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "TCALocationCell"
    
    
    // MARK: Options
    
    /// The enviroment is shown in a small label above the name.
    public var enviroment: Enviroment = .indoors {
        didSet {
            enviromentLabel.text = enviroment.name.uppercased()
        }
    }
    
    /// The name of the location. Appears in the top left corner.
    public var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    /// The number of climbs displayed in the bottom right corner.
    public var numberOfClimbs: Int = 0 {
        didSet {
            climbsLabel.text = "\(numberOfClimbs.description) Climbs"
        }
    }
    
    /// The background image for the location.
    public var backgroundImage: UIImage? {
        didSet {
            backgroundImageView.image = backgroundImage
        }
    }
    
    // MARK: Cell Properties
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    // MARK: UIElement Declarations
    
    /// The enviroment is shown in the small label above the name.
    private var enviromentLabel = UILabel()
    
    /// The name appears in the top left corner.
    private var nameLabel = UILabel()
    
    /// The image that appears in the background.
    private var backgroundImageView = UIImageView()
    
    /// The label that appears in the bottom right corner showing climb number.
    private var climbsLabel = Iconlabel()
    
    /// The stack view holding enviroment and name labels.
    private var titleStack = UIStackView()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // Needed so the background image stays within the bounds of the cell.
        contentView.clipsToBounds = true
        
        // Setup
        contentView.layer.cornerRadius = .cellCornerRadius
        contentView.backgroundColor = .cellBackgound
        
        // Setup background image.
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Setup title stack.
        titleStack.alignment = .leading
        titleStack.axis = .vertical
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleStack)
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .cellEdgeSpacing),
            titleStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .cellEdgeSpacing)
        ])
        
        // Setup enviroment label.
        enviromentLabel.textColor = .white
        enviromentLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        enviromentLabel.adjustsFontForContentSizeCategory = true
        titleStack.addArrangedSubview(enviromentLabel)
        
        // Setup name label.
        nameLabel.textColor = .white
        nameLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        titleStack.addArrangedSubview(nameLabel)
            
        // Setup climbs label.
        climbsLabel.icon = UIImage(systemName: Constants.climbsLabelIconName, withConfiguration: UIImage.SymbolConfiguration(scale: .small))
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
