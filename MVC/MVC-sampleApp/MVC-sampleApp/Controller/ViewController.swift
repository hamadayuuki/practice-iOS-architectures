//
//  ViewController.swift
//  MVC-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {

    var dataList = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataList = Data.getAllData()
        
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // セルの個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    // セルの作成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell.swift の View情報を使用する (image, label)
        // 画像を表示する際に詰まったこと: https://qiita.com/yoshikoba/items/044925f554b75c53d27c
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.image.image = dataList[indexPath.row].image
        cell.image.contentMode = .scaleAspectFill
        cell.image.clipsToBounds = true
        cell.label.text = dataList[indexPath.row].imageName
        return cell
    }
    
    
    
}

