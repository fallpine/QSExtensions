//
//  UICollectionView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// 创建collectionView
    ///
    /// - Parameter layout: 布局
    public class func qs_init(layout: UICollectionViewFlowLayout) -> UICollectionView {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        
        return collectionView
    }
    
    /// 设置背景颜色
    public func qs_backgroundColor(_ color: UIColor) -> UICollectionView {
        backgroundColor = color
        return self
    }
    
    /// 设置数据源
    public func qs_dataSource(_ dataSource: UICollectionViewDataSource) -> UICollectionView {
        self.dataSource = dataSource
        return self
    }
    
    /// 设置代理
    public func qs_delegate(_ delegate: UICollectionViewDelegate) -> UICollectionView {
        self.delegate = delegate
        return self
    }
}
