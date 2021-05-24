//
//  Pepository.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/24.
//

import Foundation

struct Repository: Identifiable {
    let id: Int
    let name: String
    let owner: User
    let description: String
    let stargazersCount: Int
}

struct User {
    let name: String
}
