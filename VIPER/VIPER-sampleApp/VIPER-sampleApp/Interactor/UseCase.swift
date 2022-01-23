//
//  UseCase.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation


// 他の UseCase の参照もとになる
// コードの理解はできていない. コードは 動画(https://youtu.be/ieqNIySokxI) から写経
protocol UseCaseProtocol where Failure: Error {
    associatedtype Parameter
    associatedtype Success
    associatedtype Failure
    
    func execute(_ parameter: Parameter, completion: ((Result<Success, Failure>)
    -> ())?)
}

class UseCase<Parameter, Success, Failure: Error> {
    
    private let instance: UseCaseInstanceBase<Parameter, Success, Failure>
    
    init<T: UseCaseProtocol>(_ useCase: T) where
        T.Parameter == Parameter,
        T.Success == Success,
        T.Failure == Failure
    {
        self.instance = UseCaseInstance<T>(useCase)
    }
    
    func execute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) {
        instance.execute(parameter, completion: completion)
    }
    
}

private extension UseCase {
    class UseCaseInstanceBase<Parameter, Success, Failure: Error> {
        
        func execute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) {
            fatalError()
        }
        
    }
    
    class UseCaseInstance<T: UseCaseProtocol>: UseCaseInstanceBase<T.Parameter, T.Success, T.Failure> {
        
        private let useCase: T
        
        init(_ useCase: T) {
            self.useCase = useCase
        }
        
        override func execute(_ parameter: T.Parameter, completion: ((Result<T.Success, T.Failure>) -> ())?) {
            useCase.execute(parameter, completion: completion)
        }
        
    }
    
}
