//
//  RegisterViewController.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    let emailTextField = RegisterTextField(placeholder: "メールアドレス")
    let passwordTextField = RegisterTextField(placeholder: "パスワード")
    let registerButton = RegisterButton()
    
    let disposeBag = DisposeBag()
    let registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBinding()
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        
        let registerVerticalView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        registerVerticalView.axis = .vertical
        registerVerticalView.distribution = .fillEqually   // 要素の大きさを均等にする
        registerVerticalView.spacing = 50
        
        view.addSubview(registerVerticalView)
        registerVerticalView.snp.makeConstraints { make -> Void in
            make.centerX.equalTo(view.bounds.width / 2)
            make.top.equalTo(view.bounds.height * 0.2)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make -> Void in
            make.centerX.equalTo(view.bounds.width / 2)
            make.top.equalTo(registerVerticalView.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
    
    private func setupBinding() {
        
        emailTextField.rx.text   // 入力を受け取る
            .asDriver()
            .drive { [weak self] text in
                self?.registerViewModel.mailTextInput.onNext(text ?? "")   // VM に通知
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text   // 入力を受け取る
            .asDriver()
            .drive { [weak self] text in
                self?.registerViewModel.passwordTextInput.onNext(text ?? "")   // VM に通知
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                print("登録ボタンが押された")
                // FireAuth への登録処理
            }
            .disposed(by: disposeBag)
        
        registerViewModel.resultRegisterDriver
            .drive { result in
                self.registerButton.isEnabled = result   // ボタンの反応
                self.registerButton.backgroundColor = result ? .orange : .blue
            }
            .disposed(by: disposeBag)
    }
}

