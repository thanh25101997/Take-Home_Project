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
        return Observable<[User]>.create { observer -> Disposable in
            let url = "https://api.github.com/users"
            let parameters: Parameters = [
                "per_page": 20,
                "since": page * 20
            ]
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [User].self) { response in
                    switch response.result {
                    case .success(let users):
                        observer.onNext(users)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
