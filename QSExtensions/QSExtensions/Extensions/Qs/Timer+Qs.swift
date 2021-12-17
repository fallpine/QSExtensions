//
//  Timer+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/27.
//  Copyright © 2019 Song. All rights reserved.
//
//  使用Timer时，需要主要Timer的销毁问题

import Foundation

extension Timer {
    /// 新增属性key
    private struct AssociatedKeys {
        static var timeOutBlockKey: String = "timeOutBlockKey"
    }
    
    /// 时间到
    private var qs_timeOutBlock: ((Timer) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.timeOutBlockKey) as? ((Timer) -> ())
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.timeOutBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - interval: 时间间隔
    ///   - timeOut: 定时器到时闭包
    public class func qs_init(timeInterval: TimeInterval, timeOut: ((Timer) -> ())?) -> Timer {
        if #available(iOS 10.0, *) {
            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
                if timeOut != nil {
                    timeOut!(timer)
                }
            }
            RunLoop.current.add(timer, forMode: .common)
            return timer
        } else {
            let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.timeOut(timer:)), userInfo: nil, repeats: true)
            timer.qs_timeOutBlock = timeOut
            RunLoop.current.add(timer, forMode: .common)
            return timer
        }
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
    
    /// 定时器到时
    @objc class private func timeOut(timer: Timer) {
        if timer.qs_timeOutBlock != nil {
            timer.qs_timeOutBlock!(timer)
        }
    }
}

