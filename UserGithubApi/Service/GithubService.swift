//
//  GithubService.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 28.05.2025.
//
/* GitHubUsersSwiftUI/
 ├── Models/
 │   └── User.swift
 ├── ViewModels/
 │   └── UserListViewModel.swift
 │   └── UserDetailViewModel.swift
 ├── Views/
 │   └── UserListView.swift
 │   └── UserDetailView.swift
 ├── Services/
 │   └── GitHubService.swift
 ├── GitHubUsersSwiftUIApp.swift*/

import Foundation

class GithubService {
    func fetchUser() async throws -> [User] {
        guard let url = URL(string: "https://api.github.com/users") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        // ✅ DEBUG: JSON çıktısını yazdır
        print(String(data: data, encoding: .utf8) ?? "Invalid JSON")

        // ❗️API limit gibi bir hata döndüyse yakala
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let message = json["message"] as? String {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
        }

        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }
    
    func fetchUserDetail(for username: String) async throws -> UserDetail {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let userDetail = try JSONDecoder().decode(UserDetail.self, from: data)
        return userDetail
    }
}
