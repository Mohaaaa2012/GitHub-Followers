//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Apple on 9/29/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
