//
//  RepositoryDetailView.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import SwiftUI

struct RepositoryDetailView: View {

    let repository: Repository

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("GitHubMark")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(repository.owner.name).font(.caption)
                            .font(.caption)
                    }

                    Text(repository.name)
                        .font(.body)
                        .fontWeight(.semibold)

                    Text(repository.description)
                        .padding(.top, 4)

                    HStack {
                        Image(systemName: "star")
                        Text("\(repository.stargazersCount) stars")
                    }
                    .padding(.top, 8)
                    Spacer()
                }
                Spacer()
            }
            .padding(8)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: .mock1)
    }
}