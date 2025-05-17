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
    
    func getUser(loginUserName: String) -> Observable<UserDetailsEntity> {
        let observable: Observable<UserDetailsEntity> = APIClient.shared.request(endPoint: APIRouter.fetchUserDetails(name: loginUserName))
        return observable
    }
    
}
