//
//  ArticleListRouter.swift
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
    
    // 記事詳細画面を生成
    func showArticleDetail(articleEntity: ArticleEntity) {
        guard let articleDetailViewController = UIStoryboard(name: "ArticleDetail", bundle: nil).instantiateInitialViewController() as? ArticleDetailViewController else {
            fatalError()
        }
        
        articleDetailViewController.articleEntity = articleEntity
        
        articleDetailViewController.presenter = ArticleDetailPresenter(
            view: articleDetailViewController,
            inject: ArticleDetailPresenter.Dependency(
                getArticleByIdUseCase: UseCase(GetArticleByIdUseCase() ))
        )
        
        // 作成した View を push する
        view.navigationController?.pushViewController(
            articleDetailViewController,
            animated: true
        )
    }
}
