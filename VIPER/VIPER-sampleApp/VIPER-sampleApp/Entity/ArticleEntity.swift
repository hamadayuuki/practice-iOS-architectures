//
//  ArticleEntity.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/23.
//

import Foundation

// webAPIのJSONから返ってくる値に合わせて定義, 型は Codable
struct ArticleEntity: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
