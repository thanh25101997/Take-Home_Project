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
    
    func isFirstLaunch() -> Bool {
        !UserDefaults.standard.bool(forKey: UserDefaultConst.hasOpenedAppOnce)
    }
    
    func setFirstLaunch(value: Bool = true) {
        UserDefaults.standard.set(value, forKey: UserDefaultConst.hasOpenedAppOnce)
        UserDefaults.standard.synchronize()
    }
    
}
