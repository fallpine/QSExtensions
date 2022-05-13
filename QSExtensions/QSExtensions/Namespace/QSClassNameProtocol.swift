//
//  QSClassNameProtocol.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

// MARK: - 类名，把类名转换为字符串
public protocol QSClassNameProtocol {
    static var className: String { get }
}

public extension QSClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
}

extension UIView: QSClassNameProtocol {}
