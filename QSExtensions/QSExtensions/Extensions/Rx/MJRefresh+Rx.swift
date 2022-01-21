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

/// 结束上拉刷新类型
public enum QSEndFooterRefreshType {
    case notEnd         // 不结束
    case end            // 结束
    case noMoreData     // 没有更多数据
}

extension Reactive where Base: MJRefreshComponent {
    /// 正在刷新
    public var qs_refreshing: ControlEvent<Void> {
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
            }.takeUntil(deallocated)
        
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: MJRefreshHeader {
    /// 停止头部刷新
    public var qs_endHeaderRefreshing: Binder<Bool> {
        return Binder.init(base) { (header, isEnd) in
            if isEnd {
                header.endRefreshing()
            }
        }
    }
}

extension Reactive where Base: MJRefreshFooter {
    /// 停止底部刷新
    public var qs_endFooterRefreshing: Binder<QSEndFooterRefreshType> {
        return Binder.init(base, binding: { (footer, endType) in
            switch endType{
            case .notEnd:
                break
            case .end:
                footer.endRefreshing()
            case .noMoreData:
                footer.endRefreshingWithNoMoreData()
            }
        })
    }
}

extension Reactive where Base: UIScrollView {
    /// 向上滚动，取消上拉
    public var qs_isUpDragging: ControlEvent<Bool> {
        let source = base.rx.didEndDragging
            .map { [weak scrView = self.base] _ -> Bool in
                guard let scrView = scrView else {
                    return false
                }
                
                let translation = scrView.panGestureRecognizer.translation(in: scrView.superview)
                if translation.y < 0 {
                    return true
                } else {
                    return false
                }
        }
        
        return ControlEvent(events: source)
    }
    
    /// 向下滚动，取消下拉
    public var qs_isDrowDragging: ControlEvent<QSEndFooterRefreshType> {
        let source = base.rx.didEndDragging
            .map { [weak scrView = self.base] _ -> QSEndFooterRefreshType in
                guard let scrView = scrView else {
                    return .notEnd
                }
                
                let translation = scrView.panGestureRecognizer.translation(in: scrView.superview)
                if translation.y > 0 {
                    return .end
                } else {
                    return .notEnd
                }
        }
        
        return ControlEvent(events: source)
    }
}

extension UIScrollView {
    /// 添加头部刷新
    public func qs_addHeaderRefresh() {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        mj_header = header
    }
    
    /// 添加底部加载更多
    public func qs_addFooterRefresh() {
        let footer = MJRefreshBackNormalFooter()
        mj_footer = footer
    }
}
