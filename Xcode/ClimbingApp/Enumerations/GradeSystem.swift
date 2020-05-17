//
//  GradeSystem.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/22/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

enum GradeSystem: Int, CaseIterable {
    
    // Problems
    case Hueco         // USA 'V' Grade
    case Fontainebleau // European
    case Dankyu        // Japan
    
    // Routes
    case USA   // Yosenite Decimal System
    case FR    // French
    case UIAA  // International Climbing and Mountanieering Federation
    case AUS   // Australian
    case SA    // South African
    case FIN   // Finnish
    case NOR   // Norwegian
    case BRA   // Brazlian
    
    
    static var boulderingGradeSystems: [GradeSystem] {
        return [.Hueco, .Fontainebleau, .Dankyu]
    }
    
    static var freeClimbingGradeSystems: [GradeSystem] {
        return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
    }
    
    
    var name: String {
        switch self {
        case .Hueco:         return "Hueco"
        case .Fontainebleau: return "Fontainebleau"
        case .Dankyu:        return "Dankyu"
        case .USA:           return "USA"
        case .FR:            return "FR"
        case .UIAA:          return "UIAA"
        case .AUS:           return "AUS"
        case .SA:            return "SA"
        case .FIN:           return "FIN"
        case .NOR:           return "NOR"
        case .BRA:           return "BRA"
        }
    }
    
    var examples: String {
        allValues()[0...5].joined(separator: ", ") + "..."
    }
    
    var icon: UIImage {
        switch self {
        case .Hueco:         return UIImage(named: "america.circle")!
        case .Fontainebleau: return UIImage(named: "europe.circle")!
        case .Dankyu:        return UIImage(named: "japan.circle")!
        case .USA:           return UIImage(named: "america.circle")!
        case .FR:            return UIImage(named: "france.circle")!
        case .UIAA:          return UIImage(named: "sweden.circle")!
        case .AUS:           return UIImage(named: "australia.circle")!
        case .SA:            return UIImage(named: "south.africa.circle")!
        case .FIN:           return UIImage(named: "finland.circle")!
        case .NOR:           return UIImage(named: "norway.circle")!
        case .BRA:           return UIImage(named: "brazil.circle")!
        }
    }
    
    func integerRepresentation(forGradeString gradeString: String) -> Int {
        return normalizedValues().firstIndex(of: gradeString)!
    }
    
    func allValues() -> [String] {
        switch self {
            
        case .Hueco:         return ["V0","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17"]
        case .Fontainebleau: return ["1","2","3","4","4+","5","5+","6A","6A+","6B","6B+","6C","6C+","7A","7A+","7B","7B+","7C","7C+","8A","8A+","8B","8B+","8C+","9A"]
        case .Dankyu:        return ["7 kyuu","6 kyuu"," 5 kyuu","4 kyuu","3 kyuu","2 kyuu","1 kyuu","1 dan","2 dan","3 dan","4 dan","5 dan"]
            
        case .USA:           return ["5.0","5.1","5.2","5.3","5.4","5.5","5.6","5.7","5.8","5.8","5.9","5.10a","5.10b","5.10c","5.10d","5.11a","5.11b","5.11c","5.11d","5.12a","5.12b","5.12c","5.12d","5.13a","5.13b","5.13c","5.13d","5.14a","5.14b","5.14c","5.14d","5.15a","5.15b","5.15c","5.15d"]
        case .FR:            return ["1","2","3","4a","4b","4c","5a","5b","5c","6a","6a+","6b","6b+","6c","6c+","7a","7a+","7b","7b+","7c","7c+","8a","8a+","8b","8b+","8c","8c+","9a","9a+","9b","9b+","9c"]
        case .UIAA:          return ["I","II","III","IV","IV+","V-","V","V+","VI-","VI","VI+","VII-","VII","VII+","VIII-","VIII","VIII+","IX-","IX","IX+","X-","X","X+","XI-","XI","XI+","XII-","XII"]
        case .AUS:           return ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39"]
        case .SA:            return ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39", "40"]
        case .FIN:           return ["1","2","3","4","5-","5","5+","6-","6","6+","7-","7","7+","8-","8","8+","9-","9","9+","10-","10","10+","11-","11","11+","12-","12","12+"]
        case .NOR:           return ["1","2","3","4","5-","5","5+","6-","6","6+","7-","7","7+","8-","8","8+","9-","9","9+","10-","10","10+","11-","11","11+"]
        case .BRA:           return ["I","I sup","II","II sup","III","III sup","IV","IV sup","V","VI","VI sup","7a","7b","7c","8a","8b","8c","9a","9b","9c","10a","10b","10c","11a","11b","11c","12a","12b","12c"]
        }
    }
    
    func normalizedValues() -> [String] {
        switch self {
            
        case .Hueco:         return [    "V0",    "V0",    "V0",    "V0",    "V0",    "V1",    "V2",    "V3",    "V3",    "V4",    "V4",    "V5",    "V5",    "V6",   "V7",   "V8",   "V8",   "V9",  "V10",  "V11",  "V12",  "V13",  "V14",  "V15",  "V16",  "V17"]
        case .Fontainebleau: return [     "1",     "2",     "3",     "4",    "4+",     "5",    "5+",    "6A",   "6A+",    "6B",   "6B+",    "6C",   "6C+",    "7A",  "7A+",   "7B",  "7B+",   "7C",  "7C+",   "8A",  "8A+",   "8B",  "8B+",   "8C",  "8C+",   "9A"]
        case .Dankyu:        return ["7 kyuu","7 kyuu","7 kyuu","7 kyuu","6 kyuu","5 kyuu","5 kyuu","4 kyuu","3 kyuu","2 kyuu","2 kyuu","2 kyuu","1 kyuu","1 kyuu","1 dan","1 dan","2 dan","2 dan","3 dan","3 dan","4 dan","4 dan","5 dan","5 dan","5 dan","5 dan"]
            
        case .USA:           return ["5.0","5.0","5.0","5.0","5.1","5.1","5.2","5.3","5.3","5.4","5.5","5.5","5.5","5.6","5.7","5.7","5.8","5.9","5.9","5.10a","5.10b","5.10c","5.10d","5.11a","5.11b","5.11c","5.11d","5.12a","5.12a","5.12b","5.12c","5.12d","5.12d","5.13a","5.13b","5.13c","5.13c","5.13d","5.14a","5.14a","5.14b","5.14c","5.14d","5.15a","5.15b","5.15c","5.15d"]
        case .FR:            return ["1","1","1","1","2","2","2","3","3","4a","4b","4b","4b","4c","5a","5a","5b","5c","5c","6a","6a+","6b","6b+","6c","6c","6c+","7a","7a+","7a+","7b","7b+","7c","7c","7c+","8a","8a+","8a+","8b","8b+","8b+","8c","8c+","9a","9a+","9b","9b+","9c"]
        case .UIAA:          return ["I","I","I","I","II","II","II","III","III","IV","IV+","IV+","V-","V","V+","V+","VI-","VI","VI","VI+","VII-","VII","VII+","VII+","VIII-","VIII-","VIII","VIII+","VIII+","VIII+","IX-","IX","IX","IX+","IX+","X-","X-","X","X+","X+","X+","XI-","XI","XI+","XI+","XII-","XII"]
        case .AUS:           return ["1","2","3","4","5","6","7","8","9","10","11","12","12","13","14","15","16","17","17","18","19","20","20","21","22","23","23","24","24","25","26","27","27","28","29","30","30","31","32","32","33","34","35","36","37","38","39"]
        case .SA:            return ["1","2","3","4","5","6","7","8","9","10","11","12","12","13","14","15","16","17","18","19","20","21","22","22","23","24","25","26","26","27","28","29","29","30","31","32","32","33","34","34","35","36","37","38","39","40","40"]
        case .FIN:           return ["1","1","1","1","2","2","2","3","3","3","4","4","4","4","5-","5-","5","5+","5+","5+","6-","6","6","6+","6+","7-","7","7+","7+","8-","8","8+","8+","9-","9","9+","9+","10-","10","10","10+","11-","11","11+","12-","12","12+"]
        case .NOR:           return ["1","1","1","1","2","2","2","3","3","3","4","4","4","4","5-","5-","5","5+","5+","6-","6-","6","6+","6+","7-","7","7+","7+","8-","8-","8","8","8+","8+","9-","9-","9","9","9","9+","9+","10-","10","10+","11-","11","11+"]
        case .BRA:           return ["I","I","I sup","I sup","II","II","II sup","II sup","II sup","III","III sup","III sup","III sup","IV","IV","IV","IV sup","V","V","VI","VI","VI sup","VI sup","7a","7b","7c","7c","8a","8a","8b","8c","9a","9a","9b","9c","10a","10a","10b","10c","10c","11a","11b","11c","12a","12b","12c","12c"]
        }
    }
    

}



