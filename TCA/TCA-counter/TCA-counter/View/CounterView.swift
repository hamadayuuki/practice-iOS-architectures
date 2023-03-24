//
//  CounterView.swift
//  TCA-counter
//
//  Created by 濵田　悠樹 on 2023/03/23.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button("-") { viewStore.send(.decrementButtonTapped) }   // イベント通知
                
                Text("\(viewStore.count)")
                    .font(.body.monospacedDigit())
                
                Button("+") { viewStore.send(.incrementButtonTapped) }
            }
        }
    }
}
