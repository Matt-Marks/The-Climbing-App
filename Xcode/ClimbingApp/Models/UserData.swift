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
        static let savedSessions = "SavedSessions"
        static let gradeSystems = "GradeSystems"
    }
    
//    static var activeSession: Session?
//    static var activeSessionTimer: Timer?
//    
//    static var mostRecentGradeSystem: [Discipline : GradeSystem] {
//        get {
//            if keyExists(Keys.gradeSystems) {
//                let stringDict = UserDefaults.standard.dictionary(forKey: Keys.gradeSystems) as! [String : Int]
//                let intDict = Dictionary(uniqueKeysWithValues: stringDict.map { key, value in (Int(key)!, value) })
//                var typeDict = Dictionary(uniqueKeysWithValues: intDict.map { key, value in (Discipline(rawValue: key)!, GradeSystem(rawValue: value)!) })
//                
//                for discipline in Discipline.allCases {
//                    if typeDict[discipline] == nil {
//                        typeDict[discipline] = discipline.possibleGradeSystems.first!
//                    }
//                }
//                
//                return typeDict
//            } else {
//                var dict: [Discipline : GradeSystem] = [:]
//                for discipline in Discipline.allCases {
//                    dict[discipline] = discipline.possibleGradeSystems.first!
//                }
//                return dict
//            }
//        }
//        set {
//            let intDict = Dictionary(uniqueKeysWithValues: newValue.map { key, value in (key.rawValue.description, value.rawValue) })
//            UserDefaults.standard.set(intDict, forKey: Keys.gradeSystems)
//        }
//    }
//        
//    
//    static var savedSessions: [Session] {
//        get {
//            if keyExists(Keys.savedSessions) {
//                do {
//                    let data = UserDefaults.standard.data(forKey: Keys.savedSessions)
//                    let decoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [Session]
//                    return decoded
//                } catch {
//                    fatalError("error decoding")
//                }
//                
//            } else {
//                return []
//            }
//        }
//        set {
//            do {
//                let data = try NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false)
//                UserDefaults.standard.set(data, forKey: Keys.savedSessions)
//            } catch {
//                fatalError("error encoding")
//            }
//
//        }
//    }
    
    
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
