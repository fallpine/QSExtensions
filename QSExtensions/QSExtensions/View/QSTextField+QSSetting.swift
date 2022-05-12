//
//  QSTextField+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSTextField {
    /// 设置背景颜色
    @discardableResult
    override func qs_backgroundColor(_ color: UIColor) -> QSTextField {
        return super.qs_backgroundColor(color) as! QSTextField
    }
    
    /// 设置文字
    @discardableResult
    override func qs_text(_ text: String) -> QSTextField {
        return super.qs_text(text) as! QSTextField
    }
    
    /// 设置文字颜色
    @discardableResult
    override func qs_textColor(_ color: UIColor) -> QSTextField {
        return super.qs_textColor(color) as! QSTextField
    }
    
    /// 设置文字字体大小
    @discardableResult
    override func qs_font(_ font: UIFont) -> QSTextField {
        return super.qs_font(font) as! QSTextField
    }
    
    /// 设置占位文字
    @discardableResult
    override func qs_placeholder(_ placeholder: String) -> QSTextField {
        return super.qs_placeholder(placeholder) as! QSTextField
    }
    
    /// 设置占位文字颜色
    @discardableResult
    override func qs_placeholderColor(_ color: UIColor) -> QSTextField {
        return super.qs_placeholderColor(color) as! QSTextField
    }
    
    /// 设置文字对齐方式
    @discardableResult
    override func qs_textAlignment(_ alignment: NSTextAlignment) -> QSTextField {
        return super.qs_textAlignment(alignment) as! QSTextField
    }
    
    /// 设置键盘样式
    @discardableResult
    override func qs_keyboardType(_ type: UIKeyboardType) -> QSTextField {
        return super.qs_keyboardType(type) as! QSTextField
    }
    
    /// 限制输入字符的长度
    @discardableResult
    func qs_limitCount(_ count: UInt) -> QSTextField {
        self.qs_limitCount = count
        return self
    }
    
    /// 限制小数位数
    @discardableResult
    func qs_limitDecimalCount(_ count: UInt) -> QSTextField {
        self.qs_limitDecimalCount = count
        return self
    }
}
