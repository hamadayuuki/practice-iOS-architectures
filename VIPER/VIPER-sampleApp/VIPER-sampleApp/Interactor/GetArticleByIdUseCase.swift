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
        
        // WebAPIからJSON形式でデータを受け取る
        // 詳細画面に表示するデータ
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(parameter)")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            guard let data = data, let decoded = try? JSONDecoder().decode(ArticleEntity.self, from: data)
            else {
                let error = NSError(
                    domain: "parse-error",
                    code: 1,
                    userInfo: nil
                )
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(.success(decoded))
            }
        }
        task.resume()
    }
}
