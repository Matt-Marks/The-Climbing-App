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
    

    // The collection view holding location and discipline options.
    private var collectionView: UICollectionView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Color
        view.backgroundColor = .systemBackground
        
        // Configuration
        configureCollectionView()
//        configureCloseButton()
        
        // Initial Selection
        selectItem(at: IndexPath(row: selectedDiscipline.rawValue, section: Constants.sectionIndexDiscipline))

    }

    
    // MARK: Configuration
    
    /// Creates and places a close button in the top left corner.
//    private func configureCloseButton() {
//        let closeButton = UIButton(type: .close)
//        closeButton.addTarget(self,
//                              action: #selector(closeButtonPressed),
//                              for: .touchUpInside)
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
//        NSLayoutConstraint.activate([
//            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            closeButton.leftAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.leftAnchor,
//                constant: .screenEdgeSpacing
//            ),
//        ])
//    }

    /// Creates the collection view that is the main content of the view controller.
    private func configureCollectionView() {
        
        collectionView = UICollectionView( frame: .zero, collectionViewLayout: createLayout() )
        
        // Used for location options.
        collectionView.register(TCAButtonCell.self, forCellWithReuseIdentifier: TCAButtonCell.reuseIdentifier)
        
        // Used for discipline options.
        collectionView.register(TCADescriptiveButtonCell.self, forCellWithReuseIdentifier: TCADescriptiveButtonCell.reuseIdentifier)

        // Used for section headers.
        collectionView.register(TCASectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TCASectionHeader.reuseIdentifier)
        
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
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
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
                section = .vertical(itemHeight: .estimated(100), bottomInset: .interSectionSpacing)
                
                // Footer with start button.
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                
                section.boundarySupplementaryItems.append(footerItem)
                
            default: fatalError()
            }
            
            return section
        }
        
        
        // Add spacing between sections.
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .interSectionSpacing
        layout.configuration = config
        
        return layout
        
    }


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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCADescriptiveButtonCell.reuseIdentifier, for: indexPath) as! TCADescriptiveButtonCell
            
            let discipline = Discipline.allCases[indexPath.row]
            
            cell.descriptiveButton.image = discipline.icon
            cell.descriptiveButton.title = discipline.name
            cell.descriptiveButton.subtitle = discipline.shortDescription
            
            return cell
        case Constants.sectionIndexLocation:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCAButtonCell.reuseIdentifier, for: indexPath) as! TCAButtonCell

            
            
            return cell
            
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TCASectionHeader.reuseIdentifier,
                for: indexPath) as! TCASectionHeader
            
            
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
    private let startButton = TCAButton()
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
            separator.heightAnchor.constraint(equalToConstant: .dividerHeight)
        ])
        
        startButton.title = "Start Session"
        //startButton.unselectedBackgoundColor = .accent
        //startButton.unselectedTitleTextColor = .white
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
