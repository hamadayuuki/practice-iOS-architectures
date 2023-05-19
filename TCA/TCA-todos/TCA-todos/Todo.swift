//
//  Todo.swift
//  TCA-todos
//
//  Created by 濵田　悠樹 on 2023/03/29.
//

import ComposableArchitecture
import SwiftUI

struct Todo: ReducerProtocol {
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .checkBoxToggled:
            print("call checkBoxToggled Action!")
            return .none
        case .textFieldChanged(let text):
            print("call textFieldChanged Action!")
            return .none
        }
    }
    
    // 状態を表す変数を定義
    struct State: Equatable, Identifiable {
        var description = ""
        var id: UUID
        var isComplete = false
    }
    
    // イベントを定義
    enum Action: Equatable {
        case checkBoxToggled
        case textFieldChanged(String)
    }
}

// store は ContentViewから注入される
struct TodoView: View {
    let store: StoreOf<Todo>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                //                         ↓ イベントを通知する
                Button(action: { viewStore.send(.checkBoxToggled) }) {
                    Image(systemName: viewStore.isComplete ? "checkmark.square" : "square")
                }
                .buttonStyle(.plain)
                
                TextField(
                    "Untitled Todo",
                    text: viewStore.binding(get: \.description, send: Todo.Action.textFieldChanged)
                )
            }
        }
    }
}
