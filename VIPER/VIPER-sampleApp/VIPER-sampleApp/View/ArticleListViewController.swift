//
//  ArticleListViewController.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/23.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    // プロトコルを通して ArticleListPresenter を呼び出す
    var presenter: ArticleListPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    // WebAPIのJSONから受け取るデータ型の配列を定義
    // セルの作成時に使用する
    private var articleEntities = [ArticleEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()   // 画面描画時, Presenter から呼び出し
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articleEntities[indexPath.row].title
        print(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// Presenter 作成時に、作成
// View のプロトコルを準拠する
extension ArticleListViewController: ArticleListViewProtocol {
    
    func showArticles(_ articleEntities: [ArticleEntity]) {
        self.articleEntities = articleEntities
        tableView.reloadData()   // 再ロード
    }
    
    func showEmpty() {
        showArticles([])
    }
    
    func showError(_ error: Error) {
        // 今回はスキップ
    }
    
}



