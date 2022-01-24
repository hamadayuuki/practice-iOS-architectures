//
//  ArticleDetailPresenter.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation

protocol ArticleDetailPresenterProtocol: AnyObject {
    
    func didLoad(articleEntity: ArticleEntity)
}

protocol ArticleDetailViewProtocol: AnyObject {
    
    func showArticle(_ articleEntity: ArticleEntity)
    func showError(_ erro: Error)
}

class ArticleDetailPresenter {
    
    struct Dependency {
        let getArticleByIdUseCase: UseCase<Int, ArticleEntity, Error>
    }
    
    weak var view: ArticleDetailViewProtocol!
    var di: Dependency
    
    init(view: ArticleDetailViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
    
}

// 重要, DetailPresenter のプロトコルを準拠する
extension ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    
    func didLoad(articleEntity: ArticleEntity) {
        // Interactor への要求, データを受け取る
        // ! Presenter で GetArticlesArrayUseCase() を呼び出している = 蜜結合
        //   → GetArticlesArrayUseCase() を di.getArticlesArrayUseCase に変更 = 疎結合
        di.getArticlesArrayUseCase.execute(articleEntity.id){ [weak self] result in
            guard let self = self else { return }
            
            // View を作成, Interactor からのデータによって条件分岐
            switch result {
            case .success(let articleEntity):
                self.view.showArticle(articleEntity)
            case .failure(let error):
                self.view.showError(error)
                
            }
        }
    }
    
    
    
}
