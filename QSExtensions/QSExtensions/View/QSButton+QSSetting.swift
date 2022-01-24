//
//  QSButton+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSButton {
    /// 设置背景颜色
    func qs_setBackgroundColor(_ color: UIColor, for state: QSButtonState) -> QSButton {
        qs_setBackgroundColor(color, state: state)
        return self
    }
    
    /// 设置文字
    func qs_setTitle(_ title: String, for state: QSButtonState) -> QSButton {
        qs_setTitle(title, state: state)
        return self
    }
    
    /// 设置文字字体大小
    func qs_setFont(_ font: UIFont, for state: QSButtonState) -> QSButton {
        qs_setTitleFont(font, state: state)
        return self
    }
    
    /// 设置文字颜色
    func qs_setTitleColor(_ color: UIColor, for state: QSButtonState) -> QSButton {
        qs_setTitleColor(color, state: state)
        return self
    }
    
    /// 设置图片
    func qs_setImage(_ image: UIImage?, for state: QSButtonState) -> QSButton {
        qs_setImage(image, state: state)
        return self
    }
    
    /// 设置内边距
    func qs_setContentInset(_ contentInset: UIEdgeInsets) -> QSButton {
        self.contentInset = contentInset
        return self
    }
}
