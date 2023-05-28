//
//  APIAppStore.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/28.
//

import ComposableArchitecture

struct APIAppStore: ReducerProtocol {
    struct State: Equatable {
        var repos: [Repository] = []
    }
    
    enum Action: Equatable {
        case tappedSearchButton
        case tappedClearButton
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        // Action に応じて、Stateを変更
        switch action {
            
        // リポジトリ一覧を取得
        case .tappedSearchButton:
            state.repos = [
                Repository(id: 0, language: "Swfit", stargazers_count: 100, watchers_count: 100, forks_count: 100, open_issues_count: 100, full_name: "SwiftRepo1", url: "https://~~~", updated_at: "2023/05/30", owner: Owner(id: 0, avatar_url: "https://~~~"))
                ]   // 仮置き
            return .none
        
        // リポジトリ一覧を削除
        case .tappedClearButton:
            state.repos = []
            return .none
        }
    }
}
