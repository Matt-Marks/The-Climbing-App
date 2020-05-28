//
//  TCALocationController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/18/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit
import MapKit

class TCALocationController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TCASectionHeaderDelegate {
    
    
    let fakeClimbs = [
        TCAClimb(grade: 1, gradeSystem: .Hueco, name: "Turbo", color: .purple, climbID: 0),
        TCAClimb(grade: 3, gradeSystem: .Hueco, name: "Turbo Adventure", color: .blue, climbID: 1),
        TCAClimb(grade: 6, gradeSystem: .Hueco, name: "Turbo Traverse", color: .pink, climbID: 2),
        TCAClimb(grade: 7, gradeSystem: .Hueco, name: "Not Done", color: .yellow, climbID: 3),
        TCAClimb(grade: 10, gradeSystem: .Hueco, name: "Done It", color: .purple, climbID: 4),
        TCAClimb(grade: 7, gradeSystem: .Hueco, name: "Washed Up", color: .green, climbID: 5),
        TCAClimb(grade: 11, gradeSystem: .Hueco, name: "Washed Out", color: .red, climbID: 6),
        TCAClimb(grade: 10, gradeSystem: .Hueco, name: "Washed Ashore", color: .blue, climbID: 7),
        TCAClimb(grade: 6, gradeSystem: .Hueco, name: "Oba! Oba! Oba!", color: .blue, climbID: 8),
    ]
    
    
    enum Sections: Int, CaseIterable {
        case about, breakdown, distribution, routes, problems
    }
    
    struct Constants {
        static let mapHeight: CGFloat = 200
        static let aboutCellHeight: CGFloat = 80
    }
    
    
    let location: TCALocation
    
    private var navBar: TCANavigationBar!
    
    private var bannerImageView = UIImageView()
    private var enviromentTitleLabel = UILabel()
    private var nameTitleLabel = UILabel()
    private var titleStack = UIStackView()
    private var ellipsisButton = UIButton()
    private var collectionView: UICollectionView!
    
    init(location: TCALocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        configureCollectionView()
    }
    

    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    }

    
//    private func configureBannerImageView() {
//        bannerImageView.image = UIImage(named: "et.columbia")
//        bannerImageView.clipsToBounds = true
//        bannerImageView.contentMode = .scaleAspectFill
//        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(bannerImageView)
//        NSLayoutConstraint.activate([
//            bannerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            bannerImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            bannerImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            bannerImageView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//    }
    
//    private func configureTitleBar() {
//        enviromentTitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
//        enviromentTitleLabel.textColor = .secondaryLabel
//        enviromentTitleLabel.text = "INDOORS"
//
//        nameTitleLabel.font = UIFont.roundedFont(forTextStyle: .title2).bold()
//        nameTitleLabel.textColor = .label
//        nameTitleLabel.text = "Earth Treks (Columbia)"
//
//        titleStack.addArrangedSubview(enviromentTitleLabel)
//        titleStack.addArrangedSubview(nameTitleLabel)
//        titleStack.axis = .vertical
//        titleStack.translatesAutoresizingMaskIntoConstraints = false
//        titleStack.layoutMargins = .init(top: .screenEdgeSpacing, left: .screenEdgeSpacing, bottom: .screenEdgeSpacing, right: .screenEdgeSpacing)
//        titleStack.insetsLayoutMarginsFromSafeArea = false
//        titleStack.isLayoutMarginsRelativeArrangement = true
//        scrollView.addSubview(titleStack)
//        NSLayoutConstraint.activate([
//            titleStack.leftAnchor.constraint(equalTo: bannerImageView.leftAnchor),
//            titleStack.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor)
//        ])
//
//
//        ellipsisButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
//        ellipsisButton.backgroundColor = .cellBackgound
//        ellipsisButton.layer.cornerRadius = 15
//        ellipsisButton.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(ellipsisButton)
//        NSLayoutConstraint.activate([
//            ellipsisButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: .screenEdgeSpacing),
//            ellipsisButton.rightAnchor.constraint(equalTo: bannerImageView.rightAnchor, constant: -.screenEdgeSpacing),
//            ellipsisButton.widthAnchor.constraint(equalToConstant: 30),
//            ellipsisButton.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//    }

    // MARK: UICollectionView Members
    
    /// Creates and configures the collection view that spans the entire screen.
    private func configureCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
                
        collectionView.register(
            DistributionCell.self,
            forCellWithReuseIdentifier: DistributionCell.reuseIdentifier
        )
        
        collectionView.register(
            TCABannerCell.self,
            forCellWithReuseIdentifier: TCABannerCell.reuseIdentifier
        )

        collectionView.register(
            AboutCell.self,
            forCellWithReuseIdentifier: AboutCell.reuseIdentifier
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
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    /// Creates a UICollectionViewLayout for the collection view. This layout
    /// has three sections, one for sessions, locations, and statistics.
    ///
    /// - Returns:
    ///     - A UICollectionVewLayout for this collection view.
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            switch Sections(rawValue: sectionIndex)! {
            case Sections.about:
                
//                if layoutEnviroment.traitCollection.horizontalSizeClass == .regular {
//                    let mapItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
//                    let mapItem = NSCollectionLayoutItem(layoutSize: mapItemSize)
//                    let mapGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(Constants.mapHeight))
//                    let mapGroup = NSCollectionLayoutGroup.vertical(layoutSize: mapGroupSize, subitem: mapItem, count: 1)
//
//                    let aboutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                    let aboutItem = NSCollectionLayoutItem(layoutSize: aboutItemSize)
//                    let aboutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
//                    let aboutGroup = NSCollectionLayoutGroup.vertical(layoutSize: aboutGroupSize, subitem: aboutItem, count: 10)
//
//                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(Constants.aboutCellHeight * 12))
//                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [mapGroup, aboutGroup])
//
//                    section = NSCollectionLayoutSection(group: group)
//                } else {
//                    let mapItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                    let mapItem = NSCollectionLayoutItem(layoutSize: mapItemSize)
//                    let mapGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
//                    let mapGroup = NSCollectionLayoutGroup.vertical(layoutSize: mapGroupSize, subitem: mapItem, count: 1)
//
//                    let aboutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                    let aboutItem = NSCollectionLayoutItem(layoutSize: aboutItemSize)
//                    let aboutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
//                    let aboutGroup = NSCollectionLayoutGroup.vertical(layoutSize: aboutGroupSize, subitems: [aboutItem])
//
//                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
//                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [mapGroup, aboutGroup])
//
//                    section = NSCollectionLayoutSection(group: group)
//
//                }
//
                section = .vertical(header: false, itemHeight: .absolute(70))

            case Sections.breakdown:
                section = .vertical(itemHeight: .absolute(100))
            case Sections.distribution:
                section = .vertical(itemHeight: .absolute(100))
            case Sections.routes:
                section = .vertical(itemHeight: .absolute(100))
            case Sections.problems:
                section = .vertical(columns: 5, header: true, itemHeight: .absolute(160))
                
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
        

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Sections(rawValue: section)! {
        case Sections.about: return 4
        case Sections.breakdown: return 1
        case Sections.distribution: return 1
        case Sections.routes: return 1
        case Sections.problems: return fakeClimbs.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch Sections(rawValue: indexPath.section)! {
        case Sections.about:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCell.reuseIdentifier, for: indexPath) as! AboutCell
            
            switch indexPath.row {
            case 0:
                cell.title = "Address"
                cell.content = "7215 Columbia Gateway Drive, Suite 110, Columbia, MD 21046"
            case 1:
                cell.title = "Phone"
                cell.content = "410-872-0060"
            case 2:
                cell.title = "Problems"
                cell.content = "7215 Columbia Gateway Drive, Suite 110, Columbia, MD 21046"
            case 3:
                cell.title = "Routes"
                cell.content = "7215 Columbia Gateway Drive, Suite 110, Columbia, MD 21046"
            default: ()
            }
            
            
            return cell
            
        case Sections.breakdown:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCABannerCell.reuseIdentifier, for: indexPath) as! TCABannerCell
            cell.title = "Nothing Here"
            cell.message = "Nothing to see here"
            cell.displayStyle = .grayscale
            return cell
        case Sections.distribution:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DistributionCell.reuseIdentifier, for: indexPath) as! DistributionCell
            return cell
        case Sections.routes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCABannerCell.reuseIdentifier, for: indexPath) as! TCABannerCell
            cell.title = "Nothing Here"
            cell.message = "Nothing to see here"
            cell.displayStyle = .grayscale
            return cell
        case Sections.problems:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCACardCell.reuseIdentifier, for: indexPath) as! TCACardCell
            cell.icon = UIImage(named: "discipline.top.roping")
            cell.pretitle = fakeClimbs[indexPath.row].name
            cell.title = fakeClimbs[indexPath.row].gradeSystem.values[fakeClimbs[indexPath.row].grade]
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
            
            
            
            switch Sections(rawValue: indexPath.section)! {
            case Sections.about:
                sectionHeader.title = "About"
            case Sections.breakdown:
                sectionHeader.title = "Breakdown"
            case Sections.distribution:
                sectionHeader.title = "Distribution"
            case Sections.routes:
                sectionHeader.title = "Routes"
            case Sections.problems:
                sectionHeader.title = "Climbs"
                
            }
            
            return sectionHeader
            
            
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: TCASectionHeaderDelegate
    func auxiliaryButtonPressed(in sectionHeader: TCASectionHeader) {

    }
}



class AboutCell: UICollectionViewCell, ReuseIdentifiable {
    
    static var reuseIdentifier: String = "AboutCell"
    
    public var title: String? {
        didSet {
            titleLabel.text = title?.uppercased()
        }
    }
    
    public var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "ADDRESS"
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = UIFont.roundedFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true

        contentLabel.text = "7215 Columbia Gateway Drive, Suite 110, Columbia, MD 21046"
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.roundedFont(forTextStyle: .body)
        contentLabel.adjustsFontForContentSizeCategory = true

        let stack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



class DistributionCell: UICollectionViewCell, ReuseIdentifiable {
    
    static var reuseIdentifier: String = "DistributionCell"
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.text = "208 PROBLEMS"
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = UIFont.roundedFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        let chart = BarChartView()
        chart.setVerticalSpacing(0.0)
        chart.setHorizontalSpacing(2.0)
        chart.addBottomAxisLine(leftLabel: "V1", rightLabel: "V11")
        chart.setData(data: [7,6,10,9,8,9,8,6,5,4,3,4,5,4,3,3,2,1,1,1])
        chart.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chart)
        NSLayoutConstraint.activate([
            chart.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            chart.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            chart.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            chart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

