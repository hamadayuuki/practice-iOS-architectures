//
//  AmazonCell.swift
//  MVC-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/16.
//

import UIKit

// 画面(storyboard) で使用する UIコンポーネント を定義
// 【流れ】
// ⓪: Controller(ViewController.swift) が Data.swift から画面描画時に使用するデータを取得する
// ①: Controller(ViewController.swift) で　View(Cell.swift) の値が更新される = View が Controller を監視している状態
// ②: 画面を再描画
class Cell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label: UILabel!
}
