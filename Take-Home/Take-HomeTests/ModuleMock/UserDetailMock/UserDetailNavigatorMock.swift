//
//  UserDetailNavigatorMock.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import Foundation
@testable import Take_Home

class UserDetailNavigatorMock: UserDetailNavigatorProtocol {
    
    var backToHomeCalled = false
    func backToHome() {
        backToHomeCalled = true
    }
    
}
