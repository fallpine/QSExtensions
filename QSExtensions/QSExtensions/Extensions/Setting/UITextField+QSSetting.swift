//
//  UITextField+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UITextField {
    /// 设置文字
    public func qs_text(_ text: String) -> UITextField {
        self.text = text
        return self
    }
    
    /// 设置文字颜色
    public func qs_textColor(_ color: UIColor) -> UITextField {
        textColor = color
        return self
    }
    
    /// 设置文字字体大小
    public func qs_font(_ font: UIFont) -> UITextField {
        self.font = font
        return self
    }
    
    /// 设置占位文字
    public func qs_placeholder(_ placeholder: String) -> UITextField {
        self.placeholder = placeholder
        return self
    }
    
    /// 设置占位文字颜色
    public func qs_placeholderColor(_ color: UIColor) -> UITextField {
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
        
        return self
    }
    
    /// 设置文字对齐方式
    public func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextField {
        textAlignment = alignment
        return self
    }
    
    /// 设置键盘样式
    public func qs_keyboardType(_ type: UIKeyboardType) -> UITextField {
        keyboardType = type
        return self
    }
}
