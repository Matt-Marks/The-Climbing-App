//
//  TCAStatisticsController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCAStatisticsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    private var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Statistics"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
    }
    
    /// Creates and configures the collection view that spans the entire screen.
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.register(
            TCAStatisticsProblemsCell.self,
            forCellWithReuseIdentifier: TCAStatisticsProblemsCell.reuseIdentifier
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
        collectionView.backgroundColor = .systemGroupedBackground
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
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            if layoutEnviroment.traitCollection.horizontalSizeClass == .compact {
                section = .vertical(header: false, itemHeight: .absolute(400))
            } else {
                    
                #warning("TODO: Make this dynamic with fractionwidth?")
                let leftGroupWidth = 0.6 * (layoutEnviroment.container.contentSize.width - (2 * .screenEdgeSpacing) - .interGroupSpacing)
                let rightGroupWidth = 0.4 * (layoutEnviroment.container.contentSize.width - (2 * .screenEdgeSpacing) - .interGroupSpacing)

                let leftItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
                let leftItem = NSCollectionLayoutItem(layoutSize: leftItemSize)
                let leftGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(leftGroupWidth), heightDimension: .fractionalHeight(1.0))
                let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupSize, subitem: leftItem, count: 2)
                leftGroup.interItemSpacing = .fixed(.interItemSpacing)

                let rightItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
                let rightItem = NSCollectionLayoutItem(layoutSize: rightItemSize)
                let rightGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(rightGroupWidth), heightDimension: .fractionalHeight(1.0))
                let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, subitem: rightItem, count: 5)
                rightGroup.interItemSpacing = .fixed(.interItemSpacing)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(800))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leftGroup, rightGroup])
                group.interItemSpacing = .fixed(.interItemSpacing)

                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = .interGroupSpacing
                section.contentInsets = .init(top: .zero, leading: .screenEdgeSpacing, bottom: .zero, trailing: .screenEdgeSpacing)

            }
            
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .interSectionSpacing
        layout.configuration = config
        
        return layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCAStatisticsProblemsCell.reuseIdentifier, for: indexPath) as! TCAStatisticsProblemsCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TCASectionHeader.reuseIdentifier,
                for: indexPath) as! TCASectionHeader
            
            
            sectionHeader.title = "Sessions"
            
            
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }


    
}

