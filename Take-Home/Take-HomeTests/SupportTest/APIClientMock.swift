//
//  APIClientMock.swift
//  Take-Home
//
//  Created by Van Thanh on 20/5/25.
//

import Foundation
import RxSwift
@testable import Take_Home

class APIClientMock: ApiClientProtocol {
    
    var endPointArg: APIRouter?
    func request<T>(endPoint: APIRouter) -> Observable<T> where T : Decodable {
        endPointArg = endPoint
        return Observable<T>.create { observer -> Disposable in
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
