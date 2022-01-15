//
//  AmazonData.swift
//  MVC-sampleApp
//
//  Created by 濵田　悠樹 on 2022/01/16.
//

import Foundation
import UIKit

class Data {
    
    static func getAllData() -> [Model] {
        var dataList = [Model]()
        dataList = [
            Model(image: UIImage(named: "image-1"), imageName: "image-1"),
            Model(image: UIImage(named: "image-2"), imageName: "image-2"),
            Model(image: UIImage(named: "image-3"), imageName: "image-3"),
            Model(image: UIImage(named: "image-4"), imageName: "image-4"),
            Model(image: UIImage(named: "image-5"), imageName: "image-5"),
            Model(image: UIImage(named: "image-6"), imageName: "image-6"),
            Model(image: UIImage(named: "image-7"), imageName: "image-7")
        ]
        
        return dataList
    }
    
}
