//
//  UserData.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/17/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation

struct UserData {

    struct Keys {
        static let sessions  = "sessions"
        static let locations = "locations"
        static let climbs    = "climbs"
        static let attempts  = "attempts"
    }
    
    
    static var sessions: [SessionID : SessionModel] {
        get {
            if keyExists(Keys.sessions) {
                guard let data = UserDefaults.standard.data(forKey: Keys.sessions) else {
                    return [ : ]
                }
                guard let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SessionID : SessionModel] else {
                    return [ : ]
                }
                return dict
            } else {
                return [ : ]
            }
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {fatalError()}
            UserDefaults.standard.set(data, forKey: Keys.sessions)
        }
    }
    
    static var locations: [LocationID : LocationModel] {
        get {
            if keyExists(Keys.locations) {
                guard let data = UserDefaults.standard.data(forKey: Keys.locations) else {
                    return [ : ]
                }
                guard let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [LocationID : LocationModel] else {
                    return [ : ]
                }
                return dict
            } else {
                return [ : ]
            }
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {fatalError()}
            UserDefaults.standard.set(data, forKey: Keys.locations)
        }
    }
    
    static var climbs: [ClimbID : ClimbModel] {
        get {
            if keyExists(Keys.climbs) {
                guard let data = UserDefaults.standard.data(forKey: Keys.climbs) else {
                    return [ : ]
                }
                guard let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [ClimbID : ClimbModel] else {
                    return [ : ]
                }
                return dict
            } else {
                return [ : ]
            }
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {fatalError()}
            UserDefaults.standard.set(data, forKey: Keys.climbs)
        }
    }
    
    static var attempts: [AttemptID : AttemptModel] {
        get {
            if keyExists(Keys.attempts) {
                guard let data = UserDefaults.standard.data(forKey: Keys.attempts) else {
                    return [ : ]
                }
                guard let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [AttemptID : AttemptModel] else {
                    return [ : ]
                }
                return dict
            } else {
                return [ : ]
            }
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {fatalError()}
            UserDefaults.standard.set(data, forKey: Keys.attempts)
        }
    }
    
    
    

    
    /// Used to check if the user has modified this setting or not.
    ///
    /// - Parameters:
    ///     - key: A String representing the key for the UserDefaults dictionary.
    ///
    /// - Returns:
    ///     A boolean representing if that key exists in the dictionary or not.
    private static func keyExists(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
        
}
