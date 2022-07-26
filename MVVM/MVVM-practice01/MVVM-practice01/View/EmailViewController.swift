//
//  EmailViewController.swift
//  MVVM-practice01
//
//  Created by 濵田　悠樹 on 2022/07/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EmailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - UI Parts
    var emailLabel = EmailLabel(text: "")
    var emailTextField = EmailTextField(text: "")

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBinding()
    }
    
    // MARK: - Functions
    func setupLayout() {
        view.backgroundColor = .yellow
        
        // MARK: - addSubview/layer
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make -> Void in
            // 大きさ
            make.height.equalTo(self.view.bounds.height * 0.1)
            make.width.equalTo(self.view.bounds.width * 0.5)
            // 座標
            make.centerY.equalTo(self.view.bounds.height * 0.45)
            make.centerX.equalTo(self.view.bounds.width * 0.5)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make -> Void in
            // 大きさ
            make.height.equalTo(self.view.bounds.height * 0.1)
            make.width.equalTo(self.view.bounds.width * 0.5)
            // 座標
            make.centerY.equalTo(self.view.bounds.height * 0.6)
            make.centerX.equalTo(self.view.bounds.width * 0.5)
        }
    }
    
    func setupBinding() {
        // VM への接続
        let emailViewModel = EmailViewModel(emailTextField: emailTextField.rx.text.orEmpty.asDriver())
        
        // VM のデータ変更を同期的に処理
        emailViewModel.result
            .drive { text in
                //print(text)
                self.emailLabel.text = text
            }
            .disposed(by: disposeBag)   // disposeBag は上で宣言ずみ
    }


}

