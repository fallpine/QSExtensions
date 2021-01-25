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
        
        static var topEdgeKey: String = "topEdgeKey"
        static var leftEdgeKey: String = "leftEdgeKey"
        static var bottomEdgeKey: String = "bottomEdgeKey"
        static var rightEdgeKey: String = "rightEdgeKey"
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
            if imgName.isEmpty {
                if placeholder != nil {
                    setImage(UIImage.init(named: placeholder!), for: state)
                }
            } else {
                setImage(UIImage.init(named: imgName), for: state)
            }
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
            if imgName.isEmpty {
                if placeholder != nil {
                    setImage(UIImage.init(named: placeholder!), for: state)
                }
            } else {
                setImage(UIImage.init(named: imgName), for: state)
            }
        }
    }
    
    /// 设置按钮点击范围
    /// - Parameters:
    ///   - top: 上
    ///   - left: 左
    ///   - bottom: 下
    ///   - right: 右
    public func setEnlargeEdge(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        objc_setAssociatedObject(self, &AssociatedKeys.topEdgeKey, top, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.leftEdgeKey, left, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.bottomEdgeKey, bottom, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.rightEdgeKey, right, .OBJC_ASSOCIATION_COPY_NONATOMIC)
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
    
    /// 扩大边界
    /// - Returns: 扩大后的边界
    private func enlargedRect() -> CGRect {
        if let topEdge = objc_getAssociatedObject(self, &AssociatedKeys.topEdgeKey) as? CGFloat,
        let leftEdge = objc_getAssociatedObject(self, &AssociatedKeys.leftEdgeKey) as? CGFloat,
        let bottomEdge = objc_getAssociatedObject(self, &AssociatedKeys.bottomEdgeKey) as? CGFloat,
        let rightEdge = objc_getAssociatedObject(self, &AssociatedKeys.rightEdgeKey) as? CGFloat {
            return CGRect.init(x: bounds.origin.x - leftEdge, y: bounds.origin.y - topEdge, width: bounds.width + leftEdge + rightEdge, height: bounds.height + topEdge + bottomEdge)
        } else {
            return bounds
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
    
    // MARK: - System Methods
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = enlargedRect()
        if rect.equalTo(bounds) {
            return super.point(inside: point, with: event)
        } else {
            return rect.contains(point)
        }
    }
}
