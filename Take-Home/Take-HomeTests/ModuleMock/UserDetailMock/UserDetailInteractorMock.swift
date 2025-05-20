//
//  UserDetail.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//


import Foundation
import RxSwift
@testable import Take_Home


class UserDetailInteractorMock: UserDetailInteractorProtocol {
    
    var getUserArg: String?
    var getUserResult: UserDetailsEntity?
    func getUser(loginUserName: String) -> Observable<UserDetailsEntity> {
        getUserArg = loginUserName
        return Observable<UserDetailsEntity>.create { observer -> Disposable in
            if let obj = self.getUserResult {
                observer.onNext(obj)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
