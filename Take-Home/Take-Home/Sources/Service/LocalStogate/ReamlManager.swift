//
//  Reaml.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import RealmSwift
import Foundation

class ReamlManager {
    
    static let shared = ReamlManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func fetchData<T: Object>() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func saveData<T: Object>(_ data: [T]) throws {
        try realm.write {
            data.forEach { i in
                realm.add(i)
            }
        }
    }
    
    func saveData<T: Object>(_ data: T) throws {
        try realm.write {
            realm.add(data)
        }
    }
    
}

extension ReamlManager {
    
    func fetchUsers() -> [User] {
        let userEntitys: [UserDetailsEntityReaml] = fetchData()
        return userEntitys
            .compactMap({$0.toModel()})
    }
    
}
