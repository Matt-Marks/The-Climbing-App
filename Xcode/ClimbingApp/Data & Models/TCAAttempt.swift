//
//  TCAAttempt.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/30/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAAttempt: NSObject, NSCoding {
    
    typealias AttemptID = Int

    // MARK: Constants & Variables
    private struct Key {
        static let attemptID  = "attemptID"
        static let successful = "successful"
        static let climbID    = "climbID"
        static let date       = "date"
    }
    
    private var attemptID: AttemptID
    private var successful: Bool
    private var climbID: ClimbID
    private var date: Date
    
    // MARK: Initialization
    init(attemptID: AttemptID, climbID: ClimbID, successful: Bool) {

        self.attemptID  = attemptID
        self.successful = successful
        self.climbID    = climbID
        self.date       = Date()
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(attemptID, forKey: Key.attemptID)
        coder.encode(successful, forKey: Key.successful)
        coder.encode(climbID, forKey: Key.climbID)
        coder.encode(date, forKey: Key.date)
    }
    
    required init?(coder: NSCoder) {

        guard let attemptID = coder.decodeObject(forKey: Key.attemptID) as? AttemptID else { fatalError() }
        guard let climbID = coder.decodeObject(forKey: Key.climbID) as? ClimbID else { fatalError() }
        guard let date    = coder.decodeObject(forKey: Key.date) as? Date else { fatalError() }
        
        self.attemptID  = attemptID
        self.successful = coder.decodeBool(forKey: Key.successful)
        self.climbID    = climbID
        self.date       = date
        
        super.init()
    }
    
}
