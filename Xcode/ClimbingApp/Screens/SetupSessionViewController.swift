//
//  SetupSessionViewController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/20/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

// ********************************************************************** //
// MARK: - SetupSessionViewControllerDelegate
// ********************************************************************** //
protocol SetupSessionViewControllerDelegate {
    func setupSessionViewController(_ SetupSessionViewController: SetupSessionViewController, didSetupSessionWithDiscipline discipline: Discipline)
}

// ********************************************************************** //
// MARK: - SetupSessionViewController
// ********************************************************************** //
class SetupSessionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SetupSessionFooterReuseableViewDelegate {
    
    // MARK: Delegation
    public var delegate: SetupSessionViewControllerDelegate?
    
    // MARK: Constants & Variables
    
    struct Constants {
        static let initialSelectedDiscipline: Discipline = .bouldering
        static let pretitle: String            = "New Session"
        static let title: String               = "Configuration"
        static let startButtonTitle: String    = "Start Session"
        static let sectionIndexLocation: Int   = 999
        static let sectionIndexDiscipline: Int = 0
        static let numberOfSections: Int       = 1
    }
    
    // User selections
    private var selectedDiscipline: Discipline = Constants.initialSelectedDiscipline
    
    // The top nav bar.
    private var headerView: CompactHeaderView!
    
    // The collection view holding location and discipline options.
    private var collectionView: UICollectionView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Color
        view.backgroundColor = .systemBackground
        
        // Configuration
        configureHeaderView()
        configureCollectionView()
        configureCloseButton()
        
        // Initial Selection
        selectItem(at: IndexPath(row: selectedDiscipline.rawValue, section: Constants.sectionIndexDiscipline))

    }

    
    // MARK: Configuration
    
    /// Creates and places a close button in the top left corner.
    private func configureCloseButton() {
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self,
                              action: #selector(closeButtonPressed),
                              for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: .screenEdgeSpacing
            ),
        ])
    }
    
    /// Creates and places a stationary header at the top of the view controller.
    private func configureHeaderView() {
        headerView = CompactHeaderView()
        headerView.pretitle = Constants.pretitle
        headerView.title = Constants.title
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    /// Creates the collection view that is the main content of the view controller.
    private func configureCollectionView() {
        
        collectionView = UICollectionView( frame: .zero, collectionViewLayout: createLayout() )
        
        // Used for location options.
        collectionView.register(BasicButtonCell.self, forCellWithReuseIdentifier: BasicButtonCell.reuseIdentifier)
        
        // Used for discipline options.
        collectionView.register(DescriptiveButtonCell.self, forCellWithReuseIdentifier: DescriptiveButtonCell.reuseIdentifier)

        // Used for section headers.
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
        
        // Used for start sessions button.
        collectionView.register(SetupSessionFooterReuseableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SetupSessionFooterReuseableView.reuseIdentifier)
        
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
        collectionView.contentInset = .init( top: .screenEdgeSpacing, left: .zero, bottom: .screenEdgeSpacing, right: .zero)
        

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: UICollectrionView Layouts
    
    /// Creates the layout used for the collection view.
    ///
    /// - Returns:
    ///     - A UICollectionViewLayout used for the collection view.
    private func createLayout() -> UICollectionViewLayout {
        
        // We use a compositional layout made of two sections.
        let layout = UICollectionViewCompositionalLayout { (
            sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            switch sectionIndex {
            case Constants.sectionIndexDiscipline:
                section = self.createDisciplineLayoutSection(for: layoutEnviroment)
            default: fatalError()
            }
            
            return section
        }
        
        // Add spacing between sections.
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .interSectionSpacting
        layout.configuration = config
        
        return layout
        
    }
    
    /// Creates the layout for the section of the collection view containing the discipline buttons.
    ///
    /// - Parameters:
    ///     - layoutEnv: The NSCollectionLayoutEnvironment that the layout will be drawn in.
    ///
    /// - Returns:
    ///     - The NSCollectionLayoutSection used for the discipline section.
    private func createDisciplineLayoutSection(for layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        // Section
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        // Header with 'Discipline' text.
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // Footer with start button.
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        
        section.boundarySupplementaryItems = [headerItem, footerItem]
        section.interGroupSpacing = .interGroupSpacing
        section.contentInsets = .init(top: .underSectionHeaderSpacing, leading: .screenEdgeSpacing, bottom: .interSectionSpacting, trailing: .screenEdgeSpacing)
        
        return section
    }
    
    /// Creates the layout for the section of the collection view containing the location buttons.
    ///
    /// - Parameters:
    ///     - layoutEnv: The NSCollectionLayoutEnvironment that the layout will be drawn in.
    ///
    /// - Returns:
    ///     - The NSCollectionLayoutSection used for the location section.
//    private func createLocationLayoutSection(for layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//
//        // Section
//        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(45))
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: Location.allCases.count)
//        group.interItemSpacing = .fixed(.interItemSpacing)
//        let section = NSCollectionLayoutSection(group: group)
//
//        // Heaer with 'Location' text.
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
//        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//
//        section.boundarySupplementaryItems = [headerItem]
//        section.interGroupSpacing = .interGroupSpacing
//        section.contentInsets = .init( top: .underSectionHeaderSpacing, leading: .screenEdgeSpacing, bottom: .zero, trailing: .screenEdgeSpacing)
//
//        return section
//    }


    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == Constants.sectionIndexDiscipline {
            selectedDiscipline = Discipline(rawValue: indexPath.row)!
        }
        
        if indexPath.section == Constants.sectionIndexLocation {

        }
        
        selectItem(at: indexPath)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Constants.sectionIndexDiscipline: return Discipline.allCases.count
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.sectionIndexDiscipline:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptiveButtonCell.reuseIdentifier, for: indexPath) as! DescriptiveButtonCell
            
            let discipline = Discipline.allCases[indexPath.row]
            
            cell.descriptiveButton.icon = discipline.icon
            cell.descriptiveButton.title = discipline.name
            cell.descriptiveButton.subtitle = discipline.shortDescription
            
            return cell
        case Constants.sectionIndexLocation:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicButtonCell.reuseIdentifier, for: indexPath) as! BasicButtonCell

            
            
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
            
            
            switch indexPath.section {
            case Constants.sectionIndexDiscipline:
                sectionHeader.title = "Discipline"
            case Constants.sectionIndexLocation:
                sectionHeader.title = "Location"
            default: fatalError()
            }
            
            
            return sectionHeader
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SetupSessionFooterReuseableView.reuseIdentifier,
                for: indexPath) as! SetupSessionFooterReuseableView
            sectionFooter.delegate = self
            return sectionFooter
        }
        
        fatalError()
    }

    
    // MARK: Cell Selection
    
    /// Selects the cell at the given index path and deselects all the cells in that
    /// index paths section.
    ///
    /// - Parameters:
    ///     - indexPath: The IndexPath of the cell to select.
    private func selectItem(at indexPath: IndexPath) {
        
        collectionView.indexPathsForSelectedItems?.forEach({
            if $0 != indexPath && $0.section == indexPath.section {
                collectionView.deselectItem(at: $0, animated: false)
            }
        })
        
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    // MARK: Buttons Actions

    /// Called when the close button is pressed. Dismisses the screen.
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: SetupSessionFooterReuseableViewDelegate
    
    /// Called when the start button in the footer is pressed. Tells the delegate
    /// that a user intends to start a new session with a selected
    /// disipline and location.
    ///
    /// - Parameters:
    ///     - setupSessionFooter: The footer view with the start button.
    fileprivate func startButtonPressed(_ setupSessionFooter: SetupSessionFooterReuseableView) {
        dismiss(animated: true) {

        }
        
    }

}

// ********************************************************************** //
// MARK: - SetupSessionFooterReuseableViewDelegate
// ********************************************************************** //
fileprivate protocol SetupSessionFooterReuseableViewDelegate {
    func startButtonPressed(_ setupSessionFooter: SetupSessionFooterReuseableView)
}

// ********************************************************************** //
// MARK: - SetupSessionFooterReuseableView
// ********************************************************************** //
fileprivate class SetupSessionFooterReuseableView: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "SetupSessionFooterReuseableView"
    
    public var delegate: SetupSessionFooterReuseableViewDelegate?
    
    // MARK: Constants & Variables
    private let startButton = BasicButton()
    private let separator = UIView()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.leftAnchor.constraint(equalTo: leftAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: .separatorHeight)
        ])
        
        startButton.title = "Start Session"
        startButton.unselectedBackgoundColor = .accent
        startButton.unselectedTitleTextColor = .white
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: topAnchor, constant: .screenEdgeSpacing),
            startButton.leftAnchor.constraint(equalTo: leftAnchor),
            startButton.rightAnchor.constraint(equalTo: rightAnchor),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc
    private func startButtonPressed() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
        delegate?.startButtonPressed(self)
    }
}
