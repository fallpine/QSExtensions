//
//  UIScrollView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UIScrollView {
    /// 新增属性key
    private struct AssociatedKeys {
        static var bouncesBgView: String = "bouncesBgView"
    }
    
    /// 弹簧区域方向
    enum QSBouncesDirection {
        case top           // 上
        case left         // 左
    }
    
    /// 创建scrollView
    ///
    /// - Parameter backgroundColor: 背景颜色
    convenience init(with backgroundColor: UIColor) {
        self.init()
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = backgroundColor
    }
    
    /// 设置弹簧区域的颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - direction: 方向，默认顶部，仅支持上边和左边，因为无法确定contentSize的大小，所以无法设置右边和下边
    @discardableResult
    func qs_setBouncesBackgroundColor(_ color: UIColor, direction: QSBouncesDirection = .top) -> UIScrollView {
        if bouncesBgView == nil {
            bouncesBgView = UIView.init()
            
            layoutIfNeeded()
            if let bgView = bouncesBgView {
                addSubview(bgView)
                sendSubviewToBack(bgView)
                switch direction {
                case .top:
                    bgView.frame = CGRect.init(x: 0.0, y: -500, width: self.bounds.width, height: 500)
                    
                case .left:
                    bgView.frame = CGRect.init(x: -500, y: 0.0, width: 500, height: self.bounds.height)
                }
            }
        }
        
        bouncesBgView?.backgroundColor = color
        return self
    }
    
    // 弹簧区域背景视图
    private var bouncesBgView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.bouncesBgView) as? UIView
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.bouncesBgView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
