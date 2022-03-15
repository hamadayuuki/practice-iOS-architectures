//
//  ValidationResult.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/15.
//

// データの状態
enum ValidationResult {
    case ok(message: String)
    case empty(message: String)
    case validating
    case failed(message: String)

    var description: String {
        switch self {
        case let .ok(message) : return message
        case let .empty(message) : return message
        case .validating : return ""
        case let .failed(message) : return message
        }
    }

    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
