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

extension Timer {
    /// 创建定时器
    ///
    /// - Parameters:
    ///   - isPerform: 是否立刻执行一次 timeOut
    ///   - interval: 时间间隔
    ///   - timeOut: 定时器到时闭包
    public class func qs_timer(isPerform: Bool, interval: TimeInterval, timeOut: @escaping () -> ()) -> Timer {
        if isPerform {
            timeOut()
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            timeOut()
        }
        RunLoop.current.add(timer, forMode: .common)
        return timer
    }
    
    // MARK: -  Private Methods
    /// 暂停
    public func qs_suspend() {
        fireDate = Date.distantFuture
    }
    
    /// 重新开始
    public func qs_restart(timeInterval: TimeInterval? = nil) {
        if let interval = timeInterval {
            fireDate = Date.init(timeInterval: interval, since: Date.init())
        } else {
            fireDate = Date.init()
        }
    }
    
    /// 关闭
    public func qs_invalidate() {
        invalidate()
    }
}

extension Timer: Disposable {
    public func dispose() {
        qs_invalidate()
    }
}

