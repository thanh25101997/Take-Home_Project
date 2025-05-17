//
//  UserEntityReaml.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import RealmSwift
import Foundation

class UserDetailsEntityReaml: Object {
    
    @Persisted var id: Int = 0
    @Persisted var login: String = ""
    @Persisted var avatar_url: String = ""
    @Persisted var html_url: String = ""
    
    func toModel() -> User {
        User(id: id,
             login: login,
             avatar_url: avatar_url,
             html_url: html_url)
    }
    
}
