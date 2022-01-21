//
//  UILable+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UILabel {
    /// 设置背景颜色
    func qs_backgroundColor(_ color: UIColor) -> UILabel {
        self.backgroundColor = color
        return self
    }
    
    /// 设置文字
    func qs_text(_ text: String) -> UILabel {
        self.text = text
        return self
    }
    
    /// 设置文字颜色
    func qs_textColor(_ color: UIColor) -> UILabel {
        textColor = color
        return self
    }
    
    /// 设置文字字体
    func qs_font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    /// 设置文字对其方式
    func qs_textAlignment(_ alignment: NSTextAlignment) -> UILabel {
        textAlignment = alignment
        return self
    }
    
    /// 设置文字行数
    func qs_numberOfLines(_ lines: Int) -> UILabel {
        numberOfLines = lines
        return self
    }
}
