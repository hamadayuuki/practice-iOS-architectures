//
//  APIClient.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Foundation

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
