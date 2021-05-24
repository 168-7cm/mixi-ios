//
//  RepositoryLoader.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import Foundation
import Combine

class RepositoryLoader: ObservableObject {

    // setterのみをprivateに設定
    @Published private (set) var repositories = [Repository]()

    // disposeBagと同じ
    private var chancellables = Set<AnyCancellable>()

    func fetchRepository() {
        let repositoryPublisher = Future<[Repository], Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                promise(.success([.mock1, .mock2, .mock3, .mock4, .mock5]))
            }
        }
        repositoryPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:  { completion in
            print("didFinishedCompletion")
        }, receiveValue:  { [weak self] repositories in
            self?.repositories = repositories
        }).store(in: &chancellables)
    }
}
