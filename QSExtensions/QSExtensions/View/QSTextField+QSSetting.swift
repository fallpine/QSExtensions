//
//  QSTextField+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/1/24.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSTextField {
    /// 限制输入字符的长度
    func qs_limitTextLength(_ length: Int) -> QSTextField {
        self.qs_limitTextLength = length
        return self
    }
    
    /// 限制小数位数
    func qs_limitDecimalLength(_ length: Int) -> QSTextField {
        self.qs_limitDecimalLength = length
        return self
    }
    
    /// 限制小数位数
    func qs_isAllowEmoji(_ isAllow: Bool) -> QSTextField {
        self.qs_isAllowEmoji = isAllow
        return self
    }
    
    /// 只允许输入数字和字母
    func qs_isOnlyLetterAndNumber(_ isOnly: Bool) -> QSTextField {
        self.qs_isOnlyLetterAndNumber = isOnly
        return self
    }
}
