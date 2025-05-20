//
//  GithubUsersRepository.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import RxSwift
import Foundation

protocol UserDetailRepositoryProtocol {
    
    func getUserFromServer(loginUserName: String) -> Observable<UserDetailsEntity>
    
}

class UserDetailRepository: UserDetailRepositoryProtocol {
    
    private var apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getUserFromServer(loginUserName: String) -> Observable<UserDetailsEntity> {
        let observable: Observable<UserDetailsEntity> = apiClient.request(endPoint: APIRouter.fetchUserDetails(name: loginUserName))
        return observable
    }
    
}
