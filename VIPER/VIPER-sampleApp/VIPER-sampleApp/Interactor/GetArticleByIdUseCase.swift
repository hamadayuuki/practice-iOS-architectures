//
//  GetArticleByIdUseCase.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation

// APIから記事を指定して一つの記事を取得しArticleEntityを返す
// UseCase を参照する
class GetArticleByIdUseCase: UseCaseProtocol {
    
    // WebAPIに記事IDを渡すため
    // parameter に Int(記事数の型) を渡す
    // Success(成功時) には ArticleEntity単体 を渡す.一つの記事を取得するため
    func execute(_ parameter: Int, completion: ((Result<ArticleEntity, Error>) -> ())?) {
        // 返す結果は一つだけ
        let res = ArticleEntity(id: 1, userId: 1, title: "タイトル1", body: "本文1")
        completion?(.success(res))
    }
}
