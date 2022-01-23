//
//  Router.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import UIKit

protocol ArticleListRouterProtocol: AnyObject {
    
    func showArticleDetail(articleEntity: ArticleEntity)
}

class ArticleListRouter: ArticleListRouterProtocol {
    
    // 画面遷移のために UIViewController の参照
    weak var view: UIViewController!
    
    // 循環参照を避けるため、逆参照を行う
    init(view: UIViewController) {
        self.view = view
    }
    
    // 後で実装する
    func showArticleDetail(articleEntity: ArticleEntity) {
        print("詳細画面へ画面遷移する 記事ID : \(articleEntity.id)")
    }
}
