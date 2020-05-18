//
//  ClimbModel.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class ClimbModel: NSObject, NSCoding {
        
    // MARK: Constants & Variables
    private struct Key {
        static let grade       = "grade"
        static let gradeSystem = "gradeSystem"
        static let name        = "name"
        static let color       = "color"
        static let climbID     = "climbID"
    }
    
    private var climbID: ClimbID
    private var grade: Int
    private var gradeSystem: GradeSystem
    private var name: String
    private var color: ClimbColor
    
    // MARK: Initialization
    init(grade: Int, gradeSystem: GradeSystem, name: String, color: ClimbColor, climbID: ClimbID) {
        
        self.grade       = grade
        self.gradeSystem = gradeSystem
        self.name        = name
        self.color       = color
        self.climbID     = climbID
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(grade, forKey: Key.grade)
        coder.encode(gradeSystem.rawValue, forKey: Key.gradeSystem)
        coder.encode(name, forKey: Key.name)
        coder.encode(color.rawValue, forKey: Key.color)
        coder.encode(climbID, forKey: Key.climbID)
    }
    
    required init?(coder: NSCoder) {
        

        guard let gradeSystem = GradeSystem(rawValue: coder.decodeInteger(forKey: Key.gradeSystem)) else { fatalError() }
        guard let color       = ClimbColor(rawValue: coder.decodeInteger(forKey: Key.color)) else { fatalError() }
        guard let name        = coder.decodeObject(forKey: Key.name) as? String else { fatalError() }
        guard let climbID     = coder.decodeObject(forKey: Key.name) as? ClimbID else { fatalError() }
        
        self.grade       = coder.decodeInteger(forKey: Key.grade)
        self.gradeSystem = gradeSystem
        self.name        = name
        self.color       = color
        self.climbID     = climbID
        
        super.init()
    }
    

}
