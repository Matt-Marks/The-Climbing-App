//
//  TCAPostalAddress.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/31/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAPostalAddress: NSObject, NSCoding {
    
    private struct Key {
        static let street                = "street"
        static let subLocality           = "subLocality"
        static let city                  = "city"
        static let subAdministrativeArea = "subAdministrativeArea"
        static let state                 = "state"
        static let postalCode            = "postalCode"
        static let country               = "country"
        static let isoCountryCode        = "isoCountryCode"
    }
    
    var street: String?
    var subLocality: String?
    var city: String?
    var subAdministrativeArea: String?
    var state: String?
    var postalCode: String?
    var country: String?
    var isoCountryCode: String?
    
    init(street: String? = nil,
         subLocality: String? = nil,
         city: String? = nil,
         subAdministrativeArea: String? = nil,
         state: String? = nil,
         postalCode: String? = nil,
         country: String? = nil,
         isoCountryCode: String? = nil
    ) {
        self.street                = street
        self.subLocality           = subLocality
        self.city                  = city
        self.subAdministrativeArea = subAdministrativeArea
        self.state                 = state
        self.postalCode            = postalCode
        self.country               = country
        self.isoCountryCode        = isoCountryCode
        super.init()
    }

    func encode(with coder: NSCoder) {
        coder.encode(street, forKey: Key.street)
        coder.encode(subLocality, forKey: Key.subLocality)
        coder.encode(city, forKey: Key.city)
        coder.encode(subAdministrativeArea, forKey: Key.subAdministrativeArea)
        coder.encode(state, forKey: Key.state)
        coder.encode(postalCode, forKey: Key.postalCode)
        coder.encode(country, forKey: Key.country)
        coder.encode(isoCountryCode, forKey: Key.isoCountryCode)
    }
    
    required init?(coder: NSCoder) {
        self.street                = coder.decodeObject(forKey: Key.street) as? String
        self.subLocality           = coder.decodeObject(forKey: Key.subLocality) as? String
        self.city                  = coder.decodeObject(forKey: Key.city) as? String
        self.subAdministrativeArea = coder.decodeObject(forKey: Key.subAdministrativeArea) as? String
        self.state                 = coder.decodeObject(forKey: Key.state) as? String
        self.postalCode            = coder.decodeObject(forKey: Key.postalCode) as? String
        self.country               = coder.decodeObject(forKey: Key.country) as? String
        self.isoCountryCode        = coder.decodeObject(forKey: Key.isoCountryCode) as? String
        super.init()
    }
    
}
