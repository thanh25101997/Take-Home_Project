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
    
    func getUser(page: Int,
                 since: Int,
                 currentUsers: [User]) -> Observable<[User]>
    
}

class GithubUsersInteractor: GithubUsersInteractorProtocol {
    
    func getUser(page: Int,
                 since: Int,
                 currentUsers: [User]) -> Observable<[User]> {
        return Observable<[User]>.create { observer -> Disposable in
            let url = "https://api.github.com/users"
            let parameters: Parameters = [
                "per_page": 20,
                "since": (page) * 20
            ]
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [User].self) { response in
                    switch response.result {
                    case .success(let users):
                        let userTemp = currentUsers + users
                        observer.onNext(currentUsers + users)
                        observer.onCompleted()
                        print(parameters)
                        print(userTemp.count)
                    case .failure(let error):
                        observer.onError(error)
                        print(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
