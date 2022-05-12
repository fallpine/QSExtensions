//
//  Data+QSEncode.swift
//  QSExtensions
//
//  Created by Mac on 2022/4/20.
//  Copyright © 2022 Song. All rights reserved.
//

import Foundation

public extension Data {
    /// base64编码
    func qs_base64Encode() -> String {
        return self.base64EncodedString(options: .endLineWithLineFeed)
    }
}
