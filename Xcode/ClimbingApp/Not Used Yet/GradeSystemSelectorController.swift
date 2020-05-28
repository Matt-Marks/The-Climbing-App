//
//  GradeSystemSelectorController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/28/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//


//  Description:
//  ------------
//  A menu used to select a grade system.


import UIKit


// ********************************************************************** //
// MARK: - GradeSystemSelectorControllerDataSource
// ********************************************************************** //
protocol GradeSystemSelectorControllerDataSource {
    func initialSelectedGradeSystem(in gradeSystemSelector: GradeSystemSelectorController) -> GradeSystem
}


// ********************************************************************** //
// MARK: - GradeSytemSelectorControllerDelegate
// ********************************************************************** //
protocol GradeSytemSelectorControllerDelegate {
    func gradeSystemSelector(_ gradeSystemSelector: GradeSystemSelectorController, didSelectGradeSystem gradeSystem: GradeSystem)
}


// ********************************************************************** //
// MARK: - GradeSystemSelectorController
// ********************************************************************** //
class GradeSystemSelectorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    // MARK: Constants & Variables
    public var delegate: GradeSytemSelectorControllerDelegate?
    public var dataSource: GradeSystemSelectorControllerDataSource?
    
    private var collectionView: UICollectionView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select Grade System"
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
        section.contentInsets = .init(top: .interItemSpacing, leading: .screenEdgeSpacing, bottom: 0, trailing: .screenEdgeSpacing)
        //section.addHeader()
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .screenEdgeSpacing
        layout.configuration = config

        return layout
    }
    

    // MARK: Collection View Delegate & Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return GradeSystem.boulderingGradeSystems.count
        case 1: return GradeSystem.freeClimbingGradeSystems.count
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TCADescriptiveButtonCell.reuseIdentifier,
            for: indexPath) as! TCADescriptiveButtonCell
        
        
        var gradeSystem: GradeSystem {
            switch indexPath.section {
            case 0: return GradeSystem.boulderingGradeSystems[indexPath.row]
            case 1: return GradeSystem.freeClimbingGradeSystems[indexPath.row]
            default: fatalError()
            }
        }
        
        cell.descriptiveButton.icon = gradeSystem.icon
        cell.descriptiveButton.title = gradeSystem.name
        cell.descriptiveButton.subtitle = gradeSystem.values[0]
        cell.descriptiveButton.unselectedIconTintColor = .systemGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TCASectionHeader.reuseIdentifier,
                for: indexPath) as! TCASectionHeader
            
            
            switch indexPath.section {
            case 0: sectionHeader.title = "Bouldering"
            case 1: sectionHeader.title = "Free Climbing"
            default: fatalError()
            }
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        switch indexPath.section {
        case 0:
            delegate?.gradeSystemSelector(self, didSelectGradeSystem: GradeSystem.boulderingGradeSystems[indexPath.row])
        case 1:
            delegate?.gradeSystemSelector(self, didSelectGradeSystem: GradeSystem.freeClimbingGradeSystems[indexPath.row])
        default: fatalError()
        }
        
        selectItem(at: indexPath)
        
        dismiss(animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    // MARK: Cell Selection
    private func highlightInitialSelection() {
        if let initialSelection = dataSource?.initialSelectedGradeSystem(in: self) {
            if GradeSystem.boulderingGradeSystems.contains(initialSelection) {
                let row = GradeSystem.boulderingGradeSystems.firstIndex(of: initialSelection)!
                selectItem(at: IndexPath(row: row, section: 0))
            } else {
                let row = GradeSystem.freeClimbingGradeSystems.firstIndex(of: initialSelection)!
                selectItem(at: IndexPath(row: row, section: 1))
            }
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

