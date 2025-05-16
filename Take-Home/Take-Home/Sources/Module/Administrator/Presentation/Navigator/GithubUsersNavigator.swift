//
//  GithubUsersNavigation.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol GithubUsersNavigatorProtocol {
    
    func gotoUserDetail(id: Int)
    func backToHome()
    
}

class GithubUsersNavigator: BaseNavigator,
                            GithubUsersNavigatorProtocol {
    
    func gotoUserDetail(id: Int) {
        vc?
            .navigationController?
            .pushViewController(GithubUsersViewController(),
                                animated: true)
    }
    
    func backToHome() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
}
