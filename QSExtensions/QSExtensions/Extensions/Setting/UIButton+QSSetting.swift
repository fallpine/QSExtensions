//
//  UIButton+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UIButton {
    /// 设置文字
    public func qs_setTitle(_ title: String, for state: UIControl.State) -> UIButton {
        setTitle(title, for: state)
        return self
    }
    
    /// 设置文字字体大小
    public func qs_setFont(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    /// 设置文字颜色
    public func qs_setTitleColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 设置图片
    public func qs_setImage(_ image: UIImage, for state: UIControl.State) -> UIButton {
        setImage(image, for: state)
        return self
    }
    
    /// 设置背景颜色
    public func qs_setBackgroundColor(_ color: UIColor, for state: UIControl.State) -> UIButton {
        let bgImage = qs_createImage(with: color, size: UIScreen.main.bounds.size)
        setBackgroundImage(bgImage, for: state)
        return self
    }
    
    /// 生成一张纯色的图片
    ///
    /// - Parameters:
    ///   - solidColor: 图片颜色
    ///   - size: 图片大小
    private func qs_createImage(with color: UIColor, size: CGSize) -> UIImage? {
        
        let rect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
