//
//  BaseNavigator.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import UIKit

class BaseNavigator {
    
    weak var vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
}
