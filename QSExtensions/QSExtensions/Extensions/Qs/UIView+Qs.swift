//
//  UIView+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/7/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import RxCocoa
import RxSwift

extension UIView {
    /// 新增属性key
    private struct AssociatedKeys {
        static var borderLayerKey: String = "borderLayerKey"
        static var shadowLayerKey: String = "shadowLayerKey"
        
        static var alphaDisposableKey: String = "alphaDisposableKey"
        static var isHiddenDisposableKey: String = "isHiddenDisposableKey"
    }
    
    // MARK: - 边框
    /// 边框layer
    private var borderLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.borderLayerKey) as? CAShapeLayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.borderLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - 阴影
    /// 阴影layer
    private var shadowLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shadowLayerKey) as? CAShapeLayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shadowLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 监听alpha销毁对象
    private var alphaDisposable: Disposable? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.alphaDisposableKey) as? Disposable
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.alphaDisposableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 监听hidden销毁对象
    private var isHiddenDisposable: Disposable? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isHiddenDisposableKey) as? Disposable
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isHiddenDisposableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Func
    /// 添加圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - corners: 某个角
    public func qs_addRoundingCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        if self.superview == nil {
            return
        }
        
        if #available(iOS 11.0, *) {
            DispatchQueue.main.async { [weak self] in
                guard let mySelf = self else {
                    return
                }
                
                mySelf.layer.cornerRadius = radius

                var cornersMask = CACornerMask()
                if corners.contains(UIRectCorner.allCorners) {
                    cornersMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    mySelf.layer.masksToBounds = true
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

                    mySelf.layer.maskedCorners = cornersMask
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let mySelf = self else {
                    return
                }
                
                mySelf.superview?.layoutIfNeeded()
                let myFrame = mySelf.frame
                if mySelf.isKind(of: UIScrollView.self) {
                    mySelf.layer.cornerRadius = radius
                    mySelf.layer.masksToBounds = true
                    
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = myFrame
                    let maskPath = UIBezierPath.init(roundedRect: mySelf.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                    maskLayer.path = maskPath.cgPath
                    maskLayer.fillColor = (mySelf.backgroundColor ?? UIColor.clear).cgColor
                    mySelf.superview?.layer.insertSublayer(maskLayer, below: self?.layer)
                } else {
                    let maskPath = UIBezierPath.init(roundedRect: mySelf.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                    // 创建 layer
                    let maskLayer = CAShapeLayer.init()
                    maskLayer.frame = mySelf.bounds
                    maskLayer.path = maskPath.cgPath
                    maskLayer.fillColor = UIColor.green.cgColor
                    mySelf.layer.mask = maskLayer
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
        if self.superview == nil {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let mySelf = self else {
                return
            }
            
            mySelf.superview?.layoutIfNeeded()
            let myFrame = mySelf.frame
            if myFrame.size != .zero {
                if corners == .allCorners && borderPath == nil && radius <= 0.0 {
                    mySelf.layer.borderWidth = width
                    mySelf.layer.borderColor = color.cgColor
                    
                    return
                }
                
                let maskLayer = CAShapeLayer.init()
                maskLayer.frame = myFrame
                if let path = borderPath {
                    maskLayer.path = path.cgPath
                } else {
                    let maskPath = UIBezierPath.init(roundedRect: mySelf.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
                    maskLayer.path = maskPath.cgPath
                }
                
                maskLayer.strokeColor = color.cgColor
                maskLayer.fillColor = UIColor.clear.cgColor
                maskLayer.lineWidth = width
                mySelf.superview?.layer.addSublayer(maskLayer)
                
                mySelf.qs_removeBorder()
                mySelf.borderLayer = maskLayer
            }
        }
        
        // 监听
        observeAction()
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
    public func qs_addShadow(radius: CGFloat = 0.0, horizontalOffset: CGFloat = 0.0, verticalOffset: CGFloat = 0.0, shadowOpacity: CGFloat = 0.5, shadowColor: UIColor, shadowPath: UIBezierPath? = nil)  {
        if self.superview == nil {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let mySelf = self else {
                return
            }
            
            mySelf.superview?.layoutIfNeeded()
            let myFrame = mySelf.frame
            if myFrame.size != .zero {
                let subLayer = CAShapeLayer()
                subLayer.frame = myFrame
                subLayer.cornerRadius = radius
                subLayer.backgroundColor = UIColor.white.cgColor
                subLayer.masksToBounds = false
                subLayer.shadowColor = shadowColor.cgColor // 阴影颜色
                subLayer.shadowOffset = CGSize(width: horizontalOffset, height: verticalOffset) // 阴影偏移,width:水平方向偏移，height:竖直方向偏移
                subLayer.shadowOpacity = Float(shadowOpacity) // 阴影透明度
                subLayer.shadowRadius = 5.0; // 阴影半径，默认3
                subLayer.shadowPath = shadowPath?.cgPath
                mySelf.superview?.layer.insertSublayer(subLayer, below: mySelf.layer)
                
                mySelf.qs_removeShadow()
                mySelf.shadowLayer = subLayer
            }
        }
        
        // 监听
        observeAction()
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
    
    /// 监听操作
    private func observeAction() {
        if alphaDisposable == nil {
            alphaDisposable = self.rx.observe(CGFloat.self, "alpha")
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { [weak self] (alpha) in
                if let newAlpha = alpha {
                    self?.borderLayer?.opacity = Float(newAlpha)
                    self?.shadowLayer?.opacity = Float(newAlpha)
                }
                })
        }
        
        if isHiddenDisposable == nil {
            isHiddenDisposable = self.rx.observe(Bool.self, "hidden")
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { [weak self] (isHidden) in
                if let newIsHidden = isHidden {
                    self?.borderLayer?.isHidden = newIsHidden
                    self?.shadowLayer?.isHidden = newIsHidden
                }
                })
        }
    }
}


