//
//  ViewController.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let fireStoreModel = FireStoreModel()
        fireStoreModel.featchFireStore()
    }


}

