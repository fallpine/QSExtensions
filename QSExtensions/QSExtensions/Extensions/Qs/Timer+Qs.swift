//
//  Timer+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/27.
//  Copyright © 2019 Song. All rights reserved.
//

import Foundation

extension Timer {
    /// 新增属性key
    private struct AssociatedKeys {
        static var timeOutClosureKey: String = "timeOutClosureKey"
    }
    
    /// 时间到
    private var qs_timeOutClosure: ((Timer) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.timeOutClosureKey) as? ((Timer) -> ())
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.timeOutClosureKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - interval: 时间间隔
    ///   - timeOut: 定时器到时闭包
    class func qs_init(timeInterval: TimeInterval, timeOut: ((Timer) -> ())?) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
                if timeOut != nil {
                    timeOut!(timer)
                }
            }
        } else {
            let myTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.timeOut(timer:)), userInfo: nil, repeats: true)
            myTimer.qs_timeOutClosure = timeOut
            
            return myTimer
        }
    }
    
    // MARK: -  Private Methods
    /// 定时器到时
    @objc class private func timeOut(timer: Timer) {
        if timer.qs_timeOutClosure != nil {
            timer.qs_timeOutClosure!(timer)
        }
    }
    
    /// 暂停
    func qs_pause() {
        self.fireDate = Date.distantFuture
    }
    
    /// 重新开始
    func qs_restart(timeInterval: TimeInterval? = nil) {
        if let interval = timeInterval {
            self.fireDate = Date.init(timeInterval: interval, since: Date.init())
        } else {
            self.fireDate = Date.init()
        }
    }
    
    /// 关闭
    func qs_invalidate() {
        self.invalidate()
    }
}

