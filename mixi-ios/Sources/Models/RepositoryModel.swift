//
//  RepositoryModel.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/27.
//

import Foundation
import Combine

final class RepositoryModel {
    func fetchRepositories() -> AnyPublisher<[RepositoryEntity], Error> {
        return RepositoryAPIClient().getRepositories()
    }
}
