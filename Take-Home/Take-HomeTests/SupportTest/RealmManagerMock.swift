//
//  RealmManagerMock.swift
//  Take-Home
//
//  Created by Van Thanh on 20/5/25.
//

import Foundation
@testable import Take_Home

class RealmManagerMock: RealmManagerProtocol {
    
    var deleteUserObjCalled = false
    func deleteUserObj() {
        deleteUserObjCalled = true
    }
    
    var saveUserArg: User?
    func saveUser(_ users: User) {
        saveUserArg = users
    }
    
    var fetchUsersCalled = false
    var fetchUsersResult = [User]()
    func fetchUsers() -> [User] {
        fetchUsersCalled = true
        return fetchUsersResult
    }
    
    var saveUsersArg: [User]?
    func saveUsers(_ users: [User]) {
        saveUsersArg = users
    }
    
}
