//
//  ContentView.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import SwiftUI

struct RepositoryListView: View {

    @StateObject private var repositoryLoader = RepositoryLoader()

    var body: some View {
        NavigationView {
            if repositoryLoader.repositories.isEmpty {
                ProgressView("loading.....")
            } else {
                List(repositoryLoader.repositories) { repository in
                    NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }
                }.navigationTitle("Repositories")
            }
        }.onAppear {
            repositoryLoader.fetchRepository()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
