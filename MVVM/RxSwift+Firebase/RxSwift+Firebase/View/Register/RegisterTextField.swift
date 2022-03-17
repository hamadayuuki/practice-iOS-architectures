//
//  RegisterTextField.swift
//  RxSwift+Firebasee
//
//  Created by 濵田　悠樹 on 2022/03/13.
//

import UIKit
import SnapKit

class RegisterTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let width = 270
        let height = 50
        let paddingFrame = CGRect(x:0, y:0, width: 5, height: height)
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)   // 下線のため
        self.placeholder = placeholder
        self.font = .systemFont(ofSize: 20)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 3.0
        self.leftView = UIView(frame: paddingFrame)   // 左に余白を追加
        self.leftViewMode = .always
        self.rightView = UIView(frame: paddingFrame)   // 右に余白を追加
        self.rightViewMode = .always
//        setUnderLine(color: .orange, thickness: 0.5)
        
        self.snp.makeConstraints { make -> Void in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextField {
    func setUnderLine(color: UIColor, thickness: CGFloat) {
        print("frame: ", frame)
        // 枠線を非表示にする
        borderStyle = .none
        let underline = UIView()
        // heightにはアンダーラインの高さを入れる, 標準が 0.5
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: thickness)
        // 枠線の色
        underline.backgroundColor = color
        addSubview(underline)
        // 枠線を最前面に
        bringSubviewToFront(underline)
    }
}
