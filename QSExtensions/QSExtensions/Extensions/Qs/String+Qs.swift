//
//  String+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/3/1.
//  Copyright © 2018年 Song. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension String {
    /// 转换为日期
    ///
    /// - Parameter format: 日期格式化样式
    public func qs_toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter: DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
    /// 时间戳转换为日期
    public func qs_timeStampToDate() -> Date? {
        guard let timeInterval = TimeInterval.init(self) else { return nil }
        return Date.init(timeIntervalSince1970: timeInterval)
    }
    
    /// 获取字符串文字的宽度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    public func qs_width(font: UIFont, height: CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font:font] // 设置字体大小
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let rect: CGRect = self.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height), options: option, attributes: attributes, context: nil)
        
        return rect.width
    }
    
    /// 获取字符串文字的高度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - width: 宽度
    /// - Returns: 高度
    public func qs_height(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font:font] // 设置字体大小
        let option = NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue
        
        let rect: CGRect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: option), attributes: attributes, context: nil)
        
        return rect.height
    }
    
    /// 按照字符分割字符串
    ///
    /// - Parameter with: 分隔符
    public func qs_division(_ with: String) -> Array<String> {
        return components(separatedBy: with)
    }
    
    /// 去掉首尾空格
    public func qs_removeHeadAndTailSpace() -> String {
        let whiteSpace = NSCharacterSet.whitespaces
        return trimmingCharacters(in: whiteSpace)
    }
    
    /// 去掉首尾空格 包括后面的换行 \n
    public func qs_removeHeadAndTailSpaceAndNewline() -> String {
        let whiteSpace = NSCharacterSet.whitespacesAndNewlines
        return trimmingCharacters(in: whiteSpace)
    }
    
    /// 去掉所有空格和换行 \n
    public func qs_removeAllSapceAndNewline() -> String {
        var string: String = ""
        
        string = replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        string = string.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        
        return string
    }
    
    /// 字符串分组（123 456 789）
    ///
    /// - Parameters:
    ///   - size: 每组长度
    ///   - separator: 分隔符
    public mutating func qs_group(size: Int, separator: String) {
        for i in 0 ..< (self.count / size) {
            let index = self.index(startIndex, offsetBy: (size * (i + 1) + i - 1))
            self.insert(Character.init(separator), at: self.index(after: index))
        }
    }
    
    // MARK: - 子字符串
    public func qs_subString(to: Int) -> String {
        let toStrIndex = self.index(startIndex, offsetBy: to)
        
        return String(self[startIndex ..< toStrIndex])
    }
    
    public func qs_subString(from: Int) -> String {
        let fromStrIndex = self.index(startIndex, offsetBy: from)
        
        return String(self[fromStrIndex ..< endIndex])
    }
    
    public func qs_subString(from: Int, to: Int) -> String {
        let fromStrIndex = self.index(startIndex, offsetBy: from)
        let toStrIndex = self.index(startIndex, offsetBy: to)
        
        return String(self[fromStrIndex ..< toStrIndex])
    }
}
