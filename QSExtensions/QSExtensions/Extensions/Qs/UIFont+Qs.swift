//
//  UIFont+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/26.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIFont {
    /// 系统普通字体
    ///
    /// - Parameter size: 字体大小
    static func qs_systemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: kAdaptedWidth(size))
    }
    
    /// 加粗字体
    ///
    /// - Parameter size: 字体大小
    static func qs_boldFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: kAdaptedWidth(size))
    }
    
    /// 根据字体名设置字体
    ///
    /// - Parameters:
    ///   - fontName: 字体名
    ///   - size: 字体大小
    static func qs_otherFont(fontName: String, size: CGFloat) -> UIFont {
        return UIFont.init(name: fontName, size: kAdaptedWidth(size))!
    }
    
    // MARK: - Private Func
    /// 是否是刘海屏
    static private func kIsBangScreen() -> Bool {
        return kSafeAreaInset().top > 20
    }
    
    /// 全面屏手机的安全区域
    static private func kSafeAreaInset() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    /// 宽度适配
    static private func kAdaptedWidth(_ value: CGFloat) -> CGFloat {
        if kIsBangScreen() {
            // 刘海屏
            let kWidthScale = UIScreen.main.bounds.size.width / 375.0
            return CGFloat(value * kWidthScale)
        } else {
            // iPhone5s ~ iPhone8
            let kWidthScale = UIScreen.main.bounds.size.width / 375.0
            return CGFloat(value * kWidthScale)
        }
    }
}
