//
//  UIBarButtonItem+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/3/2.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 图片BtnItem
    ///
    /// - Parameters:
    ///   - img: 图片名
    ///   - highlightImg: 高亮图片名
    ///   - disabledImg: 不可用图片名
    ///   - target: 代理对象
    ///   - action: 执行操作
    public class func qs_imgBtnItem(img: String, highlightImg: String? = nil, disabledImg: String? = nil, target: Any, action: Selector) -> UIBarButtonItem {
        let normalImg = UIImage.init(named: img)
        var btnWidth = normalImg?.size.width ?? 25.0
        var btnHeight = normalImg?.size.height ?? 25.0
        
        if btnWidth < 25.0 {
            btnWidth = 25.0
        }
        if btnHeight < 25.0 {
            btnHeight = 25.0
        }
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnWidth, height: btnHeight))
        btn.setImage(UIImage.init(named: img), for: .normal)
        
        if let highlightI = highlightImg {
            btn.setImage(UIImage.init(named: highlightI), for: .highlighted)
        }
        
        if let disabledI = disabledImg {
            btn.setImage(UIImage.init(named: disabledI), for: .disabled)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem.init(customView: btn)
    }
    
    /// 文字BtnItem
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - color: 文字颜色
    ///   - highlightColor: 高亮文字颜色
    ///   - disabledColor: 不可用文字颜色
    ///   - font: 文字字体
    ///   - target: 代理对象
    ///   - action: 执行操作
    public class func qs_titleBtnItem(title: String, color: UIColor = .black, highlightColor: UIColor? = nil, disabledColor: UIColor? = nil, font: UIFont = UIFont.systemFont(ofSize: 14.0), target: Any, action: Selector) -> UIBarButtonItem {
        let barBtn = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: target, action: action)
        barBtn.tintColor = color
        
        let attributes = [NSAttributedString.Key.font: font]
        
        let normalAttributes = [NSAttributedString.Key.font: font,
                                NSAttributedString.Key.foregroundColor: color]
        barBtn.setTitleTextAttributes(normalAttributes, for: .normal)
        
        if let highlightC = highlightColor {
            let highlightAttributes = [NSAttributedString.Key.font: font,
                                    NSAttributedString.Key.foregroundColor: highlightC]
            barBtn.setTitleTextAttributes(highlightAttributes, for: .highlighted)
        } else {
            barBtn.setTitleTextAttributes(attributes, for: .highlighted)
        }
        
        if let disabledC = disabledColor {
            let disabledAttributes = [NSAttributedString.Key.font: font,
                                       NSAttributedString.Key.foregroundColor: disabledC]
            barBtn.setTitleTextAttributes(disabledAttributes, for: .disabled)
        } else {
            barBtn.setTitleTextAttributes(attributes, for: .disabled)
        }
        
        return barBtn
    }
    
    /// 图片和文字BtnItem
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - selTitle: 选中文字
    ///   - disTitle: 不可用文字
    ///   - img: 图片
    ///   - selImg: 选中图片
    ///   - disImg: 不可用图片
    ///   - titleColor: 文字颜色
    ///   - selTitleColor: 选中文字颜色
    ///   - disTitleColor: 不可用文字颜色
    ///   - titleFont: 文字字体
    ///   - target: 代理对象
    ///   - action: 执行操作
    public class func qs_imgAndTitleBtnItem(title: String = "", selTitle: String? = nil, disTitle: String? = nil, img: String = "", selImg: String? = nil, disImg: String? = nil, titleColor: UIColor = .black, selTitleColor: UIColor? = nil, disTitleColor: UIColor? = nil, titleFont: UIFont = UIFont.systemFont(ofSize: 15.0), target: Any, action: Selector) -> UIBarButtonItem {
        let btnImg = UIImage.init(named: img)
        var btnWidth = title.qs_obtainWidth(font: titleFont, height: 20.0) + (btnImg?.size.width ?? 0.0)
        var btnHeight = btnImg?.size.height ?? 25.0
        if btnWidth < 25.0 {
            btnWidth = 25.0
        }
        if btnHeight < 25.0 {
            btnHeight = 25.0
        }
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnWidth, height: btnHeight))
        btn.setImage(UIImage.init(named: img), for: .normal)
        if let selI = selImg {
            btn.setImage(UIImage.init(named: selI), for: .selected)
        }
        
        if let disI = disImg {
            btn.setImage(UIImage.init(named: disI), for: .disabled)
        }
        
        btn.setTitle(title, for: .normal)
        btn.setTitle(selTitle, for: .selected)
        btn.setTitle(disTitle, for: .disabled)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitleColor(selTitleColor, for: .selected)
        btn.setTitleColor(disTitleColor, for: .disabled)
        btn.titleLabel?.font = titleFont
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem.init(customView: btn)
    }
}
