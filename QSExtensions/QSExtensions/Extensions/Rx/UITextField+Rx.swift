//
//  UITextField+Rx.swift
//  QSExtensions
//
//  Created by Song on 2019/5/15.
//  Copyright © 2019 Song. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base : UITextField {
    /// 文字变化
    public var qs_text: Observable<String?> {
        get {
            return Observable.merge(self.text.asObservable(),
                                    self.observe(String.self, "text").take(until: self.deallocated))
        }
    }
}
