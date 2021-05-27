//
//  RepositoryLoader.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
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

class RepositoryLoader: ObservableObject {

    // setterのみをprivateに設定
    @Published private (set) var repositories: State<[Repository]> = .idle

    private let url: URL = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

    // disposeBagと同じ
    private var chancellables = Set<AnyCancellable>()

    func fetchRepository() {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3+json"]

        let repositoryPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpRespnse = element.response as? HTTPURLResponse, httpRespnse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data

            }
            .decode(type: [Repository].self, decoder: JSONDecoder())

        repositoryPublisher
            .receive(on: DispatchQueue.main)
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
                self?.repositories = .loaded(repositories)
            }
            ).store(in: &chancellables)
    }
}
