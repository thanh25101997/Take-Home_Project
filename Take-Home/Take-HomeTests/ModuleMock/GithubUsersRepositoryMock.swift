//
//  GithubUsersRepositoryMock.swift
//  Take-Home
//
//  Created by Van Thanh on 18/5/25.
//

import Foundation
import RxSwift
@testable import Take_Home

class GithubUsersRepositoryMock: GithubUsersRepositoryProtocol {
    
    var fetchUsersLocalOutput = [User]()
    var fetchUsersLocalCalled = false
    func fetchUsersLocal() -> Observable<[User]> {
        fetchUsersLocalCalled = true
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(self.fetchUsersLocalOutput)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    var saveUsersStogateArg: [User]?
    func saveUsersStogate(users: [User]) {
        saveUsersStogateArg = users
    }
    
    var getUserFromServerArg: (Int, Int)?
    var getUserFromServerOutput = [User]()
    func getUserFromServer(page: Int,
                           since: Int) -> Observable<[User]> {
        getUserFromServerArg = (page, since)
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(self.getUserFromServerOutput)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
