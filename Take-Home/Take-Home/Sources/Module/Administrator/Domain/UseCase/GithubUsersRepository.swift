//
//  GithubUsersRepository.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol GithubUsersRepositoryProtocol {
    
    func fetchUsersLocal() -> Observable<[User]>
    func saveUsersStogate(users: [User])
    func getUserFromServer(page: Int,
                           since: Int) -> Observable<[User]>
}

class GithubUsersRepository: GithubUsersRepositoryProtocol {
    
    func fetchUsersLocal() -> Observable<[User]> {
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(ReamlManager.shared.fetchUsers())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func saveUsersStogate(users: [User]) {
        do {
            try users.forEach { i in
                try ReamlManager.shared.saveData(i.toEntity())
            }
        } catch {
            print(error)
        }
    }
    
    func getUserFromServer(page: Int,
                           since: Int) -> Observable<[User]> {
        
        let observable: Observable<[User]> = APIClient
            .shared
            .request(endPoint: APIRouter.fetchUsers(per_page: 20,
                                                    since: page * 20))
        return observable
    }
    
}
