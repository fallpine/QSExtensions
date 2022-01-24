//
//  UITextField+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UITextField {
    /// 设置背景颜色
    func qs_backgroundColor(_ color: UIColor) -> UITextField {
        backgroundColor = color
        return self
    }
    
    /// 设置文字
    func qs_text(_ text: String) -> UITextField {
        self.text = text
        return self
    }
    
    /// 设置文字颜色
    func qs_textColor(_ color: UIColor) -> UITextField {
        textColor = color
        return self
    }
    
    /// 设置文字字体大小
    func qs_font(_ font: UIFont) -> UITextField {
        self.font = font
        return self
    }
    
    /// 设置占位文字
    func qs_placeholder(_ placeholder: String) -> UITextField {
        self.placeholder = placeholder
        return self
    }
    
    /// 设置占位文字颜色
    func qs_placeholderColor(_ color: UIColor) -> UITextField {
        self.qs_placeholder(color: color)
        return self
    }
    
    /// 设置文字对齐方式
    func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextField {
        textAlignment = alignment
        return self
    }
    
    /// 设置键盘样式
    func qs_keyboardType(_ type: UIKeyboardType) -> UITextField {
        keyboardType = type
        return self
    }
}
