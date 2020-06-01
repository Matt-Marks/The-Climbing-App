//
//  TCACoordinate.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/31/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCACoordinate: NSObject, NSCoding  {
    
    private struct Key {
        static let latitude  = "latitude"
        static let longitude = "longitude"
    }
    
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(latitude, forKey: Key.latitude)
        coder.encode(longitude, forKey: Key.longitude)
    }
    
    required init?(coder: NSCoder) {
        self.latitude  = coder.decodeDouble(forKey: Key.latitude)
        self.longitude = coder.decodeDouble(forKey: Key.longitude)
        super.init()
    }
}
