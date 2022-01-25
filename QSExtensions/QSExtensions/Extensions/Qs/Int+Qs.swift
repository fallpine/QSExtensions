//
//  Int+Qs.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/25.
//  Copyright © 2022 Song. All rights reserved.
//

import Foundation

public extension Int {
    /// 转换为String
    func qs_toString() -> String {
        return String.init(format: "%d", self)
    }
}
