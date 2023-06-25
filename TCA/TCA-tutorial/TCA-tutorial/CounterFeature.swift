//
//  CounterFeature.swift
//  TCA-tutorial
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Store

// 1Feature = 1ReducerProtocol
struct CounterFeature: ReducerProtocol {
    // State は Equatable型に準拠しておく必要がある
    struct State: Equatable {
        var count = 0
    }
    
    /*
     Tip
         - It is best to name the Action cases after literally what the user does in the UI, such as incrementButtonTapped, rather than what logic you want to perform, such as incrementCount.
         - Actionケースには、incrementCountのような実行したいロジックではなく、incrementButtonTappedのように、文字通りユーザーがUIで行うことにちなんだ名前をつけるのがベストだ。
     */
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    /*
     Note
        - The reduce method takes State as an argument and it is marked as inout. This means you can make any mutations you want directly to the state. There is no need to make a copy of the state just to return it.
        - reduceメソッドはStateを引数にとり、inout(※)としてマークされる。つまり、ステートに直接好きな変異を加えることができる。ステートを返すためだけにそのコピーを作成する必要はない。
     
        ※ into, inout: 参照渡し, 関数の中でその引数に変更を加えた場合、呼び出し側の元の変数にも変更が適用される
     */
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none   // Effectを実行する必要がないため .none を返す
            
        case .incrementButtonTapped:
            state.count -= 1
            return .none
        }
    }
}

// MARK: - View

struct ConunterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 } ) { viewStore in
            VStack {
                Text("0")
                    .font(.largeTitle)
                    .padding()
                
                HStack(spacing: 18) {
                    // decrementButton
                    Button(action: {
                        // decrementButton が押された時の処理
                        
                    }, label: {
                        Text("-")
                    })
                    
                    // incrementButton
                    Button(action: {
                        // incrementButton が押された時の処理
                        
                    }, label: {
                        Text("+")
                    })
                }
            }
        }
    }
}

struct ConunterView_Previews: PreviewProvider {
    static var previews: some View {
        ConunterView(
            store: Store(initialState: CounterFeature.State(), reducer: {
                CounterFeature()
            })
        )
    }
}



