//
//  TCARootController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

// USED FOR THE FAKE DATA
import Contacts
import MapKit

class TCARootController: UITabBarController, UISplitViewControllerDelegate {
    
    let config = UIImage.SymbolConfiguration(weight: .semibold)
    
    var sessionsController   = TCASessionsController()
    var locationsController  = TCALocationsController()
    var statisticsController = TCAStatisticsController()
    var settingsController   = TCASettingsController()
    
    var sessionsNavController: UINavigationController!
    var locationsNavController: UINavigationController!
    var statisticsNavController: UINavigationController!
    var settingsNavController: UINavigationController!
    
    
    let locationsSplitController = UISplitViewController()
    let settingsSplitController = UISplitViewController()

        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TCAUserData.locations[0] = TCALocation(address: TCAPostalAddress(street: "a", subLocality: "a", city: "a", subAdministrativeArea: "a", state: "a", postalCode: "a", country: "a", isoCountryCode: "a"),
                                               enviroment: .outdoors,
                                               name: "Northwest Branch Climbing",
                                               climbIDs: [0,1,2,3,4,5],
                                               locationID: 0,
                                               coordinates: TCACoordinate(latitude: 39.03, longitude: -77.004))
        
                // SETTING SOME FAKE DATA IN USER DATA
        //        TCAUserData.locations = [
        //            0 : TCALocation(
        //                address: CNMutablePostalAddress(),
        //                enviroment: .outdoors,
        //                name: "Northwest Branch Climbing",
        //                climbIDs: [0,1,2,3,4,5],
        //                locationID: 0,
        //                coordinates: CLLocationCoordinate2D(latitude: 39.03, longitude: -77.004)),
        //            1 : TCALocation(
        //                address: CNMutablePostalAddress(),
        //                enviroment: .outdoors,
        //                name: "Cunningham Falls State Park Climbing",
        //                climbIDs: [6,7,8,9,10,11],
        //                locationID: 1,
        //                coordinates: CLLocationCoordinate2D(latitude: 39.6, longitude: -77.452))
        //        ]
        //
        //        TCAUserData.climbs = [
        //            0 : TCAClimb(grade: 0, gradeSystem: .Hueco, name: "Denim Devil", color: .black, climbID: 0),
        //            1 : TCAClimb(grade: 1, gradeSystem: .Hueco, name: "Don't Fall Right", color: .black, climbID: 1),
        //            2 : TCAClimb(grade: 1, gradeSystem: .Hueco, name: "Kinder Garden", color: .black, climbID: 2),
        //            3 : TCAClimb(grade: 1, gradeSystem: .Hueco, name: "Center Face", color: .black, climbID: 3),
        //            4 : TCAClimb(grade: 2, gradeSystem: .Hueco, name: "Snowflake", color: .black, climbID: 4),
        //            5 : TCAClimb(grade: 2, gradeSystem: .Hueco, name: "The Fin", color: .black, climbID: 5),
        //
        //            6 : TCAClimb(grade: 1, gradeSystem: .Hueco, name: "Ground Squirrel Don't Care", color: .black, climbID: 6),
        //            7 : TCAClimb(grade: 2, gradeSystem: .Hueco, name: "Sharthouse", color: .black, climbID: 7),
        //            8 : TCAClimb(grade: 2, gradeSystem: .Hueco, name: "Squirrel Variation", color: .black, climbID: 8),
        //            9 : TCAClimb(grade: 3, gradeSystem: .Hueco, name: "Vasectomy", color: .black, climbID: 9),
        //            10 : TCAClimb(grade: 3, gradeSystem: .Hueco, name: "What's the Plural of Doofus", color: .black, climbID: 10),
        //            11 : TCAClimb(grade: 4, gradeSystem: .Hueco, name: "Moral Relativity", color: .black, climbID: 11),
        //        ]
        //        
        
        locationsSplitController.delegate = self
        settingsSplitController.delegate = self
        
        locationsController.clearsSelectionOnViewWillAppear = true
        settingsController.clearsSelectionOnViewWillAppear = true
        
        sessionsNavController   = UINavigationController(rootViewController: sessionsController)
        locationsNavController  = UINavigationController(rootViewController: locationsController)
        statisticsNavController = UINavigationController(rootViewController: statisticsController)
        settingsNavController   = UINavigationController(rootViewController: settingsController)
        
        locationsSplitController.viewControllers = [locationsNavController]
        locationsSplitController.preferredDisplayMode = .allVisible
        
        settingsSplitController.viewControllers = [settingsNavController, UINavigationController(rootViewController: TCASettingsGeneralController())]
        settingsSplitController.preferredDisplayMode = .allVisible
        
        
        
        sessionsNavController.tabBarItem = UITabBarItem(title: "Sessions",
                                                     image:  UIImage(systemName: "rectangle.stack", withConfiguration: config),
                                                     selectedImage: UIImage(systemName: "rectangle.stack", withConfiguration: config))
        
        locationsSplitController.tabBarItem = UITabBarItem(title: "Locations",
                                                      image:  UIImage(systemName: "location", withConfiguration: config),
                                                      selectedImage: UIImage(systemName: "location", withConfiguration: config))
        
        statisticsNavController.tabBarItem = UITabBarItem(title: "Statistics",
                                                       image:  UIImage(systemName: "chart.bar", withConfiguration: config),
                                                       selectedImage: UIImage(systemName: "chart.bar", withConfiguration: config))
        
        settingsSplitController.tabBarItem = UITabBarItem(title: "Settings",
                                                          image:  UIImage(systemName: "gear", withConfiguration: config),
                                                          selectedImage: UIImage(systemName: "gear", withConfiguration: config))
        
        
        viewControllers = [sessionsNavController, locationsSplitController, statisticsNavController, settingsSplitController]
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NotificationCenter.default.post(name: .TraitCollectionDidChange, object: nil)
    }


    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
