//
//  Realm.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import RealmSwift
import Foundation

protocol RealmManagerProtocol {
    func fetchUsers() -> [User]
    func deleteUserObj()
    func saveUser(_ users: User)
    func saveUsers(_ users: [User])
}

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting all objects: \(error)")
        }
    }
    
}

// private func
extension RealmManager {
    private func fetchData<T: Object>() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    private func saveData<T: Object>(_ data: [T]) throws {
        try realm.write {
            data.forEach { i in
                realm.add(i)
            }
        }
    }
    
    private func saveData<T: Object>(_ data: T) throws {
        try realm.write {
            realm.add(data)
        }
    }
    
    private func deleteObj<T: Object>(_ type: T.Type)  {
        do {
            let data = realm.objects(T.self)
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Error deleting objects: \(error)")
        }
    }
}

// Public func 
extension RealmManager: RealmManagerProtocol {
    
    func fetchUsers() -> [User] {
        let userEntitys: [UserDetailsEntityRealm] = fetchData()
        return userEntitys
            .compactMap({$0.toModel()})
    }
    
    func saveUser(_ user: User) {
        try? saveData(user.toEntity())
    }
    
    func saveUsers(_ users: [User]) {
        users
            .map({$0.toEntity()})
            .forEach { i in
                try? saveData(i)
            }
    }
    
    func deleteUserObj()  {
        deleteObj(UserDetailsEntityRealm.self)
    }
    
}
