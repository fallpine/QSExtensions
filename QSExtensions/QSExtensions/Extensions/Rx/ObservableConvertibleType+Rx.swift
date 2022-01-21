//
//  ObservableConvertibleType+Rx.swift
//  QSExtensions
//
//  Created by Song on 2018/9/17.
//  Copyright © 2018年 Song. All rights reserved.
//

import RxSwift

public extension ObservableConvertibleType where Element: Equatable {
    /// 判断当前值是否与前一个值相同
    ///
    /// - Returns: （value：当前值，isEqual：是否相同）
    func qs_isEqualToBeforeValue() -> Observable<(value: Element, isEqual: Bool)> {
        return self.asObservable()
            .scan(nil) { acum, x -> (origin: Element?, current: Element)? in
                if let acum = acum {
                    return (origin: acum.current, current: x)
                } else {
                    return (origin: x, current: x)
                }
            }.map {
                if let origin = $0!.origin {
                    return ($0!.current, isEqual: origin == $0!.current)
                } else {
                    return ($0!.current, isEqual: false)
                }
            }
    }
    
    /// 判断当前值是否与初始值相同
    ///
    /// - Returns: （value：当前值，isEqual：是否相同）
    func qs_isEqualToOriginValue() -> Observable<(value: Element, isEqual: Bool)> {
        return self.asObservable()
            .scan(nil) { acum, x -> (origin: Element?, current: Element)? in
                if let acum = acum {
                    return (origin: acum.origin, current: x)
                } else {
                    return (origin: x, current: x)
                }
            }.map {
                if let origin = $0!.origin {
                    return ($0!.current, isEqual: origin == $0!.current)
                } else {
                    return ($0!.current, isEqual: false)
                }
            }
    }
}

public extension ObservableConvertibleType {
    /// 重复执行某个序列
    ///
    /// - Parameter notifier: 触发该原序列发送的序列
    /// - Returns: 原序列
    func qs_repeatWhen<O: ObservableType>(_ notifier: O) -> Observable<Element> {
        return notifier.map { _ in }
        .startWith(())
        .flatMap { () -> Observable<Element> in
            self.asObservable()
        }
    }
}
