//
//  ContentView.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import SwiftUI

struct RepositoryListView: View {

    @StateObject private var repositoryViewModel = RepositoryViewModel()

    var body: some View {
        NavigationView {
            Group {
                switch repositoryViewModel.repositories {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed:
                    VStack {
                        Group {
                            Image("")
                            Text("failed to load repositories")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(action: {
                            repositoryViewModel.retryButtonDidTapped()
                        }, label: {
                            Text("Retry")
                                .fontWeight(.bold)
                        }
                        )
                        .padding(.top, 8)
                    }
                case let .loaded(repositories):
                    if repositories.isEmpty {
                        Text("No repositories").fontWeight(.bold)
                    } else {
                        List(repositories) { repository in
                            NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                                RepositoryRow(repository: repository)
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
        RepositoryListView()
    }
}
