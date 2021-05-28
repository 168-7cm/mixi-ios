//
//  ContentView.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import SwiftUI

struct RepositoryListView: View {

    @EnvironmentObject private var repositoryViewModel: RepositoryViewModel

    var body: some View {
        NavigationView {
            Group {
                switch repositoryViewModel.repositories {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed:
                    NoRepositoryView()
                case let .loaded(repositories):
                    if repositories.isEmpty {
                        Text("No repositories").fontWeight(.bold)
                    } else {
                        List(repositories) { repository in
                            NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                                RepositoryRowView(repository: repository)
                            }
                        }.navigationTitle("Repositories")
                    }
                }
            }
        }.onAppear {
            repositoryViewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepositoryListView()
                .environmentObject(RepositoryViewModel(
                    repositoryModel: MockRepositoryModel(
                        repositories: [
                            .mock1, .mock2, .mock3, .mock4, .mock5
                        ]
                    )
                )
            )
            .previewDisplayName("Default")

            RepositoryListView()
                .environmentObject(RepositoryViewModel(
                    repositoryModel: MockRepositoryModel(
                        repositories: []
                    )
                )
            )
            .previewDisplayName("Empty")

            RepositoryListView()
                .environmentObject(RepositoryViewModel(
                    repositoryModel: MockRepositoryModel(
                        repositories: [],
                        error: DummyError()
                    )
                )
            )
            .previewDisplayName("Error")
        }
    }
}
