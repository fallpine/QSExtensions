//
//  QSTextView+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSTextView {
    /// 设置背景颜色
    @discardableResult
    override func qs_backgroundColor(_ color: UIColor) -> QSTextView {
        return super.qs_backgroundColor(color) as! QSTextView
    }
    
    /// 设置文字
    @discardableResult
    override func qs_text(_ text: String) -> QSTextView {
        return super.qs_text(text) as! QSTextView
    }
    
    /// 设置文字颜色
    @discardableResult
    override func qs_textColor(_ color: UIColor) -> QSTextView {
        return super.qs_textColor(color) as! QSTextView
    }
    
    /// 设置文字字体大小
    @discardableResult
    override func qs_font(_ font: UIFont) -> QSTextView {
        return super.qs_font(font) as! QSTextView
    }
    
    /// 设置文字对齐方式
    @discardableResult
    override func qs_textAlignment(_ alignment: NSTextAlignment) -> QSTextView {
        return super.qs_textAlignment(alignment) as! QSTextView
    }
    
    /// 设置键盘样式
    @discardableResult
    override func qs_keyboardType(_ type: UIKeyboardType) -> QSTextView {
        return super.qs_keyboardType(type) as! QSTextView
    }
    
    /// 设置占位文字
    @discardableResult
    func qs_placeholder(_ placeholder: String) -> QSTextView {
        self.qs_placeholder = placeholder
        return self
    }

    /// 设置占位文字颜色
    @discardableResult
    func qs_placeholderColor(_ color: UIColor) -> QSTextView {
        self.qs_placeholderColor = color
        return self
    }

    /// 设置占位文字字体大小
    @discardableResult
    func qs_placeholderFont(_ font: UIFont) -> QSTextView {
        self.qs_placeholderFont = font
        return self
    }
    
    /// 设置垂直对齐方式
    @discardableResult
    func qs_textVerticalAlignment(_ alignment: QSTextVerticalAlignment) -> QSTextView {
        self.textVerticalAlignment = alignment
        return self
    }
    
    /// 设置内边距
    @discardableResult
    func qs_contentInset(_ contentInset: UIEdgeInsets) -> QSTextView {
        self.qs_contentInset = contentInset
        return self
    }
    
    /// 限制输入字符的长度
    @discardableResult
    func qs_limitCount(_ count: UInt) -> QSTextView {
        self.qs_limitCount = count
        return self
    }
}
