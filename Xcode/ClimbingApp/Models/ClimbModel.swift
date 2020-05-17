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
    }
    
    private var grade: Int
    private var gradeSystem: GradeSystem
    private var name: String
    private var color: ClimbColor
    
    // MARK: Initialization
    init(grade: Int, gradeSystem: GradeSystem, name: String, color: ClimbColor) {
        
        self.grade       = grade
        self.gradeSystem = gradeSystem
        self.name        = name
        self.color       = color
        
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(grade, forKey: Key.grade)
        coder.encode(gradeSystem.rawValue, forKey: Key.gradeSystem)
        coder.encode(name, forKey: Key.name)
        coder.encode(color.rawValue, forKey: Key.color)
    }
    
    required init?(coder: NSCoder) {
        

        guard let gradeSystem = GradeSystem(rawValue: coder.decodeInteger(forKey: Key.gradeSystem)) else { fatalError() }
        guard let color       = ClimbColor(rawValue: coder.decodeInteger(forKey: Key.color)) else { fatalError() }
        guard let name        = coder.decodeObject(forKey: Key.name) as? String else { fatalError() }
        
        self.grade       = coder.decodeInteger(forKey: Key.grade)
        self.gradeSystem = gradeSystem
        self.name        = name
        self.color       = color
        
        super.init()
    }
    

}
