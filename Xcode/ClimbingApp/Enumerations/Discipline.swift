//
//  Discipline.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

enum Discipline: Int, CaseIterable {
    
    case bouldering
    case topRoping
    case sportClimbing
    case tradClimbing
    case alpine
    case viaFerrata
    case aidClimbing
    
    
    var icon: UIImage {
        switch self {
        case .bouldering:    return UIImage(named: "discipline.bouldering")!
        case .topRoping:     return UIImage(named: "discipline.top.roping")!
        case .sportClimbing: return UIImage(named: "discipline.sport.climbing")!
        case .tradClimbing:  return UIImage(named: "discipline.trad.climbing")!
        case .alpine:        return UIImage(named: "discipline.alpine")!
        case .viaFerrata:    return UIImage(named: "discipline.alpine")!
        case .aidClimbing:   return UIImage(named: "discipline.aid.climbing")!
        }
    }
    
    var name: String {
        switch self {
        case .bouldering:    return "Bouldering"
        case .topRoping:     return "Top Roping"
        case .sportClimbing: return "Sport Climbing"
        case .tradClimbing:  return "Trad Climbing"
        case .alpine:        return "Alpine"
        case .viaFerrata:    return "Via Ferrata"
        case .aidClimbing:   return "Aid Climbing"
        }
    }
    
    var shortDescription: String {
        switch self {
        case .bouldering:    return "Climbing on shorter walls without ropes or harnesses."
        case .topRoping:     return "Climbing with a rope, belayer, and anchor system."
        case .sportClimbing: return "Climbing with a rope and belayer while clipping into pre-placed bolts."
        case .tradClimbing:  return "Climbing with a rope and belayer while clipping into self-placed bolts."
        case .alpine:        return "Mountaineering in a mostly self-sufficient manner."
        case .viaFerrata:    return "A mountain route equipped with cables, ladders, and fixed anchors."
        case .aidClimbing:   return "Climbing while pulling oneself up via devices placed for protection."
        }
    }
        
    var possibleGradeSystems: [GradeSystem] { // The first item in these arrays is ALSO the default system.
        switch self {
        case .bouldering:    return [.Hueco, .Fontainebleau, .Dankyu]
        case .topRoping:     return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        case .tradClimbing:  return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        case .sportClimbing: return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        case .alpine:        return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        case .viaFerrata:    return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        case .aidClimbing:   return [.USA, .FR, .UIAA, .AUS, .SA, .FIN, .NOR, .BRA]
        }
    }
    
    
}
