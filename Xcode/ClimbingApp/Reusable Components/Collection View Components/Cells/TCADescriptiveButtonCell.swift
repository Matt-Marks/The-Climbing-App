//
//  TCADescriptiveButtonCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/1/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



// Description:
// ------------
// This is a wrapper around the DescriptiveButton which allows us to use it
// as a cell in a UICollectionView.



import UIKit

class TCADescriptiveButtonCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "DescriptiveButtonCell"
    
    
    
    
    // MARK: Cell Properties
    override var isSelected: Bool {
        didSet {
            descriptiveButton.isSelected = isSelected
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            descriptiveButton.isHighlighted = isHighlighted
        }
    }
    
    
    // MARK: UI Element Declarations
    
    /// The entire cell consists of this one button.
    public let descriptiveButton = TCADescriptiveButton()
    
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = .cellCornerRadius
        clipsToBounds = true
        
        contentView.addSubview(descriptiveButton)
        descriptiveButton.isUserInteractionEnabled = false
        descriptiveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptiveButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptiveButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptiveButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptiveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
