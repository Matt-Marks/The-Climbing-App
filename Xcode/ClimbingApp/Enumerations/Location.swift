//
//  Location.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/22/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

enum Location: Int, CaseIterable {
    
    case indoors
    case outdoors
    
    var icon: UIImage {
        switch self {
        case .indoors: return UIImage(systemName: "house.fill")!
        case .outdoors: return UIImage(systemName: "cloud.sun.fill")!
        }
    }
    
    var name: String {
        switch self {
        case .indoors: return "Indoors"
        case .outdoors: return "Outdoors"
        }
    }
    
}
