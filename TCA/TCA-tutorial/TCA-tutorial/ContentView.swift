//
//  ContentView.swift
//  TCA-tutorial
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store = Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
            ._printChanges()   // 変更を検知し、コンソールに表示
        
        /*
         コンソール
            ====
            received action:
               CounterFeature.Action.incrementButtonTapped
             - CounterFeature.State(count: 0)
             + CounterFeature.State(count: 1)
            〜〜〜
         */
    })
    
    var body: some View {
        ConunterView(store: store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
