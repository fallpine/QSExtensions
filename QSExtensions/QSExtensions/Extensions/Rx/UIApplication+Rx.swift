//
//  UIApplication+Rx.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/13.
//  Copyright © 2022 Song. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
 
// 自定义应用状态枚举
public enum QSAppState {
    case active
    case inactive
    case background
    case terminated
}
 
// 扩展
extension UIApplication.State {
    // 将其转为我们自定义的应用状态枚举
    func toAppState() -> QSAppState{
        switch self {
        case .active:
            return .active
        case .inactive:
            return .inactive
        case .background:
            return .background
        @unknown default:
            fatalError()
        }
    }
}
 
public extension Reactive where Base: UIApplication {
    // 代理委托
    var delegate: DelegateProxy<UIApplication, UIApplicationDelegate> {
        return RxUIApplicationDelegateProxy.proxy(for: base)
    }
     
    // 应用进入活动状态
    var didBecomeActive: Observable<QSAppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationDidBecomeActive(_:)))
            .map{ _ in return .active}
    }
     
    // 应用进入非活动状态
    var willResignActive: Observable<QSAppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillResignActive(_:)))
            .map{ _ in return .inactive}
    }
     
    // 应用从后台恢复至前台（还不是活动状态）
    var willEnterForeground: Observable<QSAppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillEnterForeground(_:)))
            .map{ _ in return .inactive}
    }
     
    // 应用进入到后台
    var didEnterBackground: Observable<QSAppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationDidEnterBackground(_:)))
            .map{ _ in return .background}
    }
     
    // 应用终止
    var willTerminate: Observable<QSAppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillTerminate(_:)))
            .map{ _ in return .terminated}
    }
    
    // 注册设备令牌
    var didRegisterDeviceToken: Observable<Data?> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.application(_:didRegisterForRemoteNotificationsWithDeviceToken:)))
            .map { data in
                if data.count > 1 {
                    let token = data[1] as? Data
                    return token
                }
                return nil
            }
    }
     
    // 应用各状态变换序列
    var state: Observable<QSAppState> {
        return Observable.of(
            didBecomeActive,
            willResignActive,
            willEnterForeground,
            didEnterBackground,
            willTerminate
            )
            .merge()
            .startWith(base.applicationState.toAppState()) // 为了让开始订阅时就能获取到当前状态
    }
}
