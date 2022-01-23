//
//  GetArticlesArrayUseCase.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation

// WebAPIから送られるデータを受け取り、ArticleEntity型にして返すもの
// UseCase を参照する
class GetArticlesArrayUseCase: UseCaseProtocol {
    
    // UsecaseProtocol で定義されていた execute関数 を実装する
    func execute(_ parameter: Void, completion: ((Result<[ArticleEntity], Error>) -> ())?) {
        
        // 本当はWebAPIのレスポンスが入る
        // 今回はクラス間のデータやり取りを確認するため、データを自分で定義しておく
        let res: [ArticleEntity] = [
            ArticleEntity(id: 1, userId: 1, title: "タイトル1", body: "本文1"),
            ArticleEntity(id: 2, userId: 2, title: "タイトル2", body: "本文2"),
            ArticleEntity(id: 3, userId: 3, title: "タイトル3", body: "本文3")
        ]
        // 呼び出しもとに結果を返す
        completion?(.success(res))
    }
}
