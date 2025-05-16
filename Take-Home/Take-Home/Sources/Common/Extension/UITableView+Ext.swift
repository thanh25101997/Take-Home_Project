//
//  UITableView+Ext.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import UIKit

extension UITableView {
    
    func registerCell(for id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }
    
}
