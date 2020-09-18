//
//  BehaviorRelay+Qs.swift
//  QSExtensions
//
//  Created by Song on 2020/9/18.
//  Copyright © 2020 Song. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay where Element: Equatable {
    /// 内容改变才有更新值
    public func qs_acceptChange(_ event: Element) {
        if value != event {
            accept(event)
        }
    }
}
