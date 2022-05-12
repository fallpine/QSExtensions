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
public enum QSEndRefreshType {
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
    var qs_endRefreshing: Binder<QSEndRefreshType> {
        return Binder.init(base) { (header, _) in
            header.endRefreshing()
        }
    }
}

public extension Reactive where Base: MJRefreshFooter {
    /// 停止底部刷新
    var qs_endRefreshing: Binder<QSEndRefreshType> {
        return Binder.init(base, binding: { (footer, endType) in
            switch endType{
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
