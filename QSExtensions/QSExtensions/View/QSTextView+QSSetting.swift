//
//  QSTextView+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSTextView {
    /// 设置占位文字
    func qs_placeholder(_ placeholder: String) -> QSTextView {
        self.qs_placeholder = placeholder
        return self
    }

    /// 设置占位文字颜色
    func qs_placeholderColor(_ color: UIColor) -> QSTextView {
        self.qs_placeholderColor = color
        return self
    }

    /// 设置占位文字字体大小
    func qs_placeholderFont(_ font: UIFont) -> QSTextView {
        self.qs_placeholderFont = font
        return self
    }
    
    /// 设置垂直对齐方式
    func qs_textVerticalAlignment(_ alignment: QSTextVerticalAlignment) -> QSTextView {
        self.textVerticalAlignment = alignment
        return self
    }
    
    /// 设置内边距
    func qs_contentInset(_ contentInset: UIEdgeInsets) -> QSTextView {
        self.qs_contentInset = contentInset
        return self
    }
    
    /// 限制输入字符的长度
    func qs_limitTextLength(_ length: Int) -> QSTextView {
        self.qs_limitTextLength = length
        return self
    }
    
    /// 是否允许输入emoji
    func qs_isAllowEmoji(_ isAllow: Bool) -> QSTextView {
        self.qs_isAllowEmoji = isAllow
        return self
    }
}
