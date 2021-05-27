//
//  Pepository.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import Foundation

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let owner: User
    let description: String?
    let stargazersCount: Int

    // EncodeとDecodeでキー名が異なる場合に1対1で対応させる必要がある。「CodingKeys」
    // https://qiita.com/_ha1f/items/bf1aad5ea3e927f59f9d
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case stargazersCount = "stargazers_count"
    }
}

struct User: Codable {
    let name: String

    private enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
