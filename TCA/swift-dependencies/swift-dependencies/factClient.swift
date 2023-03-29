//
//  factClient.swift
//  swift-dependencies
//
//  Created by 濵田　悠樹 on 2023/03/24.
//

import Foundation
import ComposableArchitecture

// MARK: interface
// メソッドの定義
struct FactClient {
    var fetch: @Sendable (Int) async throws -> String
}

// MARK: Value
// @Dependency(\.factClient) var factClient という形で Property Wrapper を利用するためにも DependencyValuesのextension が必要
extension DependencyValues {
    var factClient: FactClient {
        get { self[FactClient.self] }
        set { self[FactClient.self] = newValue }
    }
}

// MARK: Key
// FactClient に DependencyKey を準拠させる
extension FactClient: DependencyKey {
    static let liveValue = Self(
        fetch: { number in
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "https://umayadia-apisample.azurewebsites.net/api/persons/Shakespeare")!)
            return String(decoding:data, as: UTF8.self)
        }
    )
}
