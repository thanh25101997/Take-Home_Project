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
    
    private var realmDatabase: RealmManagerProtocol
    private var apiClient: ApiClientProtocol
    
    init(realmDatabase: RealmManagerProtocol = RealmManager.shared,
         apiClient: ApiClientProtocol = APIClient.shared) {
        self.realmDatabase = realmDatabase
        self.apiClient = apiClient
    }
    
    func fetchUsersLocal() -> Observable<[User]> {
        return Observable<[User]>.create { observer -> Disposable in
            observer.onNext(self.realmDatabase.fetchUsers())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func saveUsersStogate(users: [User]) {
        realmDatabase.saveUsers(users)
    }
    
    func getUserFromServer(page: Int,
                           since: Int) -> Observable<[User]> {
        
        let observable: Observable<[User]> = apiClient
            .request(endPoint: APIRouter.fetchUsers(per_page: 20,
                                                    since: page * 20))
        return observable
    }
    
}
