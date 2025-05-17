//
//  UserDetailsEntity.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import Foundation

struct UserDetailsEntity: Codable {
    let login: String
    let id: Int
    let name: String?
    let blog: String?
    let location: String?
    let followers: Int
    let following: Int
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case name
        case blog
        case location
        case followers
        case following
        case avatarURL = "avatar_url"
    }
    
}
