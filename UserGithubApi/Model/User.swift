//
//  User.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 27.05.2025.
//

import Foundation

struct User: Identifiable, Codable,Hashable {
    let id: Int
    let userName: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarURL = "avatar_url"
    }
}

