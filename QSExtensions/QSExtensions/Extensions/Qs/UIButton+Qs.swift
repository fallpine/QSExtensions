//
//  UIButton+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//
// 加载网络图片依赖于Kingfisher框架

import UIKit
import Kingfisher

extension UIButton {
    /// 新增属性key
    private struct AssociatedKeys {
        static var actionBlockKey: String = "actionBlockKey"
    }
    
    /// 设置图片
    ///
    /// - Parameters:
    ///   - imgName: 图片
    ///   - placeholder: 占位图
    ///   - state: 状态
    public func qs_setImage(with imgName: String, placeholder: String? = nil, state: UIControl.State) {
        // 网络图片
        if imgName.hasPrefix("http://") || imgName.hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setImage(with: ImageResource.init(downloadURL: url), for: state, placeholder: UIImage.init(named: placeholder ?? ""))
            }
        } else {
            setImage(UIImage.init(named: imgName), for: state)
        }
    }
    
    /// 设置按钮背景颜色
    ///
    /// - Parameters:
    ///   - color: 背景颜色
    ///   - state: 状态
    public func qs_setBackgroundColor(_ color: UIColor, state: UIControl.State) {
        let bgImage = qs_createImage(with: color, size: UIScreen.main.bounds.size)
        setBackgroundImage(bgImage, for: state)
    }
    
    /// 设置背景图片
    ///
    /// - Parameters:
    ///   - imgName: 图片
    ///   - placeholder: 占位图
    ///   - state: 状态
    public func qs_setBackgroundImage(with imgName: String, placeholder: String? = nil, state: UIControl.State) {
        // 网络图片
        if imgName.hasPrefix("http://") || imgName.hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setBackgroundImage(with: ImageResource.init(downloadURL: url), for: state, placeholder: UIImage.init(named: placeholder ?? ""))
            }
        } else {
            setBackgroundImage(UIImage.init(named: imgName), for: state)
        }
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter action: 点击事件回调
    public func qs_setAction(_ action: (@escaping(UIButton) -> ())) {
        objc_setAssociatedObject(self, &AssociatedKeys.actionBlockKey, action, .OBJC_ASSOCIATION_COPY)
        
        addTarget(self, action: #selector(self.clickBtn(_:)), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    /// 按钮点击事件
    ///
    /// - Parameter btn: 按钮
    @objc private func clickBtn(_ btn: UIButton) {
        let block = objc_getAssociatedObject(self, &AssociatedKeys.actionBlockKey) as? ((UIButton) -> ())
        
        if block != nil {
            block!(btn)
        }
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
