//
//  Presenter.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation

// Presenter のプロトコル
// 画面描画時に実行する関数を定義, 画面表示時にデータを取得して、データを表示するような関数を定義
protocol ArticleListPresenterProtocol: AnyObject {
    func didLoad()   // 画面が表示された時
    func didSelect(articleEntitiy: ArticleEntity)   // 一覧から記事を選択したとき
}

// View のためのプロトコル
protocol ArticleListViewProtocol: AnyObject {
    func showArticles(_ articleEntities: [ArticleEntity])   // 取得したデータを画面表示する
    func showEmpty()   // データを取得できなかったとき表示する
    func showError(_ error: Error)   // インターネット上で起きるエラーを表示する
}

class ArticleListPresenter {
    
    // Router.swift と同じ
    weak var view: ArticleListViewProtocol!
    init(view: ArticleListViewProtocol) {
        self.view = view
    }
    
}

// 重要, Presenter のプロトコルを準拠する
extension ArticleListPresenter: ArticleListPresenterProtocol {
    
    func didLoad() {
        // Interactor への要求, データを受け取る
        GetArticlesArrayUseCase().execute( () ){ [weak self] result in
            guard let self = self else { return }
            
            // View を作成, Interactor からのデータによって条件分岐
            switch result {
            case .success(let articleEntities):
                if articleEntities.isEmpty {
                    self.view.showEmpty()
                    return
                }
                self.view.showArticles(articleEntities)
            case .failure(let error):
                self.view.showError(error)
                
            }
        }
    }
    
    func didSelect(articleEntitiy: ArticleEntity) {
        <#code#>
    }
    
}

