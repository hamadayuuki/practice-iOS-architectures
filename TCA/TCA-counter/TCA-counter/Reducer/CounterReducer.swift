//
//  CounterReducer.swift
//  TCA-counter
//
//  Created by 濵田　悠樹 on 2023/03/23.
//

import Foundation
import ComposableArchitecture

class CounterReducer {
    let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { (state, action, environment) in
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}
