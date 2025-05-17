//
//  UserDefaultManager.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import Foundation

final class UserDefaultService {
    
    static let shared = UserDefaultService()
    
    private init() {}
    
    private let hasLaunchedKey = "hasLaunchedBefore"
    
    func isFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: hasLaunchedKey)
    }
    
    func setFirstFirstLaunch(value: Bool = true) {
        UserDefaults.standard.set(value, forKey: hasLaunchedKey)
        UserDefaults.standard.synchronize()
    }
    
}
