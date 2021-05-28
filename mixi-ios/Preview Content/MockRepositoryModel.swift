//
//  MockRepositoryModel.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/28.
//

import Foundation
import Combine

// テスト用のMock
final class MockRepositoryModel: RepositoryModelType {

    let repositories: [RepositoryEntity]
    let error: Error?

    init(repositories: [RepositoryEntity], error: Error? = nil) {
        self.repositories = repositories
        self.error = error
    }

    func fetchRepositories() -> AnyPublisher<[RepositoryEntity], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return Just(repositories).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
