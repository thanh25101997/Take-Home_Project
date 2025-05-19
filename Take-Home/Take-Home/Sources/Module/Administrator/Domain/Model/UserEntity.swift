//
//  User.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

struct User: Decodable {
    
    let id: Int?
    let login: String?
    let avatarUrl: String?
    let htmlUrl: String?
    
    init(id: Int? = nil, login: String? = nil, avatarUrl: String? = nil, htmlUrl: String? = nil) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    func toEntity() -> UserDetailsEntityReaml {
        let entity = UserDetailsEntityReaml()
        entity.id = id ?? -1
        entity.login = login ?? ""
        entity.avatarUrl = avatarUrl ?? ""
        entity.htmlUrl = htmlUrl ?? ""
        return entity
    }
    
}
