//
//  UserDetailView.swift
//  UserGithubApi
//
//  Created by ahmet karadağ on 30.05.2025.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject private var viewModel: UserDetailViewModel

    init(user: User) {
        _viewModel = StateObject(wrappedValue: UserDetailViewModel(username: user.userName))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchUserDetail()
                        }
                    }
                    .padding(.top)
                }
            } else if let userDetail = viewModel.userDetail {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: userDetail.avatarURL)) { image in
                        image
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }

                    Text(userDetail.name ?? userDetail.userName)
                        .font(.title)
                        .bold()

                    if let bio = userDetail.bio {
                        Text(bio)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    if let location = userDetail.location {
                        Text("Location: \(location)")
                            .foregroundColor(.secondary)
                    }

                    if let repos = userDetail.publicRepos {
                        Text("Public Repos: \(repos)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .navigationTitle(userDetail.userName)
            } else {
                Text("No data")
            }
        }
        .task {
            await viewModel.fetchUserDetail()
        }
    }
}
#Preview {
    UserDetailView(user: User(id: 1, userName: "octocat", avatarURL: "https://avatars.githubusercontent.com/u/583231?v=4"))
}
