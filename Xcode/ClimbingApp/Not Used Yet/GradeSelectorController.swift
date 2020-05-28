//
//  GradeSelectorController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 3/27/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

// ********************************************************************** //
// MARK: - GradeSelectorControllerDataSource
// ********************************************************************** //
protocol GradeSelectorControllerDataSource {
    func initialSelectedGrade(in gradeSelector: GradeSelectorController) -> Int
}

// ********************************************************************** //
// MARK: - GradeSelectorControllerDelegate
// ********************************************************************** //
protocol GradeSelectorControllerDelegate {
    func gradeSelector(_ gradeSelector: GradeSelectorController, didSelectGrade grade: Int, fromGradeSystem gradeSystem: GradeSystem)
}

// ********************************************************************** //
// MARK: - GradeSelectorController
// ********************************************************************** //

class GradeSelectorController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GradeSystemSelectorControllerDataSource, GradeSytemSelectorControllerDelegate, TCASectionHeaderDelegate {
    

    
    // MARK: Constants & Variables
    
    private var gradeSystem: GradeSystem
    
    public var delegate: GradeSelectorControllerDelegate?
    public var dataSource: GradeSelectorControllerDataSource?
    
    private var collectionView: UICollectionView!

    // MARK: Initialization
    init(initialGradeSystem: GradeSystem) {
        self.gradeSystem = initialGradeSystem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        navControl?.setLargeTitle("Select Grade")
//        navControl?.addCloseButton()
//        navControl?.forceConformance(to: .compact)
        
        title = "Select Grade"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)

        configureCollectionView()
        highlightInitialSelection()
    }


    // MARK: CollectionView Configuration, Layouts, Delegate, & Datasource
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            TCABasicButtonCell.self,
            forCellWithReuseIdentifier: TCABasicButtonCell.reuseIdentifier
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
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let columns = (layoutEnviroment.container.contentSize.width / 120).rounded(.down)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: Int(columns))
            group.interItemSpacing = .fixed(.interItemSpacing)
            let section = NSCollectionLayoutSection(group: group)

            section.interGroupSpacing = .interItemSpacing
            section.contentInsets = .init(top: .screenEdgeSpacing, leading: .screenEdgeSpacing, bottom: 0, trailing: .screenEdgeSpacing)
            //section.addHeader()
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .screenEdgeSpacing
        layout.configuration = config

        return layout
        
    }
    
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gradeSystem.values.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TCABasicButtonCell.reuseIdentifier,
            for: indexPath) as! TCABasicButtonCell
        
        cell.basicButton.title = gradeSystem.values[indexPath.row]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TCASectionHeader.reuseIdentifier,
                for: indexPath) as! TCASectionHeader
            
            sectionHeader.buttonTitle = gradeSystem.name
            sectionHeader.delegate = self
            
            //sectionHeader.configure(auxiliaryButtonTitle: gradeSystem.name, auxiliaryButtonIcon: UIImage(systemName: "chevron.left"))
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        delegate?.gradeSelector(self, didSelectGrade: indexPath.row, fromGradeSystem: gradeSystem)
        
        selectItem(at: indexPath)
        
        dismiss(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    // MARK: Cell Selection
    private func highlightInitialSelection() {
        let row = dataSource?.initialSelectedGrade(in: self) ?? 0
        selectItem(at: IndexPath(row: row, section: 0))
    }
    
    private func selectItem(at indexPath: IndexPath) {
        
        collectionView.indexPathsForSelectedItems?.forEach({
            if $0 != indexPath {
                collectionView.deselectItem(at: $0, animated: false)
            }
        })
        
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    

    // MARK: GradeSystemSelectorController Delegate & Datasource
    func gradeSystemSelector(_ gradeSystemSelector: GradeSystemSelectorController, didSelectGradeSystem gradeSystem: GradeSystem) {
        self.gradeSystem = gradeSystem
        collectionView.reloadData()
    }
    
    func initialSelectedGradeSystem(in gradeSystemSelector: GradeSystemSelectorController) -> GradeSystem {
        return gradeSystem
    }
    
    // MARK: SectionHeaderReusableViewDelegate {
    func auxiliaryButtonPressed(in sectionHeader: TCASectionHeader) {
        let gradeSystemSelector = GradeSystemSelectorController()
        gradeSystemSelector.delegate = self
        gradeSystemSelector.dataSource = self
        let controller = UINavigationController(rootViewController: gradeSystemSelector)
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.sourceView = sectionHeader
        present(controller, animated: true)
    }
    
}

