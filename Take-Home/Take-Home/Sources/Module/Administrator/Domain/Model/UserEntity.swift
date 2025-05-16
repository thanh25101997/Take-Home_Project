//
//  User.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
}
