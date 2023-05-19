//
//  TCA_todosApp.swift
//  TCA-todos
//
//  Created by 濵田　悠樹 on 2023/03/29.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_todosApp: App {
    var body: some Scene {
        WindowGroup {
            // View と Store の繋ぎ込み
            TodoView(store: Store(initialState: Todo.State(id: UUID())) {
                Todo()
            })
        }
    }
}
