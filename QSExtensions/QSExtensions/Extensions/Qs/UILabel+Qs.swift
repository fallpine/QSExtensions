//
//  UILabel+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

public extension UILabel {
    /// 设置特定区域的字体大小
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    func qs_setText(font: UIFont, range: NSRange) {
        let attributedString = attributedText?.qs_setText(font: font, range: range)
        attributedText = attributedString
    }
    
    /// 设置特定文字的字体大小
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    func qs_setText(_ text: String, font: UIFont) {
        let attributedString = attributedText?.qs_setText(text, font: font)
        attributedText = attributedString
    }
    
    /// 设置特定区域的字体颜色
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    func qs_setText(color: UIColor, range: NSRange) {
        let attributedString = attributedText?.qs_setText(color: color, range: range)
        attributedText = attributedString
    }
    
    /// 设置特定文字的字体颜色
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    func qs_setText(_ text: String, color: UIColor) {
        let attributedString = attributedText?.qs_setText(text, color: color)
        attributedText = attributedString
    }
    
    /// 设置行间距
    ///
    /// - Parameter space: 行间距
    func qs_setLineSpace(_ space: CGFloat) {
        let attributedString = attributedText?.qs_setText(lineSpace: space, alignment: textAlignment, range: NSRange.init(location: 0, length: text?.count ?? 0))
        attributedText = attributedString
    }
    
    /// 设置特定区域的下划线
    ///
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 范围
    func qs_setUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) {
        let attributedString = attributedText?.qs_setUnderLine(color: color, stytle: stytle, range: range)
        attributedText = attributedString
    }
    
    /// 设置特定文字的下划线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    func qs_setUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) {
        let attributedString = attributedText?.qs_setUnderLine(text, color: color, stytle: stytle)
        attributedText = attributedString
    }
    
    /// 设置特定区域的删除线
    ///
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 范围
    func qs_setDeleteLine(color: UIColor, range: NSRange) {
        let attributedString = attributedText?.qs_setDeleteLine(color: color, range: range)
        attributedText = attributedString
    }
    
    /// 设置特定文字的删除线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 删除线颜色
    func qs_setDeleteLine(_ text: String, color: UIColor) {
        let attributedString = attributedText?.qs_setDeleteLine(text, color: color)
        attributedText = attributedString
    }
    
    /// 插入图片
    ///
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex: 图片的位置，默认放在开头
    func qs_insertImage(_ imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) {
        // 设置换行方式
        lineBreakMode = NSLineBreakMode.byCharWrapping
        
        let attributedString = attributedText?.qs_insertImage(imgName, imgBounds: imgBounds, imgIndex: imgIndex)
        attributedText = attributedString
    }
    
    /// 首行缩进
    ///
    /// - Parameter eadge: 缩进宽度
    func qs_firstLineLeftEdge(_ edge: CGFloat) {
        let attributedString = attributedText?.qs_firstLineLeftEdge(edge)
        attributedText = attributedString
    }
}
