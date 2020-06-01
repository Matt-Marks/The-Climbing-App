//
//  TCALocationsController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit
import Contacts

class TCALocationsController: UITableViewController {
    
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController()
        searchController.searchBar.scopeButtonTitles = ["Indoors", "Outdoors"]
        navigationItem.searchController = searchController
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 100
        
        let addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)), for: .normal)
        addButton.backgroundColor = UIColor.accent.withAlphaComponent(0.2)
        addButton.frame.size = CGSize(width: 26, height: 26)
        addButton.layer.cornerRadius = 13
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TCAUserData.locations.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LocationCell()
        let locationIDs = Array(TCAUserData.locations.keys)
        cell.configure(withLocation: locationIDs[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    
}

fileprivate class LocationCell: UITableViewCell {
    
    public func configure(withLocation locationID: LocationID) {
        //guard let location = TCAUserData.locations[locationID] else { return }
    }
    
    // MARK: Options
    
    /// The enviroment is shown in a small label above the name.
    public var enviroment: Enviroment = .indoors {
        didSet {
            enviromentLabel.text = enviroment.name.uppercased()
        }
    }
    
    /// The name of the location. Appears in the top left corner.
    public var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    /// The number of climbs displayed in the bottom right corner.
    public var numberOfClimbs: Int = 0 {
        didSet {
            climbsLabel.text = "\(numberOfClimbs.description) Climbs"
        }
    }
    
    /// The background image for the location.
    public var backgroundImage: UIImage? {
        didSet {
            backgroundImageView.image = backgroundImage
        }
    }
    
    // MARK: Cell Properties
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? animateShrink() : animateGrow()
        }
    }
    
    // MARK: UIElement Declarations
    
    /// The enviroment is shown in the small label above the name.
    private var enviromentLabel = UILabel()
    
    /// The name appears in the top left corner.
    private var nameLabel = UILabel()
    
    /// The image that appears in the background.
    private var backgroundImageView = UIImageView()
    
    /// The label that appears in the bottom right corner showing climb number.
    private var climbsLabel = UILabel()
    
    /// The stack view holding enviroment and name labels.
    private var titleStack = UIStackView()
    
    private var numRoutesLabel = UILabel()
    private var routesLabel = UILabel()
    private var numProblemsLabel = UILabel()
    private var problemsLabel = UILabel()
    private var routesStack = UIStackView()
    private var problemsStack = UIStackView()
    private var statsStack = UIStackView()
    
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "et.columbia")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .cellEdgeSpacing),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .cellEdgeSpacing),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // Setup title stack.
        titleStack.alignment = .leading
        titleStack.axis = .vertical
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleStack)
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .cellEdgeSpacing),
            titleStack.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: .cellEdgeSpacing),
            titleStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -.cellEdgeSpacing),
            titleStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.cellEdgeSpacing)
        ])
        
        // Setup enviroment label.
        enviromentLabel.textColor = .secondaryLabel
        enviromentLabel.font = UIFont.roundedFont(forTextStyle: .caption2).bold()
        enviromentLabel.adjustsFontForContentSizeCategory = true
        titleStack.addArrangedSubview(enviromentLabel)
        
        // Setup name label.
        nameLabel.font = UIFont.roundedFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        titleStack.addArrangedSubview(nameLabel)
        
        
        
        numRoutesLabel.text = "208"
        numRoutesLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .light)
        numRoutesLabel.textColor = .secondaryLabel
        
        routesLabel.text = "ROUTES"
        routesLabel.font = UIFont.roundedFont(forTextStyle: .caption2)
        routesLabel.textColor = .secondaryLabel
        
        
        numProblemsLabel.text = "155"
        numProblemsLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .light)
        numProblemsLabel.textColor = .secondaryLabel
        
        problemsLabel.text = "PROBLEMS"
        problemsLabel.font = UIFont.roundedFont(forTextStyle: .caption2)
        problemsLabel.textColor = .secondaryLabel
        
        routesStack.addArrangedSubview(numRoutesLabel)
        routesStack.addArrangedSubview(routesLabel)
        routesStack.axis = .vertical
        
        problemsStack.addArrangedSubview(numProblemsLabel)
        problemsStack.addArrangedSubview(problemsLabel)
        problemsStack.axis = .vertical
        
        statsStack.spacing = .cellEdgeSpacing
        statsStack.addArrangedSubview(routesStack)
        statsStack.addArrangedSubview(problemsStack)
        statsStack.axis = .horizontal
        
        titleStack.addArrangedSubview(statsStack)
        titleStack.setCustomSpacing(.cellEdgeSpacing, after: nameLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
