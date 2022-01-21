//
//  UIScrollView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UIScrollView {
    /// 创建scrollView
    ///
    /// - Parameter backgroundColor: 背景颜色
    convenience init(with backgroundColor: UIColor) {
        self.init()
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = backgroundColor
    }
}
