//
//  TCASession.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCASession: NSObject, NSCoding {
    
    // MARK: Constants & Variables
    private struct Key {
        static let discipline = "discipline"
        static let date       = "date"
        static let attemptIDs = "attemptIDs"
        static let locationID = "locationID"
    }
     
    private var discipline: Discipline
    private var date: Date
    private var attemptIDs: [AttemptID]
    private var locationID: LocationID
    
    // MARK: Initialization
    init(discipline: Discipline, attemptIDs: [AttemptID], locationID: LocationID) {
        
        self.discipline = discipline
        self.date       = Date()
        self.attemptIDs = attemptIDs
        self.locationID = locationID
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(discipline.rawValue, forKey: Key.discipline)
        
        coder.encode(date, forKey: Key.date)
    }
    
    required init?(coder: NSCoder) {
        
        guard let discipline = Discipline(rawValue: coder.decodeInteger(forKey: Key.discipline)) else { fatalError() }
        guard let date       = coder.decodeObject(forKey: Key.date) as? Date else { fatalError() }
        guard let attemptIDs = coder.decodeObject(forKey: Key.attemptIDs) as? [AttemptID] else { fatalError() }
        
        self.discipline = discipline
        self.date       = date
        self.attemptIDs = attemptIDs
        self.locationID = coder.decodeInteger(forKey: Key.locationID)
        
        super.init()
        
    }

}
