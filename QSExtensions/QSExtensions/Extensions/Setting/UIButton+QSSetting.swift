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
    @discardableResult
    func qs_setBackgroundColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        let bgImage = UIImage.qs_image(with: color, size: UIScreen.main.bounds.size)
        setBackgroundImage(bgImage, for: state)
        return self
    }
    
    /// 设置文字
    @discardableResult
    func qs_setTitle(_ title: String, for state: UIControl.State) -> UIButton {
        setTitle(title, for: state)
        return self
    }
    
    /// 设置文字字体大小
    @discardableResult
    func qs_setTitleFont(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    /// 设置文字颜色
    @discardableResult
    func qs_setTitleColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 设置图片
    @discardableResult
    func qs_setImage(_ imageName: String, for state: UIControl.State) -> UIButton {
        qs_setImage(imageName, state: state)
        return self
    }
    
    /// 设置背景图片
    @discardableResult
    func qs_setBackgroundImage(_ imgName: String, for state: UIControl.State) -> UIButton {
        qs_setBackgroundImage(imgName, state: state)
        return self
    }
}
