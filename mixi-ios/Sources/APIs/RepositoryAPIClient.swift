//
//  RepositoryAPIClient.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/27.
//

import Foundation
import Combine

final class RepositoryAPIClient {

    private let url: URL = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
    private let chancellables = Set<AnyCancellable>()

    func getRepositories() -> AnyPublisher<[RepositoryEntity], Error> {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3+json"]

        let repositoryPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpRespnse = element.response as? HTTPURLResponse, httpRespnse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
           .decode(type: [RepositoryEntity].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        return repositoryPublisher
    }
}
