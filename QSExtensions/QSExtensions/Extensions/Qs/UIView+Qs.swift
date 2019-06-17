//
//  UIView+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/7/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIView {
    /// 新增属性key
    private struct AssociatedKeys {
        static var borderLayerKey: String = "borderLayerKey"
        static var shadowLayerKey: String = "shadowLayerKey"
    }
    
    /// 边框layer
    private var borderLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.borderLayerKey) as? CAShapeLayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.borderLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 阴影layer
    private var shadowLayer: CALayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shadowLayerKey) as? CAShapeLayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shadowLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - corners: 某个角
    public func qs_addRoundingCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        // 创建 layer
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    /// 添加边框
    ///
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    ///   - radius: 边框圆角
    ///   - corners: 某个角
    ///   - borderPath: 边框路径，为nil时根据radius和corners来创建路径，不为nil时radius和corners属性设置无效
    public func qs_addBorder(width: CGFloat, color: UIColor, radius: CGFloat = 0.0, corners: UIRectCorner = .allCorners, borderPath: UIBezierPath? = nil) {
        if let lay = borderLayer {
            lay.removeFromSuperlayer()
        }
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = frame
        if let path = borderPath {
            maskLayer.path = path.cgPath
        } else {
            let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
            maskLayer.path = maskPath.cgPath
        }
        
        maskLayer.strokeColor = color.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.lineWidth = width
        superview?.layer.addSublayer(maskLayer)
        borderLayer = maskLayer
    }
    
    /// 添加阴影
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - horizontalOffset: 水平偏移，负数向左，正数向右
    ///   - verticalOffset: 竖直偏移，负数向上，正数向下
    ///   - shadowOpacity: 阴影透明度
    ///   - shadowColor: 阴影颜色
    ///   - shadowPath: 阴影路径，nil为控件的边框路径
    public func qs_addShadow(radius: CGFloat = 0.0, horizontalOffset: CGFloat = 0.0, verticalOffset: CGFloat = 0.0, shadowOpacity: CGFloat = 0.5, shadowColor:UIColor, shadowPath: UIBezierPath? = nil)  {
        if let lay = shadowLayer {
            lay.removeFromSuperlayer()
        }
        
        let subLayer = CALayer()
        subLayer.frame = frame
        subLayer.cornerRadius = radius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = shadowColor.cgColor // 阴影颜色
        subLayer.shadowOffset = CGSize(width: horizontalOffset, height: verticalOffset) // 阴影偏移,width:水平方向偏移，height:竖直方向偏移
        subLayer.shadowOpacity = Float(shadowOpacity) //阴影透明度
        subLayer.shadowRadius = 5.0;//阴影半径，默认3
        subLayer.shadowPath = shadowPath?.cgPath
        superview?.layer.insertSublayer(subLayer, below: layer)
        shadowLayer = subLayer
    }
    
    /// 清除所有子控件
    public func qs_clearSubViews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}
