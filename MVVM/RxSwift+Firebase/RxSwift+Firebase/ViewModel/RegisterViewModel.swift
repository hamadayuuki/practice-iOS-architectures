//
//  RegisterViewModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import UIKit
import RxSwift
import RxCocoa

protocol registerInput {
    var mailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol registerOutput {
    var mailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }
}

class RegisterViewModel: registerInput, registerOutput {
    // Input
    var mailTextInput: AnyObserver<String> {
        mailTextOutput.asObserver()
    }
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    var resultRegisterSubject = BehaviorSubject<Bool>(value: false)
    
    // Output
    var mailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var resultRegisterDriver: Driver<Bool> = Driver.never()
    
    private let disposeBag = DisposeBag()
    let registerModel = FireAuthModel()
    
    init() {
        
        resultRegisterDriver = resultRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let mailResult = mailTextOutput
            .asObservable()
            .map { mail in
                return mail.count > 0
            }
        
        let passwordResult = passwordTextOutput
            .asObservable()
            .map { password in
                return password.count >= 8
            }
        
        Observable
            .combineLatest(mailResult, passwordResult) { $0 && $1 }
            .subscribe { result in
                self.resultRegisterSubject.onNext(result)   // 受信へ通知を送ると同時に送信を行っている
            }
            .disposed(by: disposeBag)
    }
    
    static func createUser(email: String, password: String) {
        FireAuthModel.createUserToFireAuth(email: email, password: password)
    }
}
