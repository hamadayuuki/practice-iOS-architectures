//
//  Todo.swift
//  TCA-todos
//
//  Created by 濵田　悠樹 on 2023/03/29.
//

import ComposableArchitecture
import SwiftUI

struct Todo: ReducerProtocol {
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
