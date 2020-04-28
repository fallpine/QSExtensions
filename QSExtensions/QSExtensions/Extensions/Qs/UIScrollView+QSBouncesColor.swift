//
//  UIScrollView+QSBouncesColor.swift
//  BeeBoxClient
//
//  Created by Song on 2020/4/28.
//  Copyright © 2020 Song. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// 新增属性key
    private struct AssociatedKeys {
        static var bouncesBgView: String = "bouncesBgView"
    }
    
    /// 弹簧区域方向
    public enum QSBouncesDirection {
        case top           // 上
        case left         // 左
    }
    
    /// 设置弹簧区域的颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - direction: 方向，默认顶部，仅支持上边和左边，因为无法确定contentSize的大小，所以无法设置右边和下边
    public func qs_setBouncesBg(color: UIColor, direction: QSBouncesDirection = .top) {
        if bouncesBgView == nil {
            bouncesBgView = UIView.init()
            
            if let bgView = bouncesBgView {
                self.addSubview(bgView)
                self.sendSubviewToBack(bgView)
                bgView.snp.makeConstraints { (make) in
                    switch direction {
                    case .top:
                        make.left.equalToSuperview()
                        make.width.equalTo(self.snp_width)
                        make.bottom.equalTo(self.snp_top).offset(-self.contentInset.top)
                        make.height.equalTo(500.0)
                        
                    case .left:
                        make.top.equalToSuperview()
                        make.height.equalTo(self.snp_height)
                        make.right.equalTo(self.snp_left).offset(-self.contentInset.left)
                        make.width.equalTo(500.0)
                    }
                }
            }
        }
        
        bouncesBgView?.backgroundColor = color
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
