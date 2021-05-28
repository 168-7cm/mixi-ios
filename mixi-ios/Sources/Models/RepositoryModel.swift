//
//  RepositoryModel.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/27.
//

import Foundation
import Combine

protocol RepositoryModelType {
    func fetchRepositories() -> AnyPublisher<[RepositoryEntity], Error>
}

final class RepositoryModel: RepositoryModelType {
    func fetchRepositories() -> AnyPublisher<[RepositoryEntity], Error> {
        return RepositoryAPIClient().getRepositories()
    }
}
