//
//  ClimbType.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

enum ClimbType: Int, CaseIterable {
    
    case Attempt
    case Flash
    case Onsight
    case Redpoint
    case Repeat
    //case Other
    
    var name: String {
        switch self {
        case .Onsight:  return "Onsight"
        case .Flash:    return "Flash"
        case .Redpoint: return "Redpoint"
        case .Repeat:   return "Repeat"
        case .Attempt:  return "Attempt"
        //case .Other:    return "Other"
        }
    }
    
    var pluralName: String {
        switch self {
        case .Onsight:  return "Onsights"
        case .Flash:    return "Flashes"
        case .Redpoint: return "Redpoints"
        case .Repeat:   return "Repeats"
        case .Attempt:  return "Attempts"
        //case .Other:    return "Other"
        }
    }
    
    var description: String {
        switch self {
        case .Onsight:  return "Ascend a climb on your first try without knowledge of how."
        case .Flash:    return "Ascend a climb on your first try but with knowledge of how."
        case .Redpoint: return "Ascending a climb for the first time that you have attempted before."
        case .Repeat:   return "Ascending a climb that you have attempted before."
        case .Attempt:  return "If dont complete the climb for any reason."
        //case .Other:    return "Something else."
        }
    }
    
    var icon: UIImage {
        switch self {
        case .Onsight:  return UIImage(named: "onsight.circle")!
        case .Flash:    return UIImage(named: "flash.circle")!
        case .Redpoint: return UIImage(named: "redpoint.circle")!
        case .Repeat:   return UIImage(named: "repeat.circle")!
        case .Attempt:  return UIImage(named: "attempt.circle")!
        //case .Other:    return UIImage(named: "question.circle")!
        }
    }
    
    var color: UIColor {
        switch self {
        case .Onsight:  return .systemPurple
        case .Flash:    return .systemYellow
        case .Redpoint: return .systemPink
        case .Repeat:   return .systemGreen
        case .Attempt:  return .systemGray
        //case .Other:    return .systemGray
        }
    }
}
