//
//  APIClientTests.swift
//  APIApp-dependenciesTests
//
//  Created by 濵田　悠樹 on 2023/05/28.
//

import ComposableArchitecture
import Dependencies
import XCTest

@testable import APIApp_dependencies

// Action毎にテストを書く？
@MainActor
final class APIClientTests: XCTestCase {
    func test_tappedSearchButtonによって正常にデータを取得する() async {
        let testStore = TestStore(initialState: APIAppStore.State()) {
            APIAppStore()
          } withDependencies: {
            $0.apiClient = APIClientMock()   // StoreのDependency(apiClient)を上書き
          }
        
        await testStore.send(.tappedSearchButton(""))   // .tappedSearchButton → .setRepos(repos) の流れを再現
        await testStore.receive(.setRepos(APIClientMock().createReposMock())) {   // QUESTION: テストの書き方は合っているか？, .createReposMock() を2回呼び比較しているのでテストの意味がないのでは？
            $0.repos = APIClientMock().createReposMock()
        }
        
        // QUESTION: XCAssertNotEqual() のテストはどのように書くのか？, 書く必要があるのか？
    }

    func test_tappedClearButtonによってデータを空にする() {
        let testStore = TestStore(initialState: APIAppStore.State()) {
            APIAppStore()
          } withDependencies: {
              $0.apiClient = APIClientMock()
          }
        
        // QUESTION: テストの書き方は合っているか？, データが 何か格納されている状態→空になる を確認したいのでは？, 値を代入した方が良い？どのようにプログラムを書き代入する？
        // このままで良さそう。https://github.com/pointfreeco/swift-composable-architecture/blob/main/Examples/Search/SearchTests/SearchTests.swift#L28
        testStore.send(.tappedClearButton)
        
        // QUESTION: XCAssertNotEqual() のテストはどのように書くのか？, 書く必要があるのか？
    }
}
