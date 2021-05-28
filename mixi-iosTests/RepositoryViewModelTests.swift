//
//  RepositoryViewModelTests.swift
//  mixi-iosTests
//
//  Created by kou yamamoto on 2021/05/28.
//

import XCTest
import Combine
@testable import mixi_ios

final class RepositoryViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        cancellables = .init()
    }

    func test_正しくリポジトリ一覧が読み込まれること() {

        let loadingExpection = expectation(description: "読み込み中のステータスになること")
        let loadedExpection = expectation(description: "正しくリポジトリが読み込まれること")

        let repositoryViewModel = RepositoryViewModel(repositoryModel: MockRepositoryModel(repositories: [.mock1, .mock2]))

        repositoryViewModel.$repositories.sink { result in
            switch result {
            case .loading: loadingExpection.fulfill()
            case let .loaded(repositories):
                if repositories.count == 2 && repositories.map({ $0.id }) == [RepositoryEntity.mock1.id, RepositoryEntity.mock2.id] {
                    loadedExpection.fulfill()
                } else { XCTFail("Uxecpected: \(result)") }
            default: break
            }
        }.store(in: &cancellables)

        repositoryViewModel.onAppear()

        wait(for: [loadingExpection, loadedExpection], timeout: 2.0, enforceOrder: true)
    }

    func test_エラーがひょうじされること() {
        let errorExpection = expectation(description: "エラー状態になること")

        let repositoryViewModel = RepositoryViewModel(repositoryModel: MockRepositoryModel(repositories: [.mock1, .mock2], error: DummyError()))

        repositoryViewModel.$repositories.sink { result in
            switch result {
            case let .failed(error):
                if error is DummyError { errorExpection.fulfill() }
                else { XCTFail("Uxecpected: \(result)") }
            default: break
            }
        }.store(in: &cancellables)

        repositoryViewModel.onAppear()

        wait(for: [errorExpection], timeout: 2.0, enforceOrder: true)
    }
}
