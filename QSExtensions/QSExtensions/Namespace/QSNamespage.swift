//
//  QSNamespage.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public protocol QSNamespageCompatible {
    associatedtype WrapperType
    var qs: WrapperType { get set }
    static var qs: WrapperType.Type { get }
}

public extension QSNamespageCompatible {
    var qs: QSNamespace<Self> {
        get {
            return QSNamespace(value: self)
        }
        set {}
    }

    static var qs: QSNamespace<Self>.Type {
        return QSNamespace.self
    }
}

public struct QSNamespace<Base> {
    var base: Base
    init(value: Base) {
        self.base = value
    }
}

extension UIView: QSNamespageCompatible {}
