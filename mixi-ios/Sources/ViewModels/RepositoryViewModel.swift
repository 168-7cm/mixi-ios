//
//  RepositoryViewModel.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/27.
//

import Foundation
import Combine
import Alamofire

final class RepositoryViewModel: ObservableObject {
    @Published private (set) var repositories: State<[RepositoryEntity]> = .idle

    private var cancellables = Set<AnyCancellable>()

    private let repositoryModel: RepositoryModelType!

    init(repositoryModel: RepositoryModelType = RepositoryModel()) {
        self.repositoryModel = repositoryModel
    }

    func onAppear() {
        loadRepositories()
    }

    func retryButtonDidTapped() {
        loadRepositories()
    }

    private func loadRepositories() {
        repositoryModel.fetchRepositories()
            // イベント発火時に呼ばれる
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.repositories = .loading
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {  self.repositories = .failed(error) }

                case .finished:
                    print("didFinished")
                }
            }, receiveValue: { [weak self] repositories in
                DispatchQueue.main.async { self?.repositories = .loaded(repositories) }
            }
            ).store(in: &cancellables)
    }
}


