//
//  State.swift
//  mixi-ios
//
//  Created by kou yamamoto on 2021/05/28.
//

import Foundation

enum State<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}
