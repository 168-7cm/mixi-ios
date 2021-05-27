//
//  RepositoryLoader.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import Foundation
import Combine
import Alamofire

class RepositoryLoader: ObservableObject {

    // setterのみをprivateに設定
    @Published private (set) var repositories = [Repository]()

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
            .sink(receiveCompletion: { completion in
                print("finished\(completion)")
            }, receiveValue: { [weak self] repositories in
                self?.repositories = repositories
            }
            ).store(in: &chancellables)
    }
}
