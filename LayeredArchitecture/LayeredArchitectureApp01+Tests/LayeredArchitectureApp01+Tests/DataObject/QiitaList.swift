//
//  QiitaList.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/04.
//

// 参考: https://qiita.com//api/v2/items?query=swiftUI&page=1&per_page=50

public struct QiitaList: Codable, Identifiable {
    public var id: String
    public var title: String
    public var url: String
    public var likes_count: Int
    
    init(id: String, title: String, url: String, likes_count: Int) {
        self.id = id
        self.title = title
        self.url = url
        self.likes_count = likes_count
    }
}
