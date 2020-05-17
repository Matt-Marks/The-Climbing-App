//
//  SummaryCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/19/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class SummaryCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "SummaryCell"
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
