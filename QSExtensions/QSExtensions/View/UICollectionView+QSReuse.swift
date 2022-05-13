//
//  UICollectionView+QSReuse.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit

public enum QSCollectionHeaderFooterKind: String {
    case header = "UICollectionElementKindSectionHeader"
    case footer = "UICollectionElementKindSectionFooter"
}

public extension QSNamespace where Base: UICollectionView {
    func registerCell<T: UIView>(cls: T.Type) {
        base.register(cls, forCellWithReuseIdentifier: T.className)
    }

    func registerCellFromNib<T: UIView>(cls: T.Type) {
        base.register(UINib.init(nibName: T.className, bundle: nil), forCellWithReuseIdentifier: T.className)
    }

    func registerHeaderFooter<T: UIView>(cls: T.Type, kind: QSCollectionHeaderFooterKind) {
        base.register(cls, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.className)
    }

    func registerHeaderFooterFromNib<T: UIView>(cls: T.Type, kind: QSCollectionHeaderFooterKind) {
        base.register(UINib.init(nibName: T.className, bundle: nil), forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.className)
    }

    func dequeueReusableCell<T: UIView>(_: T.Type, indexPath: IndexPath) -> T {
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("没有注册cell，identifier = \(T.className)")
        }
        
        return cell
    }

    func dequeueReusableHeaderFooter<T: UIView>(_: T.Type, kind: QSCollectionHeaderFooterKind, indexPath: IndexPath) -> T {
        guard let view = base.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("没有注册HeaderFooterView，identifier = \(T.className)")
        }
        
        return view
    }
}
