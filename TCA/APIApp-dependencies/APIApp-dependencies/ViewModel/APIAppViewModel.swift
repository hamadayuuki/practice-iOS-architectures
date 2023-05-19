//
//  APIAppViewModel.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import Foundation

@MainActor
class APIAppViewModel: ObservableObject {
    private let apiClient = APIClient()
    @Published var repos: [String] = []
    
    init() {}
    
    func fetch() async {
        do {
            //let data = try await apiClient.fetch()
            //print(data)
            repos = ["Apple", "Swift", "Concurrency"]
        } catch {
            fatalError("fetch error")
        }
    }
}
