//
//  APIRequest.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/04.
//

import Foundation


class APIRequest {
    @Published var items = [Decodable]()   // ここを外部から参照する
    private let qiitaURL = "https//qiita.com/api/v2"
    
    //         ↓ APIから受け取るデータの型を可変にしている
    func fetch<T: Codable>(_: T, query: String) {
        let url = URL(string: "\(qiitaURL)/items?query=\(query)&page=1&per_page=50")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let items = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        self.items = items as! [Decodable]
                    }
                }
            } catch {
                print("APIからのデータ取得でエラー発生")
            }
        }
        .resume()
    }
}
