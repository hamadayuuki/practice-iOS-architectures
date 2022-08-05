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
    
    //         ↓ APIから受け取るデータの型を可変にしている, RequestComponentを挟んで ~~RequestComponent を呼び出す
    public func fetch<T: RequestComponent>(component: T) {
        let url = URL(string: "\(qiitaURL)/items?query=\(component.query)&page=1&per_page=50")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    //                             ↓ なぜ component ではなく T なのか
                    let items = try decoder.decode(T.type.self, from: data)
                    DispatchQueue.main.async {
                        self.items = items as! [Decodable]
                        print(self.items)
                    }
                }
            } catch {
                print("APIからのデータ取得でエラー発生")
            }
        }
        .resume()
    }
}
