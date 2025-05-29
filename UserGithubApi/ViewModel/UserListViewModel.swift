//
//  UserListViewModel.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 28.05.2025.
//

import Foundation
@MainActor
class UserListViewModel:ObservableObject {
    @Published var users:[User] = []
    @Published var isLoading:Bool = false
    @Published var errorMessage:String?
    
    private let service = GithubService()
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await service.fetchUser()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
