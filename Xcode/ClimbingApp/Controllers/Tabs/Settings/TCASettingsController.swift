//
//  TCASettingsController.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/24/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import UIKit

class TCASettingsController: UITableViewController{
        
    enum Section: Int, CaseIterable {
        case General, Appearance, Other
        
        var title: String {
            switch self {
            case .General: return "General"
            case .Appearance: return "Apparance"
            case .Other: return "Other"
            }
        }
        
        var numRows: Int {
            switch self {
            case .General: return 1
            case .Appearance: return 3
            case .Other: return 2
            }
        }
    }
    
    struct Constants {
            
        // Cells
        static let general = IndexPath(row: 0, section: Section.General.rawValue)
        static let icon    = IndexPath(row: 0, section: Section.Appearance.rawValue)
        static let color   = IndexPath(row: 1, section: Section.Appearance.rawValue)
        static let theme   = IndexPath(row: 2, section: Section.Appearance.rawValue)
        static let contact = IndexPath(row: 0, section: Section.Other.rawValue)
        static let tipJar  = IndexPath(row: 1, section: Section.Other.rawValue)
        
        static let cellTitles: [IndexPath : String] = [
            general : "General",
            icon : "Icon",
            color : "Color",
            theme : "Theme",
            contact : "Contact",
            tipJar : "Tip Jar",
        ]
        
    }

    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelection), name: .TraitCollectionDidChange, object: nil)
        updateSelection()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section)!.numRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Constants.cellTitles[indexPath]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case Constants.general:
            let vc = UINavigationController(rootViewController: TCASettingsGeneralController())
            showDetailViewController(vc, sender: self)
        case Constants.icon:
            let vc = UINavigationController(rootViewController: TCASettingsIconController())
            showDetailViewController(vc, sender: self)
        case Constants.color:
            let vc = UINavigationController(rootViewController: TCASettingsColorController())
            showDetailViewController(vc, sender: self)
        case Constants.theme:
            let vc = UINavigationController(rootViewController: TCASettingsThemeController())
            showDetailViewController(vc, sender: self)
        case Constants.contact:
            let vc = UINavigationController(rootViewController: TCASettingsContactController())
            showDetailViewController(vc, sender: self)
        case Constants.tipJar:
            let vc = UINavigationController(rootViewController: TCASettingsTipJarController())
            showDetailViewController(vc, sender: self)
        default: ()
            
        }
    }
    
    
    // MARK: Helpers & Utilities
    @objc
    private func updateSelection() {

        deselectAll(animated: false)
        
        clearsSelectionOnViewWillAppear = splitViewController?.isCollapsed ?? true
        
        
        if splitViewController?.isCollapsed == false {
            
            if let detailNavController = splitViewController?.viewControllers.last as? UINavigationController{
                
                if detailNavController.viewControllers.first is TCASettingsGeneralController {
                    tableView.selectRow(at: Constants.general, animated: false, scrollPosition: .none)
                }
                if detailNavController.viewControllers.first is TCASettingsIconController {
                    tableView.selectRow(at: Constants.icon, animated: false, scrollPosition: .none)
                }
                if detailNavController.viewControllers.first is TCASettingsColorController {
                    tableView.selectRow(at: Constants.color, animated: false, scrollPosition: .none)
                }
                if detailNavController.viewControllers.first is TCASettingsThemeController {
                    tableView.selectRow(at: Constants.theme, animated: false, scrollPosition: .none)
                }
                if detailNavController.viewControllers.first is TCASettingsContactController {
                    tableView.selectRow(at: Constants.contact, animated: false, scrollPosition: .none)
                }
                if detailNavController.viewControllers.first is TCASettingsTipJarController {
                    tableView.selectRow(at: Constants.tipJar, animated: false, scrollPosition: .none)
                }
            }
            
        }
        
    }

}
