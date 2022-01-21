//
//  UIScrollView+Rx.swift
//  QSExtensions
//
//  Created by Song on 2018/9/17.
//  Copyright © 2018年 Song. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIScrollView  {
    /// 是否滚动到顶部
    var qs_reachedTop: Signal<()> {
        return contentOffset.asDriver()
            .flatMap { [weak base] contentOffset -> Signal<()> in
                guard let _ = base else {
                    return Signal.empty()
                }
                
                return contentOffset.y < 0.0 ? Signal.just(()) : Signal.empty()
        }
    }
    
    /// 是否滚动到底部
    var qs_reachedBottom: Signal<()> {
        return contentOffset.asDriver()
            .flatMap { [weak base] contentOffset -> Signal<()> in
                guard let scrollView = base else {
                    return Signal.empty()
                }
                
                // 可视区域高度
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top
                    - scrollView.contentInset.bottom
                // 滚动条最大位置
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                // 如果当前位置超出最大位置则发出一个事件
                let y = contentOffset.y + scrollView.contentInset.top
                return y > threshold ? Signal.just(()) : Signal.empty()
        }
    }
}
