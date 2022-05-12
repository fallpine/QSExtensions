//
//  UIView+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/7/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import RxCocoa
import RxSwift
import CoreGraphics
import UIKit

public extension UIView {
    /// 新增属性key
    private struct AssociatedKeys {
        static var shadowLayerKey: String = "shadowLayerKey"
    }
    
    // MARK: - 阴影
    /// 阴影layer
    private var shadowLayer: CALayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shadowLayerKey) as? CALayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shadowLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Func
    /// 获取view所在的视图控制器
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - corners: 某个角
    func qs_addCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        // 角
        var cornersMask = CACornerMask()
        if !corners.contains(UIRectCorner.allCorners) {
            if corners.contains(UIRectCorner.topLeft) {
                cornersMask.insert(.layerMinXMinYCorner)
            }

            if corners.contains(UIRectCorner.topRight) {
                cornersMask.insert(.layerMaxXMinYCorner)
            }

            if corners.contains(UIRectCorner.bottomLeft) {
                cornersMask.insert(.layerMinXMaxYCorner)
            }

            if corners.contains(UIRectCorner.bottomRight) {
                cornersMask.insert(.layerMaxXMaxYCorner)
            }

            layer.maskedCorners = cornersMask
        }
    }
    
    /// 添加边框
    ///
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func qs_addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// 添加阴影
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - horizontalOffset: 水平偏移，负数向左，正数向右
    ///   - verticalOffset: 竖直偏移，负数向上，正数向下
    ///   - shadowOpacity: 阴影透明度
    ///   - shadowColor: 阴影颜色
    func qs_addShadow(radius: CGFloat = 0.0, corners: UIRectCorner = .allCorners, horizontalOffset: CGFloat = 0.0, verticalOffset: CGFloat = 0.0, shadowOpacity: CGFloat = 1.0, shadowColor: UIColor)  {
        self.superview?.layoutIfNeeded()
        
        if shadowLayer == nil {
            shadowLayer = CALayer()
        }
        shadowLayer?.frame = frame
        shadowLayer?.cornerRadius = radius
        // 角
        var cornersMask = CACornerMask()
        if !corners.contains(UIRectCorner.allCorners) {
            if corners.contains(UIRectCorner.topLeft) {
                cornersMask.insert(.layerMinXMinYCorner)
            }

            if corners.contains(UIRectCorner.topRight) {
                cornersMask.insert(.layerMaxXMinYCorner)
            }

            if corners.contains(UIRectCorner.bottomLeft) {
                cornersMask.insert(.layerMinXMaxYCorner)
            }

            if corners.contains(UIRectCorner.bottomRight) {
                cornersMask.insert(.layerMaxXMaxYCorner)
            }

            shadowLayer?.maskedCorners = cornersMask
        }

        shadowLayer?.backgroundColor = UIColor.white.cgColor
        shadowLayer?.masksToBounds = false
        shadowLayer?.shadowColor = shadowColor.cgColor // 阴影颜色
        shadowLayer?.shadowOffset = CGSize(width: horizontalOffset, height: verticalOffset) // 阴影偏移,width:水平方向偏移，height:竖直方向偏移
        shadowLayer?.shadowOpacity = Float(shadowOpacity) // 阴影透明度
        shadowLayer?.shadowRadius = 3.0 // 阴影半径，默认3
        shadowLayer?.shadowPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius)).cgPath
        
        if let shadowLayer = shadowLayer {
            if shadowLayer.superlayer == nil {
                superview?.layer.insertSublayer(shadowLayer, below: layer)
            }
        }
    }
    
    /* 一些属性的设置需要考虑到阴影这个图层，不使用系统的属性和方法，应该使用下方自定义的方法 */
    /// 移除阴影
    func qs_removeShadow() {
        if let layer = shadowLayer {
            layer.removeFromSuperlayer()
        }
    }
    
    /// 透明度
    func qs_alpha(_ alpha: CGFloat) {
        self.alpha = alpha
        shadowLayer?.opacity = Float(alpha)
    }
    
    /// 隐藏
    func qs_isHidden(_ isHidden: Bool) {
        self.isHidden = isHidden
        shadowLayer?.isHidden = isHidden
    }
    
    /// 从父控件中移除
    func qs_removeFromSuperview() {
        if let layer = shadowLayer {
            layer.removeFromSuperlayer()
        }
        
        self.removeFromSuperview()
    }
    
    /// 清除所有子控件
    func qs_clearSubViews() {
        for subView in subviews {
            subView.qs_removeFromSuperview()
        }
    }
}


