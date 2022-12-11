//
//  Action.swift
//  Flux
//
//  Created by 濵田　悠樹 on 2022/11/11.
//

/*
 Action: 実行するための処理を特定するためのtypeと、実行する処理に紐づくdataを保持したオブジェクト
 */

import Foundation

enum Action {
    
    // MARK: - Search
    case serchQuery(String?)
    case serchPagination(GitHub.pagination?)   // TODO: - GitHubクラスの実装
    case searchRepositories([GitHub.Repository])
    case clearSearchRepositories
    case isRepositoriesFetching(Bool)
    case error(Error?)
    
    // MARK: - Favorite
    case setFavoriteRepositories([GitHub.Repository])
    
    // MARK: - Others
    case selectedRepository(GitHub.Repository?)
}
