//
//  APIClient.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Foundation
import Dependencies

// 1:DIするためにプロトコルとして宣言
protocol APIClienttProtocol: Sendable {
    func fetch() async throws -> Data
}

public struct APIClient: APIClienttProtocol {
    private let url = URL(string: "https://api.github.com/search/repositories?q=swift")!

    public init() {}
    
    public func fetch() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

// 2:DependencyKey の登録
private enum APIClientKey: DependencyKey {
    // アプリ実行時使用
    static let liveValue: any APIClienttProtocol = APIClient()
}

// 3:DependencyValues の拡張
extension DependencyValues {
    //  ↓ @Dependency で呼び出す時のKeyとなる
    var apiClient: any APIClienttProtocol {
        // 呼び出されるデータを getter, setter で管理
        get { self[APIClientKey.self] }
        set { self[APIClientKey.self] = newValue }
    }
}
