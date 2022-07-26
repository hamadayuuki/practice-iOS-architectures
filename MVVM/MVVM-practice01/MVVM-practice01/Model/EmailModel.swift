//
//  EmailModel.swift
//  MVVM-practice01
//
//  Created by 濵田　悠樹 on 2022/07/25.
//

import RxSwift
import RxCocoa

class EmailModel {
    
    // VM からの接続, VMから呼び出されることで接続を行うイメージ
    // TODO: - 戻り値を Observable<String> にする, VM-M の関係をリアクティブにするため
    func addQuestionMark(text: String) -> String {
        return text + "?"
    }
}
