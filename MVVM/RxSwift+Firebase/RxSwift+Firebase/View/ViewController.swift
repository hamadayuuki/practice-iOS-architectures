//
//  ViewController.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import UIKit
import RxSwift
import SnapKit

class ViewController: UIViewController {

    // 数字を表示
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }()
    
    let viewModel = FireStoreViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBinding()
    }
    
    // 画面のレイアウト
    private func setupLayout() {
        view.backgroundColor = .yellow
        view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    // RxSwift でのデータバインディング
    private func setupBinding() {
        viewModel.featchFireStore()
            .subscribe(onNext: { [weak self] num in
                print(num)
                self?.countLabel.text = String(num)
            })
            .disposed(by: disposeBag)
    }


}

