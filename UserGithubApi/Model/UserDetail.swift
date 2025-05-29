//
//  UserDetail.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 30.05.2025.
//

import Foundation

struct UserDetail: Codable, Hashable {
    let id: Int
    let userName: String
    let avatarURL: String
    let name: String?
    let bio: String?
    let location: String?
    let publicRepos: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarURL = "avatar_url"
        case name
        case bio
        case location
        case publicRepos = "public_repos"
    }
}
