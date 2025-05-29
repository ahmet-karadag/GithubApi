//
//  UserDetailViewModel.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 30.05.2025.
//

import Foundation

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var userDetail: UserDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = GithubService()
    private let username: String

    init(username: String) {
        self.username = username
    }

    func fetchUserDetail() async {
        isLoading = true
        errorMessage = nil
        do {
            userDetail = try await service.fetchUserDetail(for: username)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
