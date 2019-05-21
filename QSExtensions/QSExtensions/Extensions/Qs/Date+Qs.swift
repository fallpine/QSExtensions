//
//  Date+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/3/1.
//  Copyright © 2018年 Song. All rights reserved.
//

import Foundation

extension Date {
    /// 日期转换为字符串
    ///
    /// - Parameter dateFormat: 日期格式 (yyyy-MM-dd HH:mm:ss zzz) zzz表示时区
    func qs_changeToString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter: DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        
        let dateStr = dateFormatter.string(from: self)
        
        return dateStr
    }
    
    /// 转换为时间戳（秒）
    func qs_changeToSecondTimestamp() -> String {
        // 创建一个日期格式器
        let dformatter = DateFormatter.init()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //当前时间的时间戳
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        return String(timeStamp)
    }
    
    /// 转换为时间戳（毫秒）
    func qs_changeToMilliSecondTimestamp() -> String {
        // 创建一个日期格式器
        let dformatter = DateFormatter.init()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss SSS"
        
        //当前时间的时间戳
        let timeInterval: TimeInterval = self.timeIntervalSince1970 * 1000
        let timeStamp = Int(timeInterval)
        
        return String(timeStamp)
    }
    
    /// 比较2个日期差
    ///
    /// - Parameters:
    ///   - date: 要与self比较的时间
    ///   - dateFormat: 日期格式
    func qs_intervalToDate(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        // 首先创建格式化对象
        let dateFormatter: DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        
        // 计算时间间隔（单位是秒）
        let intervalTime: TimeInterval = self.timeIntervalSince(date)
        
        let days: Int = Int(intervalTime / (3600 * 24))
        let hours: Int = Int(intervalTime.truncatingRemainder(dividingBy: (3600 * 24)) / 3600)
        let minutes: Int = Int(intervalTime.truncatingRemainder(dividingBy: (3600 * 24)).truncatingRemainder(dividingBy: 3600) / 60)
        let seconds: Int = Int(intervalTime.truncatingRemainder(dividingBy: (3600 * 24)).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60))
        
        return (days, hours, minutes, seconds)
    }
    
    /// 与当前的日期差
    func qs_intervalToNow() -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        return qs_intervalToDate(Date.init())
    }
    
    /// 获取这个月有多少天
    func qs_daysInMonth() -> Int {
        return NSCalendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
    /// 获取日期是星期几
    ///
    /// - Parameter dateFormat: 日期格式
    func qs_weekDay(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Int {
        
        let dateFmt = DateFormatter.init()
        dateFmt.dateFormat = dateFormat
        
        let interval = Int(timeIntervalSince1970)
        let days = Int(interval / 86400)
        
        let weekday = ((days + 4) % 7 + 7) % 7
        return weekday
    }
    
    /// 获取当前Day
    func qs_day() -> Int {
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        return com.day!
    }
    
    /// 获取当前Month
    func qs_month() -> Int {
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        return com.month!
    }
    
    /// 获取当前Year
    func qs_year() -> Int {
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        return com.year!
    }
    
    /// 获取时
    func qs_hour() -> Int {
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.hour, .minute], from: self)
        return com.hour!
    }
    
    /// 获取分
    func qs_minute() -> Int {
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.hour, .minute], from: self)
        return com.minute!
    }
    
    /// 获取前后的日期
    ///
    /// - Parameter days: >0：以后的日期；<0：以前的日期
    func qs_theDateTo(_ days: Int) -> Date {
        let beforeDay = Calendar.current.date(byAdding: Calendar.Component.day, value: days, to: self)
        
        return beforeDay!
    }
    
    /// 是否是今天
    func qs_isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// 是否是昨天
    func qs_isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// 是否是明天
    public func qs_isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}
