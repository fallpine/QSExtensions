//
//  String+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/3/1.
//  Copyright © 2018年 Song. All rights reserved.
//

import Foundation
import UIKit

/// 时间戳格式
public enum QSTimeStampType {
    case second       // 秒
    case milliSecond        // 毫秒
}

extension String {
    /// 转换为日期
    ///
    /// - Parameter dateFormat: 日期格式化样式
    public func qs_changeToDate(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter: DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    /// 时间戳转换为时间字符串
    ///
    /// - Parameter dateFormat: 日期格式化样式
    public func qs_timeStampChangeToDateString(timeStampType: QSTimeStampType = .second, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        if let timeInterval: TimeInterval = TimeInterval(self) {
            var timeValue = timeInterval
            switch timeStampType {
            case .second:
                timeValue = timeInterval
            case .milliSecond:
                timeValue = timeInterval / 1000
            }
            let date = Date.init(timeIntervalSince1970: timeValue)
            
            // 格式话输出
            let dformatter = DateFormatter.init()
            dformatter.dateFormat = dateFormat
            
            return dformatter.string(from: date)
        }
        
        return nil
    }
    
    /// 获取字符串文字的宽度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    public func qs_obtainWidth(font: UIFont, height: CGFloat) -> CGFloat {
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
    public func qs_obtainHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font:font] // 设置字体大小
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let rect: CGRect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil)
        
        return rect.height
    }
    
    /// 去除字符串中的html标签
    public func qs_deleteHTMLTag() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    /// 按照字符分割字符串
    ///
    /// - Parameter with: 分隔符
    public func qs_division(_ with: String) -> Array<String> {
        return components(separatedBy: CharacterSet.init(charactersIn: with))
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
