//
//  Created by Van Thanh on 15/5/25.
//
import Foundation
import Alamofire
import RxSwift

protocol UserDetailInteractorProtocol {
    
    func getUser(loginUserName: String) -> Observable<UserDetailsEntity>
    
}

class UserDetailInteractor: UserDetailInteractorProtocol {
    
    var userDetailRepository: UserDetailRepositoryProtocol
    
    init(userDetailRepository: UserDetailRepositoryProtocol) {
        self.userDetailRepository = userDetailRepository
    }
    
    func getUser(loginUserName: String) -> Observable<UserDetailsEntity> {
        return userDetailRepository
            .getUserFromServer(loginUserName: loginUserName)
            .catch { _ in
                return .empty()
            }
    }
    
}
