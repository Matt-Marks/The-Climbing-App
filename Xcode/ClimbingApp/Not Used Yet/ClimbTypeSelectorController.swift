//
//  ClimbTypeSelectorController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/27/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

// ********************************************************************** //
// MARK: - ClimbTypeSelectorControllerDataSource
// ********************************************************************** //
protocol ClimbTypeSelectorControllerDataSource {
    func initialSelectedClimbType(in climbTypeSelector: ClimbTypeSelectorController) -> AttemptType
}

// ********************************************************************** //
// MARK: - ClimbTypeSelectorControllerDelegate
// ********************************************************************** //
protocol ClimbTypeSelectorControllerDelegate {
    func climbTypeSelector(_ climbTypeSelector: ClimbTypeSelectorController, didSelectClimbType climbType: AttemptType)
}


// ********************************************************************** //
// MARK: - ClimbTypeSelectorController
// ********************************************************************** //
class ClimbTypeSelectorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Constants & Variables
    public var delegate: ClimbTypeSelectorControllerDelegate?
    public var dataSource: ClimbTypeSelectorControllerDataSource?
    
    private var collectionView: UICollectionView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        title = "Select Type"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
        
        configureCollectionView()
        highlightInitialSelection()
    }
    
    
    // MARK: Collection View Configuration
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            TCADescriptiveButtonCell.self,
            forCellWithReuseIdentifier: TCADescriptiveButtonCell.reuseIdentifier
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
        collectionView.contentInset = .init(top: .screenEdgeSpacing, left: 0, bottom: .screenEdgeSpacing, right: 0)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: Collection View Layouts
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = .interItemSpacing
        section.contentInsets = .init(top: 0, leading: .screenEdgeSpacing, bottom: 0, trailing: .screenEdgeSpacing)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .screenEdgeSpacing
        layout.configuration = config

        return layout
    }
    

    // MARK: Collection View Delegate & Datasource
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AttemptType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TCADescriptiveButtonCell.reuseIdentifier,
            for: indexPath) as! TCADescriptiveButtonCell
        
        
        let climbType = AttemptType.allCases[indexPath.row]
        cell.descriptiveButton.image = climbType.icon
        cell.descriptiveButton.title = climbType.name
        cell.descriptiveButton.subtitle = climbType.description
        //cell.descriptiveButton.unselectedIconTintColor = climbType.color

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        delegate?.climbTypeSelector(self, didSelectClimbType: AttemptType(rawValue: indexPath.row)!)
        
        selectItem(at: indexPath)
        
        dismiss(animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    // MARK: Cell Selection
    private func highlightInitialSelection() {
        if let initialSelection = dataSource?.initialSelectedClimbType(in: self) {
            let row = AttemptType.allCases.firstIndex(of: initialSelection)!
            selectItem(at: IndexPath(row: row, section: 0))
        }
    }
    
    private func selectItem(at indexPath: IndexPath) {
        
        collectionView.indexPathsForSelectedItems?.forEach({
            if $0 != indexPath {
                collectionView.deselectItem(at: $0, animated: false)
            }
        })
        
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }

}

