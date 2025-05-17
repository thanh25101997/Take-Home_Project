//
//  User.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
    
    func toEntity() -> UserDetailsEntityReaml {
        let entity = UserDetailsEntityReaml()
        entity.id = id
        entity.login = login
        entity.avatar_url = avatar_url
        entity.html_url = html_url
        return entity
    }
    
}
