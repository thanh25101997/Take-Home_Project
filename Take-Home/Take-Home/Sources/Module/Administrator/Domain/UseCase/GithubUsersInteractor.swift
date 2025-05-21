//
//  GithubUsersInteractor.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

protocol GithubUsersInteractorProtocol {
    
    func isFirstLaunch() -> Bool
    func saveFirstLaunch()
    func getUsersStogate() -> Observable<[User]>
    func saveUsersStogate(users: [User])
    func getUsers(page: Int,
                  since: Int,
                  currentUsers: [User]) -> Observable<[User]>
    
}

class GithubUsersInteractor: GithubUsersInteractorProtocol {
    
    var githubUsersRepository: GithubUsersRepositoryProtocol
    
    init(githubUsersRepository: GithubUsersRepositoryProtocol) {
        self.githubUsersRepository = githubUsersRepository
    }
    
    func isFirstLaunch() -> Bool {
        UserDefaultService.shared.isFirstLaunch()
    }
    
    func saveFirstLaunch() {
        UserDefaultService.shared.setFirstLaunch(value: true)
    }
    
    func getUsersStogate() -> Observable<[User]> {
        return githubUsersRepository.fetchUsersLocal()
    }
    
    func saveUsersStogate(users: [User]) {
        githubUsersRepository.saveUsersStogate(users: users)
    }
    
    func getUsers(page: Int,
                  since: Int,
                  currentUsers: [User]) -> Observable<[User]> {
        githubUsersRepository.getUserFromServer(page: page,
                                                since: since)
        .map { users in
            return currentUsers + users
        }
    }
    
}
