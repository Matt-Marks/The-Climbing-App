//
//  BasicButtonCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/1/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a wrapper around the BasicButton which allows us to use it
// as a cell in a UICollectionView.




import UIKit

class TCABasicButtonCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "BasicButtonCell"
    
    
    
    
    // MARK: Cell Properties
    override var isSelected: Bool {
        didSet {
            basicButton.isSelected = isSelected
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            basicButton.isHighlighted = isHighlighted
        }
    }
    
    
    
    // MARK: UI Element Declarations
    
    /// The entire cell consists of this one button.
    public let basicButton = TCABasicButton()
    
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = .cellCornerRadius
        clipsToBounds = true
        
        contentView.addSubview(basicButton)
        basicButton.isUserInteractionEnabled = false
        basicButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basicButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            basicButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            basicButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
