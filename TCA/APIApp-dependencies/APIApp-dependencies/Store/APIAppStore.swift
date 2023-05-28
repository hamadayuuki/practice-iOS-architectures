//
//  APIAppStore.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/28.
//

import ComposableArchitecture
import Dependencies
import Foundation

struct APIAppStore: ReducerProtocol {
    @Dependency(\.apiClient) var apiClient   // リポジトリ一覧を取得する

    struct State: Equatable {
        var repos: [Repository] = []
    }
    
    enum Action: Equatable {
        case tappedSearchButton(String)
        case tappedClearButton

        case setRepos([Repository])   // TCAの練習用のため エラーを考慮していない
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        // Action に応じて、Stateを変更
        switch action {
            
        // リポジトリ一覧を取得
        case .tappedSearchButton(let searchWord):
            // Reducer内でConcurrencyを使用するためには .run を使う
            return .run { send in
                let data = try await apiClient.fetch(searchWord: searchWord)
                let repositories = try JSONDecoder().decode(Repositories.self, from: data)
                let repos: [Repository] = repositories.items
                await send(.setRepos(repos))
            }
        // state.reops にデータを代入
        case.setRepos(let repos):
            state.repos = repos
            return .none
        
        // リポジトリ一覧を削除
        case .tappedClearButton:
            state.repos = []
            return .none
        }
    }
}
