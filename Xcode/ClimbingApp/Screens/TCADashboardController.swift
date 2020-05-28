//
//  TCADashboardController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/8/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit
import Contacts

class TCADashboardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TCASectionHeaderDelegate, SetupSessionViewControllerDelegate {
    
    
    // MARK: Constants
    struct Constants {
        static let pretitle: String            = "The Climbing App"
        static let title: String               = "Dashboard"
        static let locationCellHeight: CGFloat = 170
        static let locationCellWidth: CGFloat  = 250
        static let sessionCellWidth: CGFloat   = 115
        static let sessionCellHeight: CGFloat  = 160
        static let chartCellHeight: CGFloat    = 230
        
        enum Sections: Int, CaseIterable {
            case sessions, locations, statistics
        }
    }
    
    
    // MARK: UI Element Declarations
    
    /// The navigarion bar at the top of the screen.
    private var navBar: TCANavigationBar!
    
    /// The collection view under the navigation bar.
    private var collectionView: UICollectionView!
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureNavBar()
        configureCollectionView()
    }
    
    // MARK: Configuration
    
    
    /// Creates and configures the large navigation bar found at the top of
    /// the screen.
    private func configureNavBar() {
        navBar = TCANavigationBar()
        navBar.pretitle = Constants.pretitle
        navBar.title = Constants.title
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navBar.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    /// Creates and configures the collection view that spans the entire screen.
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            TCABannerCell.self,
            forCellWithReuseIdentifier: TCABannerCell.reuseIdentifier
        )
        
        collectionView.register(
            TCALocationCell.self,
            forCellWithReuseIdentifier: TCALocationCell.reuseIdentifier
        )
        
        collectionView.register(
            TCAChartCell.self,
            forCellWithReuseIdentifier: TCAChartCell.reuseIdentifier
        )
        
        collectionView.register(
            TCACardCell.self,
            forCellWithReuseIdentifier: TCACardCell.reuseIdentifier
        )
        
        collectionView.register(
            TCASectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TCASectionHeader.reuseIdentifier
        )
        
        // We dont use multiple selection. But, since content touches are not
        // delayed we need multiple selection to be enabled so cells don't
        // temporaraly deselect while scrolling. (Cells deselect while scrolling
        // when content touches are not delayed because the cell under the
        // users finher starts the highlighting process. If multiple selection is
        // not enabled the start of the highlighting process
        // will deselect selected cells)
        collectionView.allowsMultipleSelection = true
        collectionView.delaysContentTouches = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // The left and right margins are applied to the section layouts themselves.
        // Otherwise, the collection view scrolls horizonally. These content
        // insets EXPAND the content size of the collection view. This is stupid.
        // Setting the content inssets on sections does not change the content
        // size of the collection view.
        collectionView.contentInset = .init(
            top: .screenEdgeSpacing,
            left: .zero,
            bottom: .screenEdgeSpacing,
            right: .zero
        )
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: UICollectrionView Layouts
    
    /// Creates a UICollectionViewLayout for the collection view. This layout
    /// has three sections, one for sessions, locations, and statistics.
    ///
    /// - Returns:
    ///     - A UICollectionVewLayout for this collection view.
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            switch Constants.Sections(rawValue: sectionIndex)! {
            case Constants.Sections.sessions:
                section = .horizontal(itemWidth: .absolute(Constants.sessionCellWidth), sectionHeight: .absolute(Constants.sessionCellHeight))
            case Constants.Sections.locations:
                
                if TCAUserData.locations.count == 0 {
                    section = .vertical(itemHeight: .absolute(Constants.locationCellHeight))
                } else {
                    section = .horizontal(itemWidth: .absolute(Constants.locationCellWidth), sectionHeight: .absolute(Constants.locationCellHeight))
                }
                
            case Constants.Sections.statistics:
                section = .vertical(itemHeight: .absolute(Constants.chartCellHeight))
            }
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .interSectionSpacing
        layout.configuration = config
        
        return layout
        
    }
    
    
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        switch Constants.Sections(rawValue: indexPath.section)! {
        case Constants.Sections.sessions:
            if indexPath.row == 0 {
                presentStartSessionViewController()
            }
        case Constants.Sections.locations:
            ()
        case Constants.Sections.statistics:
            ()
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Constants.Sections(rawValue: section)! {
        case Constants.Sections.sessions:
            return TCAUserData.sessions.count + 1
        case Constants.Sections.locations:
            return max(TCAUserData.locations.count, 1)
        case Constants.Sections.statistics:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Constants.Sections(rawValue: indexPath.section)! {
        case Constants.Sections.sessions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCACardCell.reuseIdentifier, for: indexPath) as! TCACardCell
            cell.icon = UIImage(named: "plus.circle")
            cell.unselectedIconTintColor = .systemGray
            cell.pretitle = "Session"
            cell.title = "Start"
            return cell
        case Constants.Sections.locations:
            
            if TCAUserData.locations.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCABannerCell.reuseIdentifier, for: indexPath) as! TCABannerCell
                //cell.pretitle = "No Locations"
                cell.title = "Add a Location"
                cell.message = "Add a location with climbs and things."
                //cell.buttonTitle = "Button"
                cell.displayStyle = .grayscale
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCACardCell.reuseIdentifier, for: indexPath) as! TCACardCell
                cell.icon = UIImage(named: "plus.circle")
                cell.unselectedIconTintColor = .systemGray
                cell.pretitle = "Session"
                cell.title = "Start"
                return cell
            }
            
            
            
        case Constants.Sections.statistics:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCAChartCell.reuseIdentifier, for: indexPath) as! TCAChartCell
            cell.title = "Chart Title"
            cell.subtitle = "Chart Subtitle"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TCASectionHeader.reuseIdentifier,
                for: indexPath) as! TCASectionHeader
            
            sectionHeader.delegate = self
            
            switch Constants.Sections(rawValue: indexPath.section)! {
            case Constants.Sections.sessions:
                sectionHeader.title = "Sessions"
                sectionHeader.buttonTitle = "See All"
            case Constants.Sections.locations:
                sectionHeader.title = "Locations"
                sectionHeader.buttonTitle = "Edit"
            case Constants.Sections.statistics:
                sectionHeader.title = "Statistics"
                sectionHeader.buttonTitle = "Edit"
            }
            
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    
    // MARK: TCASectionHeaderDelegate
    func auxiliaryButtonPressed(in sectionHeader: TCASectionHeader) {
     
        switch sectionHeader.title {
        case "Sessions":
            print("sessions")
        case "Locations":
            
            let address = CNMutablePostalAddress()
            address.street = "7215 Columbia Gateway Drive, Suite 110"
            address.city = "Columbia"
            address.state = "MD"
            address.postalCode = "21046"
            
            let location = TCALocation(address: address, enviroment: .indoors, name: "Earth Treks (Columbia)", climbIDs: [], locationID: 0, coordinates: .init(latitude: 0, longitude: 0))
            let locationController = TCALocationController(location: location)
            //locationController.modalPresentationStyle = .pageSheet
            let navControl = UINavigationController(rootViewController: locationController)
            navControl.modalPresentationStyle = .pageSheet
            present(navControl, animated: true, completion: nil)
            
        case "Statistics":
            print("statistics")
        default: ()
        }
    }
    
    // MARK: SetupSessionViewControllerDelegate
    func setupSessionViewController(_ SetupSessionViewController: SetupSessionViewController, didSetupSessionWithDiscipline discipline: Discipline) {
        
//        let session = TCASession(discipline: discipline, location: location)
//        let sessionViewController = SessionViewController(session: session)
//        sessionViewController.modalPresentationStyle = .overFullScreen
//        present(sessionViewController, animated: true, completion: nil)
    
    }
    
    // MARK: Helpers & Utilities
    private func presentStartSessionViewController() {
        let setupSessionViewController = SetupSessionViewController()
        setupSessionViewController.delegate = self
        setupSessionViewController.modalPresentationStyle = .formSheet
        present(setupSessionViewController, animated: true, completion: nil)
    }
    
}
