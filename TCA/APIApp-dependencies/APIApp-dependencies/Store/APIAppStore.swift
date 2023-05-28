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
}
