//
//  UserDetailRepositoryMock.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import Foundation
import RxSwift
@testable import Take_Home

struct CommonError: Error {}

class UserDetailRepositoryMock: UserDetailRepositoryProtocol {
    
    var getUserFromServerArg: String?
    var userDetailsEntity: UserDetailsEntity?
    func getUserFromServer(loginUserName: String) -> Observable<UserDetailsEntity> {
        getUserFromServerArg = loginUserName
        return Observable<UserDetailsEntity>.create { observer -> Disposable in
            if let userDetailsEntity = self.userDetailsEntity {
                observer.onNext(userDetailsEntity)
            } else {
                observer.onError(CommonError())
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    
}
