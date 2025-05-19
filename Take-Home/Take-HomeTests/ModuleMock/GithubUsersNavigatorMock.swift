//
//  GithubUsersNavigatorMock.swift
//  Take-Home
//
//  Created by Van Thanh on 19/5/25.
//


import Foundation
@testable import Take_Home

class GithubUsersNavigatorMock: GithubUsersNavigatorProtocol {
    
    var gotoUserDetailArg: String?
    func gotoUserDetail(loginUsername: String) {
        gotoUserDetailArg = loginUsername
    }
    var backToHomeCalled = false
    func backToHome() {
        backToHomeCalled = true
    }
    
    
}
