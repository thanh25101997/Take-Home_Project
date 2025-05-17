//
//  ApiClient.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import Foundation
import Alamofire
import RxSwift

class APIClient {
    
    static let shared = APIClient()
    
    let sessionManager: Session
    
    private init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        sessionManager = Session(configuration: configuration)
    }
    
    func request<T: Decodable>(endPoint: APIRouter) -> Observable<T> {
        return Observable<T>.create { [weak self] observer -> Disposable in
            let url = endPoint.baseUrl + endPoint.endPoint
            let parameters = endPoint.params
            let headers = endPoint.header
            self?.sessionManager.request(url,
                                         method: endPoint.method,
                                         parameters: parameters,
                                         headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
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
