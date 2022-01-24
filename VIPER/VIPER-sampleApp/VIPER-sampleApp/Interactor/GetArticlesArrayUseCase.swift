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
        
        // WebAPIからJSON形式でデータを受け取る
        // 一覧画面に表示するデータ
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            guard let data = data, let decoded = try? JSONDecoder().decode([ArticleEntity].self, from: data)
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
