//
//  NoRepositoryView.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/28.
//

import SwiftUI

struct NoRepositoryView: View {

    @EnvironmentObject private var repositoryViewModel: RepositoryViewModel

    var body: some View {
        VStack {
            Group {
                Image("GitHubMark")
                Text("failed to load repositories").padding(.top, 4)
            }
            .foregroundColor(.black).opacity(0.4)
            Button(action: {
                repositoryViewModel.retryButtonDidTapped()
            }, label: {
                Text("Retry").fontWeight(.bold)
            }).padding(.top, 8)
        }
    }
}

struct NoRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        NoRepositoryView()
    }
}
