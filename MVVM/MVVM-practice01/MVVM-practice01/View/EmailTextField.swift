//
//  EmailTextField.swift
//  MVVM-practice01
//
//  Created by 濵田　悠樹 on 2022/07/25.
//

import UIKit

class EmailTextField: UITextField {
    init(text: String) {
        super.init(frame: .zero)   // 魔法の言葉
        
        self.text = text
        
        self.textColor = .white
        self.font = .systemFont(ofSize: 20, weight: .heavy)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }   // 魔法の言葉
}
