//
//  APIAppViewModel.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Dependencies
import Foundation

@MainActor
class APIAppViewModel: ObservableObject {
    @Dependency(\.apiClient) var apiClient   // dependenciesによるDI
    
    @Published private(set) var repos: [Repository] = []
    
    init() {}
    
    func fetch() async {
        do {
            let data = try await apiClient.fetch()
            let repositories = try JSONDecoder().decode(Repositories.self, from: data)
            self.repos = repositories.items
        } catch {
            fatalError("fetch error")
        }
    }
}
