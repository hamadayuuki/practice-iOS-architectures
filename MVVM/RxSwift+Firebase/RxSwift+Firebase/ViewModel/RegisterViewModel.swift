//
//  RegisterViewModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import UIKit
import RxSwift
import RxCocoa

//protocol registerInput {
//    var mailTextInput: AnyObserver<String> { get }
//    var passwordTextInput: AnyObserver<String> { get }
//}
//
//protocol registerOutput {
//    var mailTextOutput: PublishSubject<String> { get }
//    var passwordTextOutput: PublishSubject<String> { get }
//}
//
//class RegisterViewModel: registerInput, registerOutput {
//    // Input
//    var mailTextInput: AnyObserver<String> {
//        mailTextOutput.asObserver()
//    }
//    var passwordTextInput: AnyObserver<String> {
//        passwordTextOutput.asObserver()
//    }
//    var resultRegisterSubject = BehaviorSubject<Bool>(value: false)
//
//    // Output
//    var mailTextOutput = PublishSubject<String>()
//    var passwordTextOutput = PublishSubject<String>()
//    var resultRegisterDriver: Driver<Bool> = Driver.never()
//
//    private let disposeBag = DisposeBag()
//    let registerModel = FireAuthModel()
//
//    init() {
//
//        resultRegisterDriver = resultRegisterSubject
//            .asDriver(onErrorDriveWith: Driver.empty())
//
//        let mailResult = mailTextOutput
//            .asObservable()
//            .map { mail in
//                return mail.count > 0
//            }
//
//        let passwordResult = passwordTextOutput
//            .asObservable()
//            .map { password in
//                return password.count >= 8
//            }
//
//        Observable
//            .combineLatest(mailResult, passwordResult) { $0 && $1 }
//            .subscribe { result in
//                self.resultRegisterSubject.onNext(result)   // 受信へ通知を送ると同時に送信を行っている
//            }
//            .disposed(by: disposeBag)
//    }
//
//    static func createUser(email: String, password: String) {
//        FireAuthModel.createUserToFireAuth(email: email, password: password)
//    }
//}

class RegisterViewModel {
    let emailValidation: Driver<ValidationResult>
    let passwordValidation: Driver<ValidationResult>
    let passwordConfirmValidation: Driver<ValidationResult>
    
    let isSignUp: Driver<Bool>
    let canSignUp: Driver<Bool>
    
    let disposeBag = DisposeBag()   // ここで初期化しないと 処理が走らない場合あり
    
    // input: V から通知を受け取れるよう、初期化
    init(input: (
        email: Driver<String>,
        password: Driver<String>,
        passwordConfirm: Driver<String>,
        signUpTaps: Signal<Void>   // tap を受け取るときは Signal
    ), signUpAPI: FireAuthModel) {
        
        // M とのつながり
        let registerModel = RegisterValidationModel()
        
        // V からの通知(データも?)を受け取り M に処理を任せる, V から呼ばれることでデータ送信(VM→V)を行える
        emailValidation = input.email
            .map { email in
                registerModel.ValidateEmail(email: email)
            }
        passwordValidation = input.password
            .map { password in
                registerModel.ValidatePassword(password: password)
            }
        passwordConfirmValidation = Driver.combineLatest(input.password, input.passwordConfirm)
            .map { (password, passwordConfirm) in
                registerModel.ValidatePasswordConfirm(password: password, passwordConfirm: passwordConfirm)
            }
        
        // アカウント作成
        let emailAndPassword = Driver.combineLatest(input.email, input.password) { (email: $0, password: $1) }
        let result = input.signUpTaps
            .asObservable()
            .withLatestFrom(emailAndPassword)
            .flatMapLatest { tuple in
                signUpAPI.createUserToFireAuth(email: tuple.email, password: tuple.password)
            }
            .share(replay: 1)
        
        // M でのアカウント登録結果を受け取り、V に渡している, M→VM, VM→M
        isSignUp = result
            .filter { $0 != nil }
            .map { result in return result }
            .asDriver(onErrorJustReturn: false )
        
        // アカウント作成可能か
        // ! ここに isSignUp をいれないと、アカウント登録が呼ばれない → 実装を変更する必要あり
        canSignUp = Driver.combineLatest(emailValidation, passwordValidation, passwordConfirmValidation){ (email, password, passwordConfirm) in
            registerModel.ValidateCanRegister(emailIsValid: email.isValid, passwordIsValid: password.isValid, passwordConfirmIsValid: passwordConfirm.isValid)
        }
        .distinctUntilChanged()
    }
}
