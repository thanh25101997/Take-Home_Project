//
//  GithubUsersAssembler.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol GithubUsersAssembler where Self: DefaultAssembler {
    func createModule() -> GithubUsersViewController
}

extension GithubUsersAssembler where Self: DefaultAssembler {
    
    func createModule() -> GithubUsersViewController {
        let vc = GithubUsersViewController()
        let repo = GithubUsersRepository()
        let interacter = GithubUsersInteractor(githubUsersRepository: repo)
        let vm = GithubUsersViewModel(navigator: GithubUsersNavigator(vc: vc),
                                      interactor: interacter)
        vc.viewModel = vm
        return vc
    }
    
}
