//
//  APIClient.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Foundation
import Dependencies

// 1:DIするためにプロトコルとして宣言
protocol APIClientProtocol: Sendable {
    func fetch(searchWord: String) async throws -> Data
}

public struct APIClient: APIClientProtocol {
    private let baseUrl = "https://api.github.com/search/repositories"

    public init() {}
    
    public func fetch(searchWord: String) async throws -> Data {
        let url = URL(string: "\(baseUrl)?q=\(searchWord))")!   
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

// 2:DependencyKey の登録
private enum APIClientKey: DependencyKey {
    // アプリ実行時使用
    static let liveValue: any APIClientProtocol = APIClient()
}

// 3:DependencyValues の拡張
extension DependencyValues {
    //  ↓ @Dependency で呼び出す時のKeyとなる
    var apiClient: any APIClientProtocol {
        // 呼び出されるデータを getter, setter で管理
        get { self[APIClientKey.self] }
        set { self[APIClientKey.self] = newValue }
    }
}
