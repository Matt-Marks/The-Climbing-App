//
//  TCALocationController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCALocationController: UIViewController {
    
    let location: LocationModel
    
    init(location: LocationModel) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
