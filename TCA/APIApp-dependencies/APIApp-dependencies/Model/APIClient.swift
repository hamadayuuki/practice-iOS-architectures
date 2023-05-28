//
//  APIClient.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Foundation
import Dependencies

// 1:DIするためにプロトコルとして宣言
// テストする際 簡単にMockへ切り替え可能
protocol APIClientProtocol: Sendable {
    func fetch(searchWord: String) async throws -> [Repository]
}

public struct APIClient: APIClientProtocol {
    private let baseUrl = "https://api.github.com/search/repositories"

    public init() {}
    
    public func fetch(searchWord: String) async throws -> [Repository] {
        let url = URL(string: "\(baseUrl)?q=\(searchWord))")!   
        let (data, _) = try await URLSession.shared.data(from: url)
        let repositories = try JSONDecoder().decode(Repositories.self, from: data)
        let repos: [Repository] = repositories.items
        return repos
    }
}

public struct APIClientMock: APIClientProtocol {
    public init() {}
    
    public func createReposMock() -> [Repository] {
        var repos: [Repository] = []
        for i in 0..<10 {
            let repo = Repository(id: i, language: "\(i)", stargazers_count: i, watchers_count: i, forks_count: i, open_issues_count: i, full_name: "\(i)", url: "https://\(i)", updated_at: "\(i)", owner: Owner(id: i, avatar_url: "https://\(i)"))
            repos.append(repo)
        }
        return repos
    }
    
    public func fetch(searchWord: String) async throws -> [Repository] {
        let repos: [Repository] = createReposMock()
        return repos
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
