//
//  QiitaListRequestComponent.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/05.
//
import Foundation

// APIからのデータ取得時 に使用する
// API通信時にドメインオブジェクトを可変にするため
public struct QiitaListRequestComponent: RequestComponent {
    public typealias type = QiitaList
    public let query = "SwiftUI"
}

/*
// QiitaList をもとに行う
public struct QiitaListRequestType: Decodable {
    let title: String
    let url: String
    let likes_count: Int   // LGTM数
}
 */
