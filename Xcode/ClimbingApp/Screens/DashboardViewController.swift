//
//  DashboardViewController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/8/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SectionHeaderReusableViewDelegate, SetupSessionViewControllerDelegate {
    


    // MARK: Constants & Variables
    private var headerView: LargeHeaderView!
    private var collectionView: UICollectionView!
    
    struct Constants {
        static let title: String = "Dashboard"
        static let sectionIndexSummry: Int     = 0
        static let sectionIndexSessions: Int   = 1
        static let sectionIndexStatistics: Int = 2
        static let summaryCellHeight: CGFloat  = 160
        static let sessionCellWidth: CGFloat   = 115
        static let sessionCellHeight: CGFloat  = 160
        static let chartCellHeight: CGFloat    = 230
        static let numberOfSections: Int       = 3
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureHeaderView()
        configureCollectionView()
    }
    
    // MARK: Configuration
    
    private func configureHeaderView() {
        headerView = LargeHeaderView()
        headerView.pretitle = "The Climbing App"
        headerView.title = "Dashboard"
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            SummaryCell.self,
            forCellWithReuseIdentifier: SummaryCell.reuseIdentifier
        )
        
        collectionView.register(
            ChartCell.self,
            forCellWithReuseIdentifier: ChartCell.reuseIdentifier
        )
        
        collectionView.register(
            CardCell.self,
            forCellWithReuseIdentifier: CardCell.reuseIdentifier
        )
        
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier
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
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: UICollectrionView Layouts
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            switch sectionIndex {
            case Constants.sectionIndexSummry:
                section = self.createSummaryLayoutSection(for: layoutEnviroment)
            case Constants.sectionIndexSessions:
                section = self.createSessionsLayoutSection(for: layoutEnviroment)
            case Constants.sectionIndexStatistics:
                section = self.createStatisticsLayoutSection(for: layoutEnviroment)
            default: fatalError()
            }
            
            //section.addHeader()
            section.interGroupSpacing = .interGroupSpacing
            section.contentInsets = .init(
                top: .underSectionHeaderSpacing,
                leading: .screenEdgeSpacing,
                bottom: .zero,
                trailing: .screenEdgeSpacing)
            return section
        }
        
        
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .interSectionSpacting
        layout.configuration = config
        
        return layout
        
    }
    
    
    private func createSummaryLayoutSection(for: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(Constants.summaryCellHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createSessionsLayoutSection(for: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(Constants.sessionCellWidth), heightDimension: .absolute(Constants.sessionCellHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createStatisticsLayoutSection(for: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(Constants.chartCellHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath == IndexPath(row: 0, section: 1) {
            presentStartSessionViewController()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Constants.sectionIndexSummry: return 1
        case Constants.sectionIndexSessions: return 1
        case Constants.sectionIndexStatistics: return 5
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.sectionIndexSummry:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCell.reuseIdentifier, for: indexPath) as! SummaryCell
            return cell
        case Constants.sectionIndexSessions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
            cell.icon = UIImage(named: "plus.circle")
            cell.unselectedIconTintColor = .systemGray
            cell.pretitle = "Session"
            cell.title = "Start"
            return cell
        case Constants.sectionIndexStatistics:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCell.reuseIdentifier, for: indexPath) as! ChartCell
            cell.title = "Chart Title"
            cell.subtitle = "Chart Subtitle"
            return cell
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                for: indexPath) as! SectionHeaderReusableView
            
            sectionHeader.delegate = self
            
            switch indexPath.section {
            case Constants.sectionIndexSummry:
                sectionHeader.title = "Summary"
            case Constants.sectionIndexSessions:
                sectionHeader.title = "Sessions"
                sectionHeader.buttonTitle = "See All"
            case Constants.sectionIndexStatistics:
                sectionHeader.title = "Statistics"
                sectionHeader.buttonTitle = "See All"
            default: fatalError()
            }
            
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    
    // MARK: SectionHeaderReusableViewDelegate
    func auxiliaryButtonPressed(in sectionHeader: SectionHeaderReusableView) {
        print("pressded")
    }
    
    // MARK: SetupSessionViewControllerDelegate
    func setupSessionViewController(_ SetupSessionViewController: SetupSessionViewController, didSetupSessionWithDiscipline discipline: Discipline, andLocation location: Location) {
        
        let session = SessionModel(discipline: discipline, location: location)
        let sessionViewController = SessionViewController(session: session)
        sessionViewController.modalPresentationStyle = .overFullScreen
        present(sessionViewController, animated: true, completion: nil)
    
    }
    
    // MARK: Helpers & Utilities
    private func presentStartSessionViewController() {
        let setupSessionViewController = SetupSessionViewController()
        setupSessionViewController.delegate = self
        setupSessionViewController.modalPresentationStyle = .formSheet
        present(setupSessionViewController, animated: true, completion: nil)
    }
    
}
