//
//  UITableView+QSReuse.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSNamespace where Base: UITableView {
    func registerCell<T: UIView>(cls: T.Type) {
        base.register(cls, forCellReuseIdentifier: T.className)
    }

    func registerCellFromNib<T: UIView>(cls: T.Type) {
        base.register(UINib.init(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }

    func registerHeaderFooter<T: UIView>(cls: T.Type) {
        base.register(cls, forHeaderFooterViewReuseIdentifier: T.className)
    }

    func registerHeaderFooterFromNib<T: UIView>(cls: T.Type) {
        base.register(UINib.init(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }

    func dequeueReusableCell<T: UIView>(_: T.Type) -> T {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("没有注册cell，identifier = \(T.className)")
        }
        return cell
    }

    func dequeueReusableHeaderFooter<T: UIView>(_: T.Type) -> T {
        guard let view = base.dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("没有注册HeaderFooterView，identifier = \(T.className)")
        }
        return view
    }
}
