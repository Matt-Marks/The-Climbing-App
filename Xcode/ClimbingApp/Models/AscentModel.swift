//
//  AscentModel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/30/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class AscentModel: NSObject, NSCoding {

    // MARK: Constants & Variables
    private struct Key {
        static let ascentType = "ascentType"
        static let climb      = "climb"
        static let date       = "date"
    }
    
    private var ascentType: AscentType
    private var climb: ClimbModel
    private var date: Date
    
    // MARK: Initialization
    init(ascentType: AscentType, climb: ClimbModel) {

        self.ascentType = ascentType
        self.climb = climb
        self.date = Date()
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(ascentType.rawValue, forKey: Key.ascentType)
        coder.encode(climb, forKey: Key.climb)
        coder.encode(date, forKey: Key.date)
    }
    
    required init?(coder: NSCoder) {
        
        guard let ascentType = AscentType(rawValue: coder.decodeInteger(forKey: Key.ascentType)) else { fatalError() }
        guard let climb      = coder.decodeObject(forKey: Key.climb) as? ClimbModel else { fatalError() }
        guard let date       = coder.decodeObject(forKey: Key.date) as? Date else { fatalError() }
        
        self.ascentType = ascentType
        self.climb      = climb
        self.date       = date
        
        super.init()
    }
    
}
