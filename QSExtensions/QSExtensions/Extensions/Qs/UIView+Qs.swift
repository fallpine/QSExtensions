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
    private var shadowLayer: CAShapeLayer? {
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
        DispatchQueue.main.async { [weak self] in
            if #available(iOS 11.0, *) {
                self?.layer.cornerRadius = radius
                
                var cornersMask = CACornerMask()
                if corners.contains(UIRectCorner.allCorners) {
                    cornersMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    self?.layer.masksToBounds = true
                } else {
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
                    
                    self?.layer.maskedCorners = cornersMask
                }
            } else {
                while true {
                    guard let myFram = self?.frame else {
                        continue
                    }
                    
                    if myFram.size != .zero {
                        if self?.isKind(of: UIScrollView.self) ?? false {
                            self?.layer.cornerRadius = radius
                            self?.layer.masksToBounds = true
                            
                            let maskLayer = CAShapeLayer.init()
                            maskLayer.frame = myFram
                            let maskPath = UIBezierPath.init(roundedRect: self?.bounds ?? .zero, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                            maskLayer.path = maskPath.cgPath
                            maskLayer.fillColor = (self?.backgroundColor ?? UIColor.clear).cgColor
                            self?.superview?.layer.insertSublayer(maskLayer, below: self?.layer)
                        } else {
                            let maskPath = UIBezierPath.init(roundedRect: self?.bounds ?? .zero, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                            // 创建 layer
                            let maskLayer = CAShapeLayer.init()
                            maskLayer.frame = self?.bounds ?? .zero
                            maskLayer.path = maskPath.cgPath
                            maskLayer.fillColor = UIColor.green.cgColor
                            self?.layer.mask = maskLayer
                        }
                        
                        break
                    }
                }
            }
        }
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
        DispatchQueue.main.async { [weak self] in
            while true {
                guard let myFram = self?.frame else {
                    continue
                }
                
                if myFram.size != .zero {
                    if corners == .allCorners && borderPath == nil && radius <= 0.0 {
                        self?.layer.borderWidth = width
                        self?.layer.borderColor = color.cgColor
                        
                        return
                    }
                    
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = myFram
                    if let path = borderPath {
                        maskLayer.path = path.cgPath
                    } else {
                        let maskPath = UIBezierPath.init(roundedRect: self?.bounds ?? .zero, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                        maskLayer.path = maskPath.cgPath
                    }
                    
                    maskLayer.strokeColor = color.cgColor
                    maskLayer.fillColor = UIColor.clear.cgColor
                    maskLayer.lineWidth = width
                    self?.superview?.layer.addSublayer(maskLayer)
                    
                    self?.qs_removeBorder()
                    self?.borderLayer = maskLayer
                    
                    break
                }
            }
        }
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
        DispatchQueue.main.async { [weak self] in
            while true {
                guard let myFram = self?.frame else {
                    continue
                }
                
                if myFram.size != .zero {
                    let subLayer = CAShapeLayer()
                    subLayer.frame = myFram
                    subLayer.cornerRadius = radius
                    subLayer.backgroundColor = UIColor.white.cgColor
                    subLayer.masksToBounds = false
                    subLayer.shadowColor = shadowColor.cgColor // 阴影颜色
                    subLayer.shadowOffset = CGSize(width: horizontalOffset, height: verticalOffset) // 阴影偏移,width:水平方向偏移，height:竖直方向偏移
                    subLayer.shadowOpacity = Float(shadowOpacity) //阴影透明度
                    subLayer.shadowRadius = 5.0;//阴影半径，默认3
                    subLayer.shadowPath = shadowPath?.cgPath
                    self?.superview?.layer.insertSublayer(subLayer, below: self?.layer)
                    
                    self?.qs_removeShadow()
                    self?.shadowLayer = subLayer
                    
                    break
                }
            }
        }
    }
    
    /// 移除边框
    public func qs_removeBorder() {
        if let layer = borderLayer {
            layer.removeFromSuperlayer()
        }
    }
    
    /// 移除阴影
    public func qs_removeShadow() {
        if let layer = shadowLayer {
            layer.removeFromSuperlayer()
        }
    }
    
    /// 设置透明度，不能使用系统的alpha，这样添加的图层不会有透明度
    public func qs_alpha(_ alpha: CGFloat) {
        if let layer = borderLayer {
            layer.opacity = Float(alpha)
        }
        
        if let layer = shadowLayer {
            layer.opacity = Float(alpha)
        }
        
        self.alpha = alpha
    }
    
    /// 隐藏，不能使用系统的isHidden，这样添加的图层不会隐藏
    public func qs_isHidden(_ isHidden: Bool) {
        if let layer = borderLayer {
            layer.isHidden = isHidden
        }
        
        if let layer = shadowLayer {
            layer.isHidden = isHidden
        }
        
        self.isHidden = isHidden
    }
    
    /// 从父控件中移除，不能使用系统的removeFromSuperview，这样添加的图层不会移除
    public func qs_removeFromSuperview() {
        if let layer = borderLayer {
            layer.removeFromSuperlayer()
        }
        
        if let layer = shadowLayer {
            layer.removeFromSuperlayer()
        }
        
        self.removeFromSuperview()
    }
    
    /// 清除所有子控件
    public func qs_clearSubViews() {
        for subView in subviews {
            subView.qs_removeFromSuperview()
        }
    }
}
