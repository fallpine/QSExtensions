//
//  NSAttributedString+Qs.swift
//  QSExtensions
//
//  Created by Song on 2020/12/15.
//  Copyright © 2020 Song. All rights reserved.
//

import UIKit

extension NSAttributedString {
    // MARK: - Func
    /// 设置特定区域的字体大小
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    public func qs_setText(font: UIFont, range: NSRange) -> NSAttributedString {
        return qs_setText(attributes: [NSAttributedString.Key.font : font], range: range)
    }
    
    /// 设置特定文字的字体大小
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    public func qs_setText(_ text: String, font: UIFont) -> NSAttributedString {
        return qs_setText(text, attributes: [NSAttributedString.Key.font : font])
    }
    
    /// 设置特定区域的字体颜色
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    public func qs_setText(color: UIColor, range: NSRange) -> NSAttributedString {
        return qs_setText(attributes: [NSAttributedString.Key.foregroundColor : color], range: range)
    }
    
    /// 设置特定文字的字体颜色
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    public func qs_setText(_ text: String, color: UIColor) -> NSAttributedString {
        return qs_setText(text, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    /// 设置特定区域行间距
    ///
    /// - Parameters:
    /// - Parameter lineSpace: 行间距
    /// - Parameter alignment: 对齐方式
    /// - Parameter range: 区域
    public func qs_setText(lineSpace: CGFloat, alignment: NSTextAlignment, range: NSRange) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        
        return qs_setText(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
    }
    
    /// 设置特定文字行间距
    ///
    /// - Parameters:
    /// - Parameter text: 特定文字
    /// - Parameter lineSpace: 行间距
    /// - Parameter alignment: 对齐方式
    public func qs_setText(_ text: String, lineSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        
        return qs_setText(text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    /// 设置特定区域的下划线
    ///
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 范围
    public func qs_setUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) -> NSAttributedString {
        // 下划线样式
        let lineStytle = NSNumber.init(value: Int8(stytle.rawValue))
        return qs_setText(attributes: [NSAttributedString.Key.underlineStyle: lineStytle, NSAttributedString.Key.underlineColor: color], range: range)
    }
    
    /// 设置特定文字的下划线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    public func qs_setUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) -> NSAttributedString {
        // 下划线样式
        let lineStytle = NSNumber.init(value: Int8(stytle.rawValue))
        return qs_setText(text, attributes: [NSAttributedString.Key.underlineStyle : lineStytle, NSAttributedString.Key.underlineColor: color])
    }
    
    /// 设置特定区域的删除线
    ///
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 范围
    public func qs_setDeleteLine(color: UIColor, range: NSRange) -> NSAttributedString {
        var attributes = Dictionary<NSAttributedString.Key, Any>()
        // 删除线样式
        let lineStytle = NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))
        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
        attributes[NSAttributedString.Key.strikethroughColor] = color
        attributes[NSAttributedString.Key.baselineOffset] = 0
        
        return qs_setText(attributes: attributes, range: range)
    }
    
    /// 设置特定文字的删除线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 删除线颜色
    public func qs_setDeleteLine(_ text: String, color: UIColor) -> NSAttributedString {
        var attributes = Dictionary<NSAttributedString.Key, Any>()
        // 删除线样式
        let lineStytle = NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))
        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
        attributes[NSAttributedString.Key.strikethroughColor] = color
        attributes[NSAttributedString.Key.baselineOffset] = 0
        
        return qs_setText(text, attributes: attributes)
    }
    
    /// 插入图片
    ///
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex: 图片的位置，默认放在开头
    public func qs_insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(attributedString: self)
        // NSTextAttachment可以将要插入的图片作为特殊字符处理
        let attch = NSTextAttachment.init()
        attch.image = qs_loadImage(imageName: imgName)
        attch.bounds = imgBounds
        
        // 创建带有图片的富文本
        let string = NSAttributedString.init(attachment: attch)
        // 将图片添加到富文本
        attributedString.insert(string, at: imgIndex)
        
        return attributedString
    }
    
    /// 首行缩进
    ///
    /// - Parameter eadge: 缩进宽度
    public func qs_firstLineLeftEdge(_ edge: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.firstLineHeadIndent = edge
        
        return qs_setText(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange.init(location: 0, length: self.length))
    }
    
    /// 设置特定区域的多个字体属性
    ///
    /// - Parameters:
    ///   - attributes: 字体属性
    ///   - range: 特定区域
    public func qs_setText(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self)
        
        for name in attributes.keys {
            mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
        }
        
        return mutableAttributedString
    }
    
    /// 设置特定文字的多个字体属性
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - attributes: 字体属性
    public func qs_setText(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self)
        
        let rangeArray = qs_getStringRangeArray(with: [text])
        if !rangeArray.isEmpty {
            for name in attributes.keys {
                for range in rangeArray {
                    mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
                }
            }
        }
        
        return mutableAttributedString
    }
    
    // MARK: - Private Func
    /// 获取对应字符串的range数组
    ///
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
    private func qs_getStringRangeArray(with textArray: Array<String>) -> Array<NSRange> {
        var rangeArray = Array<NSRange>.init()
        
        // 遍历
        for str in textArray {
            if string.contains(str) {
                let subStrArr = string.qs_division(str)
                
                var subStrIndex = 0
                for i in 0 ..< (subStrArr.count - 1) {
                    let subDivisionStr = subStrArr[i]
                    
                    if i == 0 {
                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2)
                    } else {
                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2 + str.lengthOfBytes(using: .unicode) / 2)
                    }
                    
                    let newRange = NSRange.init(location: subStrIndex, length: str.lengthOfBytes(using: .unicode) / 2)
                    rangeArray.append(newRange)
                }
            }
        }
        
        return rangeArray
    }
    
    /// 加载网络图片
    ///
    /// - Parameter imageName: 图片名
    /// - Returns: 图片
    private func qs_loadImage(imageName: String) -> UIImage? {
        if imageName.hasPrefix("http://") || imageName.hasPrefix("https://") {
            let imageURL = URL.init(string: imageName)
            var imageData: Data? = nil
            
            do {
                imageData = try Data.init(contentsOf: imageURL!)
                return UIImage.init(data: imageData!)!
            } catch {
                return nil
            }
        }
        
        return UIImage.init(named: imageName)!
    }
}
