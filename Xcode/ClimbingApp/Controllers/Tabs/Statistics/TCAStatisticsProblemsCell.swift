//
//  TCAStatisticsProblemsCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAStatisticsProblemsCell: UICollectionViewCell, ReuseIdentifiable {
    
    
    
    // MARK: ReuseIdentifiable
    static var reuseIdentifier: String = "TCAStatisticsProblemsCell"
    
    
    // MARK: UI Element Declarations
    let headerBar = TCACellHeaderBar()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds      = true
        contentView.layer.cornerRadius = .cellCornerRadius
        contentView.backgroundColor    = .cellBackgound
        contentView.layer.borderWidth  = .dividerHeight
        contentView.layer.borderColor  = UIColor.divider.cgColor
        
        configureHeaderBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Header Bar
    private func configureHeaderBar() {
        headerBar.selectedOptionIndex = 1
        headerBar.options = ["Day","Week","Month","Year","Max"]
        headerBar.title = "Problems"
        headerBar.addTarget(self, action: #selector(headerBarValueChanged), for: .valueChanged)
        headerBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerBar)
        NSLayoutConstraint.activate([
            headerBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerBar.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerBar.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    @objc
    private func headerBarValueChanged(_ sender: TCACellHeaderBar) {

    }
    
}
