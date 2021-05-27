//
//  RepositoryViewModel.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/27.
//

import Foundation
import Combine
import Alamofire

enum State<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}

final class RepositoryViewModel: ObservableObject {
    @Published private (set) var repositories: State<[RepositoryEntity]> = .idle

    private var cancellables = Set<AnyCancellable>()

    func onAppear() {
        loadRepositories()
    }

    func retryButtonDidTapped() {
        loadRepositories()
    }

    private func loadRepositories() {
        RepositoryModel().fetchRepositories()
            // イベント発火時に呼ばれる
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.repositories = .loading
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.repositories = .failed(error)
                case .finished:
                    print("didFinished")
                }
            }, receiveValue: { [weak self] repositories in
                DispatchQueue.main.async { self?.repositories = .loaded(repositories) }
            }
            ).store(in: &cancellables)
    }
}


