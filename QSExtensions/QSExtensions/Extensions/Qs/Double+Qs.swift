//
//  Double+Qs.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/25.
//  Copyright © 2022 Song. All rights reserved.
//

import Foundation

public extension Double {
    /// 转换为String
    /// - Parameter decimal: 小数位数，0：表示仅保留有效位
    func qs_toString(_ decimal: Int = 0) -> String {
        if decimal == 0 {
            return String.init(format: "%g", self)
        }
        let str = "%." + "\(decimal)" + "f"
        return String.init(format: str, self)
    }
    
    /// 时间戳转换为日期
    func qs_toDate() -> Date? {
        return Date.init(timeIntervalSince1970: self)
    }
}
