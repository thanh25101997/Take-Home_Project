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
        return Observable<UserDetailsEntity>.create { observer -> Disposable in
            let url = "https://api.github.com/users/\(loginUserName)"
            
            AF.request(url)
                .validate()
                .responseDecodable(of: UserDetailsEntity.self) { response in
                    switch response.result {
                    case .success(let user):
                        observer.onNext(user)
                        observer.onCompleted()
                        print(user)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
