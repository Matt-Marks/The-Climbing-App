//
//  LocationModel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/17/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Contacts
import UIKit

class LocationModel: NSObject, NSCoding {
    
    
    private struct Key {
        static let address    = "address"
        static let enviroment = "enviroment"
        static let name       = "name"
        static let climbIDs   = "climbIDs"
        static let locationID = "locationID"
    }
    
    private var climbIDs: [ClimbID]
    private var locationID: LocationID
    private var address: CNMutablePostalAddress
    private var enviroment: Enviroment
    private var name: String
    
    
    init(address: CNMutablePostalAddress, enviroment: Enviroment, name: String, climbIDs: [ClimbID], locationID: LocationID) {
        self.address = address
        self.enviroment = enviroment
        self.name = name
        self.climbIDs = climbIDs
        self.locationID = locationID
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(address, forKey: Key.address)
        coder.encode(enviroment.rawValue, forKey: Key.enviroment)
        coder.encode(name, forKey: Key.name)
        coder.encode(climbIDs, forKey: Key.climbIDs)
        coder.encode(locationID, forKey: Key.locationID)
    }
    
    required init?(coder: NSCoder) {
        
        guard let address = coder.decodeObject(forKey: Key.address) as? CNMutablePostalAddress else { fatalError() }
        guard let enviroment = Enviroment(rawValue: coder.decodeInteger(forKey: Key.enviroment)) else { fatalError() }
        guard let name = coder.decodeObject(forKey: Key.address) as? String else { fatalError() }
        guard let climbIDs = coder.decodeObject(forKey: Key.climbIDs) as? [ClimbID] else { fatalError() }
        guard let locationID = coder.decodeObject(forKey: Key.locationID) as? LocationID else { fatalError() }
        
        self.address = address
        self.enviroment = enviroment
        self.name = name
        self.climbIDs = climbIDs
        self.locationID = locationID
        
        super.init()
    }
    
    
    
    
    
    
}
