//
//  GithubUsersNavigation.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol GithubUsersNavigatorProtocol {
    
    func gotoUserDetail(loginUsername: String)
    func backToHome()
    
}

class GithubUsersNavigator: BaseNavigator,
                            GithubUsersNavigatorProtocol {
    
    func gotoUserDetail(loginUsername: String) {
        let userDetailvc: UserDetailViewController = DefaultAssembler.shared.createModule(loginUsername: loginUsername)
        vc?.navigationController?.pushViewController(userDetailvc, animated: true)
    }
    
    func backToHome() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
}
