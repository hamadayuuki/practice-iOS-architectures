//
//  RegisterValidationModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/15.
//

import RxSwift
import RxCocoa

// データの状態を確認して、返す
class RegisterValidationModel {
    
    //                                   ↓ データの状態(enum)
    func ValidateEmail(email: String) -> ValidationResult {
        if (email.count == 0) { return .empty(message: "") }
        if !(email.contains("@")) { return .failed(message: "メールアドレスの形式が間違えてます") }
        return .ok(message: "OK")
    }
    
    func ValidatePassword(password: String) -> ValidationResult {
        if (password.count == 0) { return .empty(message: "") }
        if (password.count < 8) { return .failed(message: "8文字以上にしてください") }
        return .ok(message: "OK")
    }
    
    func ValidatePasswordConfirm(password: String, passwordConfirm: String) -> ValidationResult {
        if !(password == passwordConfirm) { return .failed(message: "確認用パスワードが間違えています") }
        return .ok(message: "OK")
    }
}
