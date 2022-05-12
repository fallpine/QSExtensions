//
//  Timer+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/27.
//  Copyright © 2019 Song. All rights reserved.
//
//  使用Timer时，需要主要Timer的销毁问题
//  自动销毁：实现了RxSwift的Disposable协议，可用.disposed(by: DisposeBag)来实现timer的自动销毁
//  手动销毁：在使用Timer的类中，重写deinit()，在deinit方法中手动销毁timer

import Foundation
import RxSwift

public extension Timer {
    /// 创建定时器
    ///
    /// - Parameters:
    ///   - dueTime: 多久开始执行，默认立即执行
    ///   - period: 周期间隔
    ///   - timeOut: 定时器到时闭包
    class func qs_timer(dueTime: TimeInterval = 0.0, period: TimeInterval, timeOut: @escaping (Timer) -> ()) -> Disposable {
        let timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true) { timer in
            timeOut(timer)
        }
        RunLoop.current.add(timer, forMode: .common)
        timer.qs_restart(dueTime: dueTime)
        return timer
    }
    
    // MARK: -  Private Methods
    /// 暂停
    func qs_suspend() {
        fireDate = Date.distantFuture
    }
    
    /// 重新开始
    /// - Parameter dueTime: 多久开始执行
    func qs_restart(dueTime: TimeInterval? = nil) {
        if let interval = dueTime {
            fireDate = Date.init(timeInterval: interval, since: Date.init())
        } else {
            fireDate = Date.init()
        }
    }
    
    /// 关闭
    func qs_invalidate() {
        invalidate()
    }
}

extension Timer: Disposable {
    public func dispose() {
        qs_invalidate()
    }
}

