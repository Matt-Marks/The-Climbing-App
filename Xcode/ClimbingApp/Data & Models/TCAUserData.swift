//
//  TCAUserData.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/17/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation

struct TCAUserData {

    struct Keys {
        static let sessions  = "sessions"
        static let locations = "locations"
        static let climbs    = "climbs"
        static let attempts  = "attempts"
    }
    
    
    static var sessions: [SessionID : TCASession] {
        get {
            return unarchiveData(forKey: Keys.sessions)
        }
        set {
            archiveData(newValue, forKey: Keys.sessions)
        }
    }
    
    static var locations: [LocationID : TCALocation] {
        get {
            return unarchiveData(forKey: Keys.locations)
        }
        set {
            archiveData(newValue, forKey: Keys.locations)
        }
    }
    
    static var climbs: [ClimbID : TCAClimb] {
        get {
            return unarchiveData(forKey: Keys.climbs)
        }
        set {
            archiveData(newValue, forKey: Keys.climbs)
        }
    }
    
    static var attempts: [AttemptID : TCAAttempt] {
        get {
            return unarchiveData(forKey: Keys.attempts)
        }
        set {
            archiveData(newValue, forKey: Keys.attempts)
        }
    }
    
    
    
    private static func archiveData<T>(_ data: T, forKey key: String) {
        guard let archivedData = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false) else {fatalError()}
        UserDefaults.standard.set(archivedData, forKey: key)
    }
    
    
    private static func unarchiveData<T1, T2>(forKey key: String) -> [T1 : T2] {
        if keyExists(key) {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return [ : ]
            }
            guard let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [T1 : T2] else {
                return [ : ]
            }
            return dict
        } else {
            return [ : ]
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
