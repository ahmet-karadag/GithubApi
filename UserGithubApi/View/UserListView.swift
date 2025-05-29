//
//  SwiftUIView.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 29.05.2025.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundStyle(.red)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(value: user) {
                            HStack {
                                AsyncImage(url: URL(string: user.avatarURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }

                                Text(user.userName)
                                    .font(.headline)
                                    .padding(.leading, 8)
                            }
                        }
                    }
                }
            }
            .navigationTitle("GitHub Users")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    UserListView()
}
