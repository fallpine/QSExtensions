//
//  UITextView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UITextView {
    /// 设置背景颜色
    @discardableResult
    @objc open func qs_backgroundColor(_ color: UIColor) -> UITextView {
        backgroundColor = color
        return self
    }
    
    /// 设置文字
    @discardableResult
    @objc open func qs_text(_ text: String) -> UITextView {
        self.text = text
        return self
    }
    
    /// 设置文字颜色
    @discardableResult
    @objc open func qs_textColor(_ color: UIColor) -> UITextView {
        textColor = color
        return self
    }
    
    /// 设置文字字体大小
    @discardableResult
    @objc open func qs_font(_ font: UIFont) -> UITextView {
        self.font = font
        return self
    }
    
    /// 设置文字对齐方式
    @discardableResult
    @objc open func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextView {
        textAlignment = alignment
        return self
    }
    
    /// 设置键盘样式
    @discardableResult
    @objc open func qs_keyboardType(_ type: UIKeyboardType) -> UITextView {
        keyboardType = type
        return self
    }
}
