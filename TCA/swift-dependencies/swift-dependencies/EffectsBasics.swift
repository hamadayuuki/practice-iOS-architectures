//
//  EffectsBasics.swift
//  swift-dependencies
//
//  Created by 濵田　悠樹 on 2023/03/24.
//

import ComposableArchitecture

struct EffectsBasics: ReducerProtocol {
    struct State: Equatable {
        // ・・・
        
        var count = 0
        var numberFact: String?
    }
    
    enum Action: Equatable {
        // ・・・
        
        case numberFactButtonTapped
        case numberFactResponse(TaskResult<String>)
    }
    
    @Dependency(\.factClient) var factClient   // factClient を使えるように呼び出し, \.factClient によって KeyPath が KeyPath<DependencyValues, FactClient> として定まる
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            // ・・・
        case .numberFactButtonTapped:
            // ・・・
            return .task{ [count = state.count] in
                await .numberFactResponse(TaskResult { try await self.factClient.fetch(count) })
            }
        case let .numberFactResponse(.success(response)): break
            // ・・・
        case .numberFactResponse(.failure(_)): break
            // ・・・
        }
        return EffectPublisher<Action, Never>(value: .numberFactButtonTapped)
    }
}
