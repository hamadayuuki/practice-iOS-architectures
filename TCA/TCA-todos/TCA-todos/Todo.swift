//
//  Todo.swift
//  TCA-todos
//
//  Created by 濵田　悠樹 on 2023/03/29.
//

import ComposableArchitecture
import SwiftUI

struct Todo: ReducerProtocol {
    // イベントに合わせて状態を変更
    /*
        イベント:Viewから受け取る
        状態:switch文の中で変更, 変更し次第Viewに通知がいく
    */
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .checkBoxToggled:
            state.isComplete.toggle()
            return .none
        case .textFieldChanged(let text):
            state.description = text
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
            VStack {
                Text(viewStore.description)
                
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
}
