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

public extension String {
    /// 转换为number
    func qs_toNumber() -> NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
    
    /// 转换为double
    func qs_toDouble() -> Double? {
        return qs_toNumber()?.doubleValue
    }
    
    /// 转换为int
    func qs_toInt() -> Int? {
        return qs_toNumber()?.intValue
    }
    
    /// 转换为data
    func qs_toData(using: String.Encoding = .utf8) -> Data? {
        return data(using: using)
    }
    
    /// 转换为日期
    ///
    /// - Parameter format: 日期格式化样式
    func qs_toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter: DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
    
    /// 获取字符串文字的宽度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    func qs_width(font: UIFont, height: CGFloat) -> CGFloat {
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
    func qs_height(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font:font] // 设置字体大小
        let option = NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue
        
        let rect: CGRect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: option), attributes: attributes, context: nil)
        
        return rect.height
    }
    
    /// 按照字符分割字符串
    ///
    /// - Parameter by: 分隔符
    func qs_separated(_ by: String) -> Array<String> {
        return components(separatedBy: by)
    }
    
    /// 删除首尾指定字符
    /// - Parameter char: 要删除的字符
    func qs_trimCharacters(_ char: String) -> String {
        let set = CharacterSet.init(charactersIn: char)
        return trimmingCharacters(in: set)
    }
    
    /// 替换字符串
    /// - Parameters:
    ///   - str: 被替换的字符串
    ///   - with: 新字符串
    ///   - range: 被替换的范围，nil：整个字符串
    func qs_replace(_ str: String, with: String, range: NSRange? = nil) -> String {
        guard let range = range else {
            return replacingOccurrences(of: str, with: with)
        }
        
        let firstIndex = self.index(startIndex, offsetBy: range.location)
        let lastIndex = self.index(firstIndex, offsetBy: range.length)
        return replacingOccurrences(of: str, with: with, range: firstIndex ..< lastIndex)
    }
    
    /// 替换指定范围内的字符串
    /// - Parameters:
    ///   - range: 范围
    ///   - with: 新字符串
    func qs_replace(range: NSRange, with: String) -> String {
        let firstIndex = self.index(startIndex, offsetBy: range.location)
        let lastIndex = self.index(firstIndex, offsetBy: range.length)
        return replacingCharacters(in: firstIndex ..< lastIndex, with: with)
    }
    
    /// 字符串分组（123 456 789）
    ///
    /// - Parameters:
    ///   - size: 每组长度
    ///   - separator: 分隔符
    func qs_group(size: Int, separator: String) -> String {
        var range = 0
        if self.count % size > 0 {
            range = self.count / size
        } else {
            range = self.count / size - 1
        }
        
        var tempStr = self
        for i in 0 ..< range {
            let index = tempStr.index(startIndex, offsetBy: (size * (i + 1) + i - 1))
            tempStr.insert(Character.init(separator), at: tempStr.index(after: index))
        }
        return tempStr
    }
    
    // MARK: - 子字符串
    func qs_subString(to: UInt) -> String {
        let toStrIndex = self.index(startIndex, offsetBy: Int(to), limitedBy: endIndex) ?? endIndex
        return String(self[startIndex ..< toStrIndex])
    }
    
    func qs_subString(from: UInt) -> String {
        let fromStrIndex = self.index(startIndex, offsetBy: Int(from), limitedBy: endIndex) ?? endIndex
        return String(self[fromStrIndex ..< endIndex])
    }
    
    func qs_subString(from: UInt, to: UInt) -> String {
        assert(to >= from, "to的值必须 >= from的值")
        
        let fromStrIndex = self.index(startIndex, offsetBy: Int(from), limitedBy: endIndex) ?? endIndex
        let toStrIndex = self.index(startIndex, offsetBy: Int(to), limitedBy: endIndex) ?? endIndex
        return String(self[fromStrIndex ..< toStrIndex])
    }
}
