//
//  SessionModel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class SessionModel: NSObject, NSCoding {
    
    // MARK: Constants & Variables
    private struct Key {
        static let discipline = "discipline"
        static let location   = "location"
        static let ascents    = "ascents"
        static let date       = "date"
    }
    
    private var discipline: Discipline
    private var location: Location
    private var ascents: [AscentModel]
    private var date: Date
    
    // MARK: Initialization
    init(discipline: Discipline, location: Location) {
        
        self.discipline = discipline
        self.location   = location
        self.ascents    = []
        self.date       = Date()
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(discipline.rawValue, forKey: Key.discipline)
        coder.encode(location.rawValue, forKey: Key.location)
        coder.encode(ascents, forKey: Key.ascents)
        coder.encode(date, forKey: Key.date)
    }
    
    required init?(coder: NSCoder) {
        
        guard let discipline = Discipline(rawValue: coder.decodeInteger(forKey: Key.discipline)) else { fatalError() }
        guard let location   = Location(rawValue: coder.decodeInteger(forKey: Key.location)) else { fatalError() }
        guard let ascents     = coder.decodeObject(forKey: Key.ascents) as? [AscentModel] else { fatalError() }
        guard let date       = coder.decodeObject(forKey: Key.date) as? Date else { fatalError() }
        
        self.discipline = discipline
        self.location   = location
        self.ascents    = ascents
        self.date       = date
        
        super.init()
        
    }
    
    // MARK: Getters & Setters
    public func getDiscipline() -> Discipline {
        return discipline
    }
    
    public func getLocation() -> Location {
        return location
    }
    
    public func numAscents() -> Int {
        return ascents.count
    }
    
}
