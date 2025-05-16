//
//  GithubUsersAssembler.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol GithubUsersAssembler {
    func createModule() -> GithubUsersViewController
}

extension GithubUsersAssembler {
    
    func createModule() -> GithubUsersViewController {
        let vc = GithubUsersViewController()
        let vm = GithubUsersViewModel(navigator: GithubUsersNavigator(vc: vc),
                                      interactor: GithubUsersInteractor())
        vc.viewModel = vm
        return vc
    }
    
}
