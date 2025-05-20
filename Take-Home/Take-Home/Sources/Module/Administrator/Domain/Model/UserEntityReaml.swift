//
//  UserEntityRealm.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import RealmSwift
import Foundation

class UserDetailsEntityRealm: Object {
    
    @Persisted var id: Int = 0
    @Persisted var login: String = ""
    @Persisted var avatarUrl: String = ""
    @Persisted var htmlUrl: String = ""
    
    func toModel() -> User {
        User(id: id,
             login: login,
             avatarUrl: avatarUrl,
             htmlUrl: htmlUrl)
    }
    
}
