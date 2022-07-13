//
//  MJRefresh+Rx.swift
//  QSExtensions
//
//  Created by Song on 2018/9/14.
//  Copyright © 2018年 Song. All rights reserved.
//

import RxSwift
import RxCocoa
import MJRefresh

/// 结束刷新类型
public enum QSRefreshState {
    case refreshing     // 正在刷新
    case end            // 结束
    case noMoreData     // 没有更多数据
}

public extension Reactive where Base: MJRefreshComponent {
    /// 正在刷新，下拉和上拉都是触发这个属性
    var qs_refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer -> Disposable  in
            MainScheduler.ensureExecutingOnScheduler()
            
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }
            
            control.refreshingBlock = {
                observer.on(.next(()))
            }
            return Disposables.create()
        }.take(until: deallocated)
        
        return ControlEvent(events: source)
    }
}

public extension Reactive where Base: MJRefreshHeader {
    /// 停止头部刷新
    var qs_endRefreshing: Binder<QSRefreshState> {
        return Binder.init(base) { (header, state) in
            switch state {
            case .refreshing:
                break
            case .end, .noMoreData:
                header.endRefreshing()
            }
        }
    }
}

public extension Reactive where Base: MJRefreshFooter {
    /// 停止底部刷新
    var qs_endRefreshing: Binder<QSRefreshState> {
        return Binder.init(base, binding: { (footer, state) in
            switch state{
            case .refreshing:
                break
            case .end:
                footer.endRefreshing()
            case .noMoreData:
                footer.endRefreshingWithNoMoreData()
            }
        })
    }
}

public extension UIScrollView {
    /// 添加头部刷新
    func qs_addHeaderRefresh() {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        mj_header = header
    }
    
    /// 添加底部加载更多
    func qs_addFooterRefresh() {
        let footer = MJRefreshBackNormalFooter()
        mj_footer = footer
    }
}
