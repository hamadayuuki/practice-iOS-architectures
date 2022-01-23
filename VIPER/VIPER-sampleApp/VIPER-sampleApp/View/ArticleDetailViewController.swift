//
//  ArticleDetailViewController.swift
//  VIPER-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/23.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    enum Row: String {
        case title
        case body
        
        static var rows: [Row] {
            return [.title, .body]
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ArticleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.rawValue, for: indexPath)
        
        if row == .title {
            cell.textLabel?.text = "タイトル"
            cell.detailTextLabel?.text = "記事のタイトル"
        }
        if row == .body {
            cell.textLabel?.text = "記事の本文"
            cell.detailTextLabel?.text = nil
        }
        
        return cell
    }
    
    
}
