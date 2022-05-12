//
//  Data+Qs.swift
//  QSExtensions
//
//  Created by Mac on 2022/4/20.
//  Copyright © 2022 Song. All rights reserved.
//

import Foundation

public extension Data {
    /// 转换为string
    func qs_toString(_ encoding: String.Encoding = .utf8) -> String? {
        return String.init(data: self, encoding: encoding)
    }
}
