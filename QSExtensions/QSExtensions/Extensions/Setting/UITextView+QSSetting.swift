//
//  UITextView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UITextView {
    /// 设置文字
    public func qs_text(_ text: String) -> UITextView {
        self.text = text
        return self
    }
    
    /// 设置文字颜色
    public func qs_textColor(_ color: UIColor) -> UITextView {
        textColor = color
        return self
    }
    
    /// 设置文字字体大小
    public func qs_font(_ font: UIFont) -> UITextView {
        self.font = font
        return self
    }
    
    /// 设置占位文字
    public func qs_placeholder(_ placeholder: String) -> UITextView {
        self.qs_placeholder = placeholder
        return self
    }
    
    /// 设置占位文字颜色
    public func qs_placeholderColor(_ color: UIColor) -> UITextView {
        self.qs_placeholderColor = color
        return self
    }
    
    /// 设置占位文字字体大小
    public func qs_placeholderFont(_ font: UIFont) -> UITextView {
        self.qs_placeholderFont = font
        return self
    }
    
    /// 设置文字对齐方式
    public func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextView {
        self.textAlignment = alignment
        return self
    }
    
    /// 设置键盘样式
    public func qs_keyboardType(_ type: UIKeyboardType) -> UITextView {
        keyboardType = type
        return self
    }
}
