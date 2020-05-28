//
//  UITableViewController+Extension.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/25/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func deselectAll(animated: Bool) {
        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
}
