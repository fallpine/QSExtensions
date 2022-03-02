//
//  UIBarButtonItem+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/3/2.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 新增属性key
    private struct AssociatedKeys {
        static var actionBlockKey: String = "actionBlockKey"
    }
    
    /// 图片BtnItem
    ///
    /// - Parameters:
    ///   - img: 图片名
    ///   - selectedImg: 选中图片名
    ///   - disabledImg: 不可用图片名
    ///   - action: 执行操作
    public class func qs_imgBtnItem(img: String, selectedImg: String? = nil, disabledImg: String? = nil, action: @escaping (UIButton) -> Void) -> UIBarButtonItem {
        let normalImg = UIImage.init(named: img)
        
        var btnWidth = normalImg?.size.width ?? 25.0
        var btnHeight = normalImg?.size.height ?? 25.0
        btnWidth = btnWidth < 25.0 ? 25.0 : btnWidth
        btnHeight = btnHeight < 25.0 ? 25.0 : btnHeight
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnWidth, height: btnHeight))
        btn.setImage(UIImage.init(named: img), for: .normal)
        
        if let selectedImg = selectedImg {
            btn.setImage(UIImage.init(named: selectedImg), for: .selected)
        }
        
        if let disabledImg = disabledImg {
            btn.setImage(UIImage.init(named: disabledImg), for: .disabled)
        }
        
        btn.qs_addTapAction(action)
        
        return UIBarButtonItem.init(customView: btn)
    }
    
    /// 文字BtnItem
    /// iOS15之后才有isSelected属性
    /// - Parameters:
    ///   - title: 文字
    ///   - color: 文字颜色
    ///   - selectedColor: 选中文字颜色
    ///   - disabledColor: 不可用文字颜色
    ///   - font: 文字字体
    ///   - action: 执行操作
    public class func qs_titleBtnItem(title: String, color: UIColor, selectedColor: UIColor? = nil, disabledColor: UIColor? = nil, font: UIFont, action: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        // action
        objc_setAssociatedObject(self, &AssociatedKeys.actionBlockKey, action, .OBJC_ASSOCIATION_COPY)
        
        // 创建
        let barBtn = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.clickBarButtonItem(_:)))
        barBtn.tintColor = color
        
        // 字体大小
        let attributes = [NSAttributedString.Key.font: font]
        
        // 正常状态下文字样式
        let normalAttributes = [NSAttributedString.Key.font: font,
                                NSAttributedString.Key.foregroundColor: color]
        barBtn.setTitleTextAttributes(normalAttributes, for: .normal)
        
        // 选中状态下文字样式
        if let selectedColor = selectedColor {
            let highlightAttributes = [NSAttributedString.Key.font: font,
                                    NSAttributedString.Key.foregroundColor: selectedColor]
            barBtn.setTitleTextAttributes(highlightAttributes, for: .selected)
        } else {
            barBtn.setTitleTextAttributes(attributes, for: .selected)
        }
        
        // 不可用状态下文字样式
        if let disabledColor = disabledColor {
            let disabledAttributes = [NSAttributedString.Key.font: font,
                                       NSAttributedString.Key.foregroundColor: disabledColor]
            barBtn.setTitleTextAttributes(disabledAttributes, for: .disabled)
        } else {
            barBtn.setTitleTextAttributes(attributes, for: .disabled)
        }
        
        return barBtn
    }
    
    // MARK: - Private Methods
    /// 按钮点击事件
    ///
    /// - Parameter btn: 按钮
    @objc private class func clickBarButtonItem(_ btnItem: UIBarButtonItem) {
        if let block = objc_getAssociatedObject(self, &AssociatedKeys.actionBlockKey) as? (UIBarButtonItem) -> () {
            block(btnItem)
        }
    }
}
