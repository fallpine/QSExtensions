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
import RxSwift

public extension UIButton {
    /// 新增属性key
    private struct AssociatedKeys {
        static var actionBlockKey: String = "actionBlockKey"
        
        static var topEdgeKey: String = "topEdgeKey"
        static var leftEdgeKey: String = "leftEdgeKey"
        static var bottomEdgeKey: String = "bottomEdgeKey"
        static var rightEdgeKey: String = "rightEdgeKey"
        
        static var eventIntervalKey: String = "eventIntervalKey"
        static var eventEnabledKey: String = "eventEnabledKey"
    }
    
    /// 设置图片
    ///
    /// - Parameters:
    ///   - imgName: 图片
    ///   - placeholder: 占位图
    ///   - state: 状态
    func qs_setImage(_ imgName: String, placeholder: String? = nil, state: UIControl.State) {
        // 占位图
        if let placeholder = placeholder {
            if !placeholder.isEmpty {
                setImage(UIImage.init(named: placeholder), for: state)
            }
        }
        
        // 没有图片
        if imgName.isEmpty {
            return
        }
        
        // 网络图片
        if imgName.lowercased().hasPrefix("http://") || imgName.lowercased().hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setImage(with: ImageResource.init(downloadURL: url), for: state)
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
    func qs_setBackgroundColor(_ color: UIColor, state: UIControl.State) {
        let bgImage = UIImage.qs_image(with: color, size: UIScreen.main.bounds.size)
        setBackgroundImage(bgImage, for: state)
    }
    
    /// 设置背景图片
    ///
    /// - Parameters:
    ///   - imgName: 图片
    ///   - placeholder: 占位图
    ///   - state: 状态
    func qs_setBackgroundImage(_ imgName: String, placeholder: String? = nil, state: UIControl.State) {
        // 占位图
        if let placeholder = placeholder {
            if !placeholder.isEmpty {
                setBackgroundImage(UIImage.init(named: placeholder), for: state)
            }
        }
        
        // 没有图片
        if imgName.isEmpty {
            return
        }
        
        // 网络图片
        if imgName.lowercased().hasPrefix("http://") || imgName.lowercased().hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setBackgroundImage(with: ImageResource.init(downloadURL: url), for: state)
            }
        } else {
            setBackgroundImage(UIImage.init(named: imgName), for: state)
        }
    }
    
    /// 设置按钮点击范围
    /// - Parameters:
    ///   - top: 上
    ///   - left: 左
    ///   - bottom: 下
    ///   - right: 右
    func qs_setEnlargeEdge(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        objc_setAssociatedObject(self, &AssociatedKeys.topEdgeKey, top, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.leftEdgeKey, left, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.bottomEdgeKey, bottom, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.rightEdgeKey, right, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter action: 点击事件回调
    func qs_addTapAction(_ action: @escaping (UIButton) -> ()) {
        objc_setAssociatedObject(self, &AssociatedKeys.actionBlockKey, action, .OBJC_ASSOCIATION_COPY)
        
        addTarget(self, action: #selector(self.clickBtn(_:)), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    /// 按钮点击事件
    ///
    /// - Parameter btn: 按钮
    @objc private func clickBtn(_ btn: UIButton) {
        if qs_eventEnabled {
            qs_eventEnabled = false
            if let block = objc_getAssociatedObject(self, &AssociatedKeys.actionBlockKey) as? (UIButton) -> () {
                block(btn)
            }
            self.perform(#selector(self.enableBtnEvent), with: nil, afterDelay: qs_eventInterval)
        }
    }
    
    /// 使能按钮点击事件
    @objc private func enableBtnEvent() {
        qs_eventEnabled = true
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
    
    // MARK: - Property
    /// 按钮点击响应时间间隔
    var qs_eventInterval: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.eventIntervalKey) as? TimeInterval) ?? 0.6
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventIntervalKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    /// 点击事件是否有效
    private var qs_eventEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.eventEnabledKey) as? Bool) ?? true
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // MARK: - System Methods
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = enlargedRect()
        if rect.equalTo(bounds) {
            return super.point(inside: point, with: event)
        } else {
            return rect.contains(point)
        }
    }
}
