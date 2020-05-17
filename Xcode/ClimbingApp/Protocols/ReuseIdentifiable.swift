//
//  IdentifiableCell.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/16/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}
