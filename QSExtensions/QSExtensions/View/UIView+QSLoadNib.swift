//
//  UIView+QSLoadNib.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public extension QSNamespace where Base: UIView {
    static func loadNib() -> Base {
        let nibName = String(describing: Base.self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Base else {
            fatalError("找不到nib文件，nibName = \(nibName)")
        }
        return view
    }
}
