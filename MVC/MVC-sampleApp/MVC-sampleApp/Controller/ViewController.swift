//
//  ViewController.swift
//  MVC-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/16.
//

import UIKit

// Model(Model.swift)で定義した変数を使い、View(Cell.swift)を更新する
// 【流れ】
// ①: Model(Model.swift) で定義した変数を使用して、Data.swift から画像データを取得する
// ②: ①で取得したデータを、View(Cell.swift) へ伝える
class ViewController: UIViewController {

    var dataList = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Model 型のデータを受け取る
        dataList = Data.getAllData()
    }

}

// View を生成する, Model 型のデータを使用して
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // セルの個数
    // 設置必須な関数 (CollectionViewを使用する場合)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    // セルの作成
    // 設置必須な関数 (CollectionViewを使用する場合)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell.swift の UIコンポーネント(image, label)に代入していく
        // 画像を表示する際に詰まったこと: https://qiita.com/yoshikoba/items/044925f554b75c53d27c
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.image.image = dataList[indexPath.row].image   // image の更新
        cell.image.contentMode = .scaleAspectFill
        cell.image.clipsToBounds = true
        cell.label.text = dataList[indexPath.row].imageName   // label の更新
        return cell
    }
    
}

