//
//  UITextField+Qs.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension UITextField {
    /// 设置占位字符的颜色
    func qs_placeholder(color: UIColor) {
        var change = false
        
        // 保证有占位文字
        if placeholder == nil {
            placeholder = " "
            change = true
        }
        
        // 设置占位文字颜色
        setValue(color, forKeyPath: "placeholderLabel.textColor")
        
        // 恢复原状
        if change {
            placeholder = nil
        }
    }
}
