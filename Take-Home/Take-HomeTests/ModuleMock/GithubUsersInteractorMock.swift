//
//  GithubUsersInteractorMOck.swift
//  Take-Home
//
//  Created by Van Thanh on 19/5/25.
//

import Foundation
import RxSwift
@testable import Take_Home

class GithubUsersInteractorMock: GithubUsersInteractorProtocol {
    
    var isFirstLaunchResult = false
    func isFirstLaunch() -> Bool {
        return isFirstLaunchResult
    }
    
    var saveFirstLaunchCalled = false
    func saveFirstLaunch() {
        saveFirstLaunchCalled = true
    }
    
    var getUsersStogateResult = [User]()
    var getUsersStogateCalled = false
    func getUsersStogate() -> Observable<[User]> {
        getUsersStogateCalled = true
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(self.getUsersStogateResult)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    var saveUsersStogateArg: [User]?
    func saveUsersStogate(users: [User]) {
        saveUsersStogateArg = users
    }
    
    var getUsersArg: (Int, Int, [User])?
    var getUsersResult: [User] = []
    func getUsers(page: Int,
                  since: Int,
                  currentUsers: [User]) -> Observable<[User]> {
        getUsersArg = (page, since, currentUsers)
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(self.getUsersResult)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
