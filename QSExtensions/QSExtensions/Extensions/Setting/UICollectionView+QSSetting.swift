//
//  UICollectionView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UICollectionView {
    /// 创建collectionView
    ///
    /// - Parameter layout: 布局
    convenience init(layout: UICollectionViewFlowLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
    }
    
    /// 设置背景颜色
    @discardableResult
    func qs_backgroundColor(_ color: UIColor) -> UICollectionView {
        backgroundColor = color
        return self
    }
    
    /// 设置数据源
    @discardableResult
    func qs_dataSource(_ dataSource: UICollectionViewDataSource) -> UICollectionView {
        self.dataSource = dataSource
        return self
    }
    
    /// 设置代理
    @discardableResult
    func qs_delegate(_ delegate: UICollectionViewDelegate) -> UICollectionView {
        self.delegate = delegate
        return self
    }
}
