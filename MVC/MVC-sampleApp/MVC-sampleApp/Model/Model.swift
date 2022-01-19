//
//  AmazonModel.swift
//  MVC-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/16.
//

import Foundation
import UIKit

// View(Cell.swift)で使用する変数の定義, Controller(ViewController.swif)から変更を受け取る、View(Cell.swift)に監視されている
// 【流れ】
// ①: Controller(ViewController.swift) からの命令で変数の値が更新されていく
// ②: 変数が更新されると View が更新される
struct Model {
    let image: UIImage!
    let imageName: String!
}
