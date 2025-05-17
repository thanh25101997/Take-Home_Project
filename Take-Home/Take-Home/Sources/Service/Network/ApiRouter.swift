//
//  ApiRouter.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import Foundation
import Alamofire

protocol APIRouterProtocol {
    var baseUrl: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var params: [String : Any]? { get }
    var header: HTTPHeaders { get }
}

enum APIRouter: APIRouterProtocol {
    
    case fetchUsers(per_page: Int, since: Int)
    case fetchUserDetails(name: String)
    
    var baseUrl: String {
        switch self {
        case .fetchUsers,
                .fetchUserDetails:
            return "https://api.github.com/"
        }
    }
    
    var endPoint: String {
        switch self {
        case .fetchUsers :
            return "users"
        case .fetchUserDetails(let name):
            return "users/\(name)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUsers,
                .fetchUserDetails:
            return .get
            
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .fetchUsers(let per_page, let since):
            return ["per_page": per_page,
                    "since": since]
        default:
            return [:]
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .fetchUsers,
                .fetchUserDetails:
            var headers = HTTPHeaders()
            headers.add(name: "Content-Type", value: "application/json")
            headers.add(name: "charset", value: "utf-8")
            return headers
        }
    }
}
