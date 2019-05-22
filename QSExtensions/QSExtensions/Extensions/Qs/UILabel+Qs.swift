//
//  UILabel+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit
import CoreText

extension UILabel {
    /// 新增属性key
    private struct AssociatedKeys {
        static var textRangeArrayKey: String = "textRangeArrayKey"
        static var textClickBlockKey: String = "textClickBlockKey"
        static var clickTextArrayKey: String = "clickTextArrayKey"
    }
    
    /// 要添加点击事件的字符串数组
    private var qs_clickTextArray: Array<String>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.clickTextArrayKey) as? Array
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.clickTextArrayKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 对应字符串的range数组
    private var qs_textRangeArray: Array<Any>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textRangeArrayKey) as? Array
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.textRangeArrayKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 点击字符串回调
    private var qs_textClickBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textClickBlockKey) as? ((String) -> ())
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.textClickBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 设置特定区域的字体大小
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    public func qs_setText(font: UIFont, range: NSRange) {
        self.qs_setText(attributes: [NSAttributedString.Key.font : font], range: range)
    }
    
    /// 设置特定文字的字体大小
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    public func qs_setText(_ text: String, font: UIFont) {
        self.qs_setText(text, attributes: [NSAttributedString.Key.font : font])
    }
    
    /// 设置特定区域的字体颜色
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    public func qs_setText(color: UIColor, range: NSRange) {
        self.qs_setText(attributes: [NSAttributedString.Key.foregroundColor : color], range: range)
    }
    
    /// 设置特定文字的字体颜色
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    public func qs_setText(_ text: String, color: UIColor) {
        self.qs_setText(text, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    /// 设置特定区域的字体大小和颜色
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 颜色
    ///   - range: 范围
    public func qs_setText(font: UIFont, color: UIColor, range: NSRange) {
        self.qs_setText(attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color], range: range)
    }
    
    /// 设置特定文字的字体大小和颜色
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体
    ///   - color: 颜色
    public func qs_setText(_ text: String, font: UIFont, color: UIColor) {
        self.qs_setText(text, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color])
    }
    
    /// 同时设置特定区域的多个字体属性
    ///
    /// - Parameters:
    ///   - attributes: 字体属性
    ///   - range: 特定区域
    public func qs_setText(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置字体属性")
        
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self.attributedText!)
        
        for name in attributes.keys {
            mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
        }
        
        self.attributedText = mutableAttributedString
    }
    
    /// 同时设置特定文字的多个字体属性
    ///
    /// - Parameters:
    ///   - text: 特定文字
    ///   - attributes: 字体属性
    public func qs_setText(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置字体属性")
        
        let rangeArray = qs_getStringRangeArray(with: [text])
        if !self.qs_isArrayEmpty(rangeArray) {
            let mutableAttributedString = NSMutableAttributedString.init(attributedString: self.attributedText!)
            
            for name in attributes.keys {
                mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: rangeArray.first!)
            }
            
            self.attributedText = mutableAttributedString
        }
    }
    
    /// 设置行间距
    ///
    /// - Parameter space: 行间距
    public func qs_setTextLineSpace(_ space: CGFloat) {
        assert(!qs_isStringEmpty(text), "请先设置text后再设置行间距")
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = textAlignment
        
        let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: (text?.count)!))
        
        self.attributedText = attributedString
    }
    
    /// 设置特定区域的下划线
    ///
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 范围
    public func qs_setTextUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置下划线")
        
        // 下划线样式
        let lineStytle = NSNumber.init(value: Int8(stytle.rawValue))
        
        let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: lineStytle, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
        
        self.attributedText = attributedString
    }
    
    /// 设置特定文字的下划线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    public func qs_setTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置下划线")
        
        // textRange
        let rangeArray = qs_getStringRangeArray(with: [text])
        
        if !qs_isArrayEmpty(rangeArray) {
            // 下划线样式
            let lineStytle = NSNumber.init(value: Int8(stytle.rawValue))
            
            let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: lineStytle, range: rangeArray.first!)
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: rangeArray.first!)
            
            
            self.attributedText = attributedString
        }
    }
    
    /// 设置特定区域的删除线
    ///
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 范围
    public func qs_setTextDeleteLine(color: UIColor, range: NSRange) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置删除线")
        
        let lineStytle = NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))
        
        let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: range)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: lineStytle, range: range)
        
        let version = qs_getSystemVersion() as NSString
        if version.floatValue >= 10.3 {
            attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: range)
        } else if version.floatValue <= 9.0 {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: range)
        }
        
        self.attributedText = attributedString
    }
    
    /// 设置特定文字的删除线
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 删除线颜色
    public func qs_setTextDeleteLine(_ text: String, color: UIColor) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再设置删除线")
        
        // textRange
        let rangeArray = qs_getStringRangeArray(with: [text])
        
        if !qs_isArrayEmpty(rangeArray) {
            let lineStytle = NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))
            
            let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: rangeArray.first!)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: lineStytle, range: rangeArray.first!)
            
            let version = qs_getSystemVersion() as NSString
            if version.floatValue >= 10.3 {
                attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: rangeArray.first!)
            } else if version.floatValue <= 9.0 {
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: rangeArray.first!)
            }
            
            self.attributedText = attributedString
        }
    }
    
    /// 插入图片
    ///
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imageRect必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex: 图片的位置，默认放在开头
    public func qs_insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) {
        assert(!qs_isStringEmpty(text), "请先设置text后，再添加图片")
        
        // 设置换行方式
        self.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        let attributedString = NSMutableAttributedString.init(attributedString: attributedText!)
        // NSTextAttachment可以将要插入的图片作为特殊字符处理
        let attch = NSTextAttachment.init()
        attch.image = qs_loadImage(imageName: imgName)
        attch.bounds = imgBounds
        
        // 创建带有图片的富文本
        let string = NSAttributedString.init(attachment: attch)
        // 将图片添加到富文本
        attributedString.insert(string, at: imgIndex)
        
        self.attributedText = attributedString
    }
    
    /// 辨别电话号码
    ///
    /// - Parameter complete: 识别完成Block
    public func qs_distinguishPhone(complete: ((String) -> ())) {
        // 获取字符串中的电话号码
        let regulaStr = "\\d{3,4}[- ]?\\d{7,8}"
        let stringRange = NSRange.init(location: 0, length: (text?.count)!)
        
        let attributedString = attributedText?.mutableCopy() as! NSMutableAttributedString
        
        let regexps = try? NSRegularExpression.init(pattern: regulaStr, options: NSRegularExpression.Options(rawValue: 0))
        
        if regexps != nil {
            regexps?.enumerateMatches(in: text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: stringRange, using: { (result, flags, stop) in
                let phoneRange = result?.range
                
                // 电话号码
                let phoneNumber = attributedString.attributedSubstring(from: phoneRange!).string
                
                // 判断是否是电话号码
                let isPhoneNumber = qs_validatePhone(phoneNumber)
                if isPhoneNumber {
                    complete(phoneNumber)
                }
            })
        }
    }
    
    /// 辨别网络地址
    ///
    /// - Parameter complete: 识别完成Block
    public func qs_distinguishUrl(complete: ((String) -> ())) {
        // 获取字符串中的网址
        let regulaStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let stringRange = NSRange.init(location: 0, length: (text?.count)!)
        
        let attributedString = attributedText?.mutableCopy() as! NSMutableAttributedString
        
        let regexps = try? NSRegularExpression.init(pattern: regulaStr, options: NSRegularExpression.Options(rawValue: 0))
        
        if regexps != nil {
            regexps?.enumerateMatches(in: text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: stringRange, using: { (result, flags, stop) in
                let urlRange = result?.range
                
                // 网络地址
                let urlStr = attributedString.attributedSubstring(from: urlRange!).string
                
                // 判断是否是网络地址
                let isUrl = qs_validateUrl(urlStr)
                if isUrl {
                    complete(urlStr)
                }
            })
        }
    }
    
    /// 添加点击事件
    ///
    /// 如果同一个label要对多个字符串添加点击事件，该方法只能调用一次，并把多有的字符串放到数组中，如果多次调用，会以最后一次调用为准
    /// - Parameters:
    ///   - textArray: 字符串数组
    ///   - clickBlock: 点击时间block
    public func qs_addTapAction(textArray: Array<String>, clickBlock: @escaping ((String) -> ())) {
        self.isUserInteractionEnabled = true
        
        qs_clickTextArray = textArray
        // 获取对应字符串的range数组
        qs_textRangeArray = qs_getStringRangeArray(with: textArray)
        
        // block
        qs_textClickBlock = clickBlock
    }
    
    /// 利用touchBegin来完成点击事件
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        let point = touch?.location(in: self)
        
        let clickText = qs_isTouchPointInTapFram(point: point!)
        
        if clickText != nil {
            if qs_textClickBlock != nil {
                qs_textClickBlock!(clickText!)
            }
        }
        
    }
    
    // MARK: - Private Methods
    /// 获取对应字符串的range数组
    ///
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
    private func qs_getStringRangeArray(with textArray: Array<String>) -> Array<NSRange> {
        // 获取所有的text
        let totalStr = attributedText?.string
        
        
        var rangeArray = Array<NSRange>.init()
        
        // 遍历
        for str in textArray {
            let range = totalStr?.range(of: str)
            
            if range != nil && !(range?.isEmpty)! {
                let range = NSRange.init(range!, in: totalStr!)
                
                rangeArray.append(range)
            }
        }
        
        return rangeArray
    }
    
    /// 判断点击的位置是否在对应范围
    private func qs_isTouchPointInTapFram(point: CGPoint) -> String? {
        // 一个frame的工厂，负责生成frame
        let framesetter = CTFramesetterCreateWithAttributedString(attributedText!)
        
        // 创建绘制区域
        var path = CGMutablePath.init()
        // 添加绘制尺寸
        path.addRect(CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        // 工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
        var frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        // 创建可见的字符串范围
        let range = CTFrameGetVisibleStringRange(frame)
        
        if (self.attributedText?.length)! > range.length {
            var font: UIFont?
            
            if ((attributedText?.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil)) != nil) {
                font = attributedText?.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont
            } else if self.font != nil {
                font = self.font
            } else {
                font = UIFont.systemFont(ofSize: 17.0)
            }
            
            // 重新创建绘制区域
            path = CGMutablePath.init()
            path.addRect(CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height + (font?.lineHeight)!))
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        }
        
        // 根据frame获取需要绘制的线的数组
        let lines = CTFrameGetLines(frame)
        let count = CFArrayGetCount(lines)
        if count == 0 {
            return nil
        }
        
        // 建立起点的数组
        var origins = [CGPoint](repeating: CGPoint.zero, count:count)
        // 获取起点
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0),&origins)
        // 把画布坐标转换为屏幕坐标
        let transform = qs_chransformCoreTextCoordinateToScreenCoordinate()
        
        for i in 0 ..< count {
            let linePoint = origins[i]
            
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            // CTRun的大小
            let flippedRect = qs_getCTRunBounds(line: line, point: linePoint)
            
            var rect = flippedRect.applying(transform)
            rect = rect.insetBy(dx: 0.0, dy: 0.0)
            rect = rect.offsetBy(dx: 0.0, dy: 0.0)
            
            let style = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil)
            // 线距离
            let lineSpace: CGFloat = style != nil ? (style as! NSParagraphStyle).lineSpacing : 0.0
            let lineS = lineSpace * CGFloat(count - 1)
            let lineOutSpace = (bounds.size.height - lineS - rect.size.height * CGFloat(count)) / 2
            
            rect.origin.y = lineOutSpace + rect.size.height * CGFloat(i) + lineSpace * CGFloat(i)
            
            if rect.contains(point) {
                let relativePoint = CGPoint.init(x: point.x - rect.minX, y: point.y - rect.minY)
                
                var index = CTLineGetStringIndexForPosition(line, relativePoint)
                
                var offset: CGFloat = 0.0
                CTLineGetOffsetForStringIndex(line, index, &offset)
                
                if offset > relativePoint.x {
                    index = index - 1
                }
                
                // 数组
                if !qs_isArrayEmpty(qs_textRangeArray) {
                    let link_count = qs_textRangeArray?.count
                    for j in 0 ..< link_count! {
                        
                        let link_range = qs_textRangeArray![j]
                        if NSLocationInRange(index, link_range as! NSRange) {
                            return qs_clickTextArray?[j]
                        }
                        
                    }
                }
            }
            
        }
        
        return nil
    }
    
    /// 把画布坐标转换为屏幕坐标
    private func qs_chransformCoreTextCoordinateToScreenCoordinate() -> CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: bounds.size.height).scaledBy(x: 1.0, y: -1.0)
    }
    
    /// 获取CTRun的大小
    private func qs_getCTRunBounds(line: CTLine, point: CGPoint) -> CGRect {
        var ascent: CGFloat = 0.0
        var descent: CGFloat = 0.0
        var leading: CGFloat = 0.0
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        let height = ascent + abs(descent) + leading
        
        return CGRect.init(x: point.x, y: point.y, width: CGFloat(width), height: height)
    }
    
    /// 字符串是否为空
    private func qs_isStringEmpty(_ string: String?) ->Bool {
        if let str = string {
            return str.isEmpty
        }
        return true
    }
    
    /// 数组是否为空
    private func qs_isArrayEmpty(_ array: Array<Any>?) ->Bool {
        if let arr = array {
            return arr.isEmpty
        }
        return true
    }
    
    /// 获取系统版本号
    private func qs_getSystemVersion() -> String {
        return UIDevice.current.systemVersion
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
    
    /// 验证手机号以及固话方法
    private func qs_validatePhone(_ number: String) -> Bool {
        // 验证输入的固话中不带 "-"符号
        let phoneRegex = "^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$)"
        let phoneTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        let phone = number.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        return phoneTest.evaluate(with: phone)
    }
    
    /// 验证网址
    private func qs_validateUrl(_ url: String) -> Bool {
        let urlRegex = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let urlTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        
        return urlTest.evaluate(with: url)
    }
}
