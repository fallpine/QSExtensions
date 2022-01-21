//
//  UIButton+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UIButton {
    /// 设置背景颜色
    func qs_setBackgroundColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        let bgImage = UIImage.qs_image(with: color, size: UIScreen.main.bounds.size)
        setBackgroundImage(bgImage, for: state)
        return self
    }
    
    /// 设置文字
    func qs_setTitle(_ title: String, for state: UIControl.State) -> UIButton {
        setTitle(title, for: state)
        return self
    }
    
    /// 设置文字字体大小
    func qs_setFont(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    /// 设置文字颜色
    func qs_setTitleColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 设置图片
    func qs_setImage(_ image: UIImage?, for state: UIControl.State) -> UIButton {
        setImage(image, for: state)
        return self
    }
    
    /// 设置背景图片
    func qs_setBackgroundImage(_ image: UIImage?, for state: UIControl.State) -> UIButton {
        setBackgroundImage(image, for: state)
        return self
    }
}
