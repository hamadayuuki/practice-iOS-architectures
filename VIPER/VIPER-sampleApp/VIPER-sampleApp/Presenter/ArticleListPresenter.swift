//
//  ArticleListPresenter.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/24.
//

import Foundation

// Presenter のプロトコル
// 画面描画時に実行する関数を定義, 画面表示時にデータを取得して、データを表示するような関数を定義
protocol ArticleListPresenterProtocol: AnyObject {
    func didLoad()   // 画面が表示された時
    func didSelect(articleEntity: ArticleEntity)   // 一覧から記事を選択したとき
}

// View のためのプロトコル
protocol ArticleListViewProtocol: AnyObject {
    func showArticles(_ articleEntities: [ArticleEntity])   // 取得したデータを画面表示する
    func showEmpty()   // データを取得できなかったとき表示する
    func showError(_ error: Error)   // インターネット上で起きるエラーを表示する
}

// SceneDelegate.swift でインスタンス化される
class ArticleListPresenter {
    
    // 依存性注入
    // Presenter の依存先を定義
    struct Dependency {
        let router: ArticleListRouterProtocol!
        let getArticlesArrayUseCase: UseCase<Void, [ArticleEntity], Error>
    }
    
    // Router.swift と同じ
    weak var view: ArticleListViewProtocol!
    private var di: Dependency
    init(view: ArticleListViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
    
}

// 重要, Presenter のプロトコルを準拠する
extension ArticleListPresenter: ArticleListPresenterProtocol {
    
    func didLoad() {
        // Interactor への要求, データを受け取る
        // ! Presenter で GetArticlesArrayUseCase() を呼び出している = 蜜結合
        //   → GetArticlesArrayUseCase() を di.getArticlesArrayUseCase に変更 = 疎結合
        di.getArticlesArrayUseCase.execute( () ){ [weak self] result in
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
    
    // 一覧から選択された時、詳細画面へ遷移する
    // router を使用して画面遷移を行う
    func didSelect(articleEntity: ArticleEntity) {
        di.router.showArticleDetail(articleEntity: articleEntity)
    }
    
}

