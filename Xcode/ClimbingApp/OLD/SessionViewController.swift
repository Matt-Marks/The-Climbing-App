//
//  SessionViewController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 4/26/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit


class SessionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SessionFooerReustableViewDelegate {

    // MARK: Constants & Variables
    private var session: TCASession
    private var collectionView: UICollectionView!
    
    struct Constants {
        static let sectionIndexClimbs: Int    = 0
        static let sectionIndexSummary: Int   = 1
        static let climbCellWidth: CGFloat    = 115
        static let climbCellHeight: CGFloat   = 160
        static let summaryCellHeight: CGFloat = 160
        static let numberOfSections: Int      = 2
    }
    
    // MARK: Initialization
    init(session: TCASession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureCollectionView()
    }
    

    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout() )
        
        // Used for cimbs.
        collectionView.register(TCACardCell.self, forCellWithReuseIdentifier: TCACardCell.reuseIdentifier)
        
        collectionView.register(AttemptCell.self, forCellWithReuseIdentifier: AttemptCell.reuseIdentifier)
        
        // Used for section headers.
        collectionView.register(TCASectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TCASectionHeader.reuseIdentifier)
        
        // Used for finish and cancel buttons.
        collectionView.register(SessionFooterReustableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SessionFooterReustableView.reuseIdentifier)
        
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
    
    // MARK: UICollectrionView Layouts
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection!
            
            switch sectionIndex {
            case Constants.sectionIndexClimbs:
                section = .horizontal(itemWidth: .absolute(Constants.climbCellWidth), sectionHeight: .absolute(Constants.climbCellHeight))
            case Constants.sectionIndexSummary:
                section = .vertical(itemHeight: .absolute(60))
                
                // Footer with finish and cancel buttons.
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Constants.sectionIndexClimbs: return  1 //max(session.numAscents(), 1)
        case Constants.sectionIndexSummary: return 9
        default: fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Constants.sectionIndexClimbs:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCACardCell.reuseIdentifier, for: indexPath) as! TCACardCell
            
            cell.icon = UIImage(named: "bouldering.circle")
            cell.unselectedIconTintColor = .systemPurple
            cell.unselectedPretitleTextColor = .systemPurple
            cell.pretitle = "Turbo"
            cell.title = "V1"
            
            return cell
        case Constants.sectionIndexSummary:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttemptCell.reuseIdentifier, for: indexPath) as! AttemptCell
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
            case Constants.sectionIndexClimbs:
                sectionHeader.title = "Problems"
                sectionHeader.subtitle = "Tap to attempt, hold to complete."
            case Constants.sectionIndexSummary:
                sectionHeader.title = "This Session"
            default: fatalError()
            }
            
            
            return sectionHeader
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SessionFooterReustableView.reuseIdentifier,
                for: indexPath) as! SessionFooterReustableView
            sectionFooter.delegate = self
            return sectionFooter
        }
        
        fatalError()
    }
    
    // MARK: SessionFooerReustableViewDelegate
    fileprivate func finishButtonPressed(_ sessionFooter: SessionFooterReustableView) {
        
    }
    
    fileprivate func cancelButtonPressed(_ sessionFooter: SessionFooterReustableView) {
        
    }
}



fileprivate class AttemptCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "AttemptCell"
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: .dividerHeight)
        ])
        
        
        let pretitleLabel = UILabel()
        pretitleLabel.font = UIFont.roundedFont(forTextStyle: .caption1).bold()
        pretitleLabel.text = "TURBO"
        pretitleLabel.textColor = .systemGreen
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.roundedFont(forTextStyle: .title2).bold()
        titleLabel.text = "V1"
        
        let stack = UIStackView(arrangedSubviews: [pretitleLabel, titleLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







// ********************************************************************** //
// MARK: - SessionFooerReustableViewDelegate
// ********************************************************************** //
fileprivate protocol SessionFooerReustableViewDelegate {
    func finishButtonPressed(_ sessionFooter: SessionFooterReustableView)
    func cancelButtonPressed(_ sessionFooter: SessionFooterReustableView)
}

// ********************************************************************** //
// MARK: - SessionFooerReustableView
// ********************************************************************** //
fileprivate class SessionFooterReustableView: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: ReuseIdentifiable Protocol
    static let reuseIdentifier: String = "SetupSessionFooterReuseableView"
    
    public var delegate: SessionFooerReustableViewDelegate?
    
    // MARK: Constants & Variables
    private let finishButton = TCAButton()
    private let cancelButton = TCAButton()
    private let separator = UIView()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        addSubview(finishButton)
        addSubview(cancelButton)
        
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.leftAnchor.constraint(equalTo: leftAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: .dividerHeight)
        ])
        
        finishButton.title = "Finish"
        //finishButton.unselectedBackgoundColor = .accent
        //finishButton.unselectedTitleTextColor = .white
        finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: topAnchor, constant: .screenEdgeSpacing),
            finishButton.leftAnchor.constraint(equalTo: leftAnchor),
            finishButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        cancelButton.title = "Cancel"
        //cancelButton.unselectedBackgoundColor = .cellBackgound
        //cancelButton.unselectedTitleTextColor = .systemGray
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: finishButton.bottomAnchor, constant: .interItemSpacing),
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor),
            cancelButton.rightAnchor.constraint(equalTo: rightAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc
    private func finishButtonPressed() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
        delegate?.finishButtonPressed(self)
    }
    
    @objc
    private func cancelButtonPressed() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
        delegate?.cancelButtonPressed(self)
    }
}
