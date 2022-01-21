//
//  UIScrollView+QSExtension.swift
//  TestSwift
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIScrollView: UIScrollViewDelegate {
    /// 新增属性key
    private struct AssociatedKeys {
        static var didScroll: String = "didScroll"
        static var didEndScrollKey: String = "didEndScrollKey"
        static var beginDraggingKey: String = "beginDraggingKey"
        static var isShareRecognizer: String = "isShareRecognizer"
        static var isHorizontalScrollEnabled: String = "isHorizontalScrollEnabled"
        static var isVerticalScrollEnabled: String = "isVerticalScrollEnabled"
    }
    
    /// 滚动方向
    public enum QSScrollDirection {
        case horizontal   // 水平
        case vertical     // 垂直
        
        case up           // 上
        case down         // 下
        case left         // 左
        case right        // 右
    }
    
    /// ContentSize、ContentOffset
    public var qs_contentWidth: CGFloat {
        get {
            return contentSize.width
        }
        
        set {
            contentSize = CGSize.init(width: newValue, height: contentSize.height)
        }
    }
    
    public var qs_contentHeight: CGFloat {
        get {
            return contentSize.height
        }
        
        set {
            contentSize = CGSize.init(width: contentSize.width, height: newValue)
        }
    }
    
    public var qs_contentOffsetX: CGFloat {
        get {
            return contentOffset.x
        }
        
        set {
            contentOffset = CGPoint.init(x: newValue, y: contentOffset.y)
        }
    }
    
    public var qs_contentOffsetY: CGFloat {
        get {
            return contentOffset.y
        }
        
        set {
            contentOffset = CGPoint.init(x: contentOffset.x, y: newValue)
        }
    }
    
    /// 手指滚动方向
    public var qs_scrollDirection: QSScrollDirection {
        get {
            if panGestureRecognizer.translation(in: superview).y > 0.0 {
                return .down
            } else if panGestureRecognizer.translation(in: superview).y < 0.0 {
                return .up
            } else if panGestureRecognizer.translation(in: superview).x < 0.0 {
                return .left
            } else {
                return .right
            }
        }
    }
    
    /// 页码
    public var qs_verticalPageIndex: Int {
        get {
            return Int((contentOffset.y + (frame.size.height * 0.5)) / frame.size.height)
        }
    }
    
    public var qs_horizontalPageIndex: Int {
        get {
            return Int((contentOffset.x + (frame.size.width * 0.5)) / frame.size.width)
        }
    }
    
    /// 获取offset
    public var qs_topContentOffset: CGFloat {
        get {
            return -contentInset.top
        }
    }
    
    public var qs_bottomContentOffset: CGFloat {
        get {
            return contentSize.height + contentInset.bottom - bounds.size.height
        }
    }
    
    public var qs_leftContentOffset: CGFloat {
        get {
            return -contentInset.left
        }
    }
    
    public var qs_rightContentOffset: CGFloat {
        get {
            return contentSize.width + contentInset.right - bounds.size.width
        }
    }
    
    /// 是否在顶、底、左、右
    public var qs_isAtTheTop: Bool {
        get {
            return contentOffset.y <= qs_topContentOffset
        }
    }
    
    public var qs_isAtTheBottom: Bool {
        get {
            return contentOffset.y >= qs_bottomContentOffset
        }
    }
    
    public var qs_isOnTheLeft: Bool {
        get {
            return contentOffset.x <= qs_leftContentOffset
        }
    }
    
    public var qs_isOnTheRight: Bool {
        get {
            return contentOffset.x >= qs_rightContentOffset
        }
    }
    
    /// 设置滚动到顶、底、左、右
    public func qs_scrollToTop(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: 0.0, y: qs_topContentOffset), animated: animated)
    }
    
    public func qs_scrollToBottom(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: 0.0, y: qs_bottomContentOffset), animated: animated)
    }
    
    public func qs_scrollToLeft(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: qs_leftContentOffset, y: 0.0), animated: animated)
    }
    
    public func qs_scrollToRight(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: qs_rightContentOffset, y: 0.0), animated: animated)
    }
    
    /// 滚动到指定页码
    public func qs_scrollToPage(index: Int, direction: QSScrollDirection, animated: Bool) {
        var offset = contentOffset
        
        switch direction {
        case .up, .down, .vertical:
            offset.y = CGFloat(index) * frame.size.height
            
        case .left, .right, .horizontal:
            offset.x = CGFloat(index) * frame.size.width
        }
        
        setContentOffset(offset, animated: animated)
    }
    
    /// 上一页
    ///
    /// - Parameters:
    ///   - direction: 滚动方向
    ///   - animated: 动画
    public func qs_pageUp(direction: QSScrollDirection, animated: Bool) {
        var pageIndex = 0
        
        switch direction {
        case .up, .down, .vertical:
            pageIndex = qs_verticalPageIndex > 0 ? qs_verticalPageIndex - 1 : qs_verticalPageIndex
            
        case .left, .right, .horizontal:
            pageIndex = qs_horizontalPageIndex > 0 ? qs_horizontalPageIndex - 1 : qs_horizontalPageIndex
        }
        
        qs_scrollToPage(index: pageIndex, direction: direction, animated: animated)
    }
    
    /// 下一页
    ///
    /// - Parameters:
    ///   - direction: 滚动方向
    ///   - animated: 动画
    public func qs_pageDown(direction: QSScrollDirection, animated: Bool) {
        var pageIndex = 0
        
        switch direction {
        case .up, .down, .vertical:
            pageIndex = qs_verticalPageIndex < Int(qs_contentHeight / frame.size.height - 1) ? qs_verticalPageIndex + 1 : qs_verticalPageIndex
            
        case .left, .right, .horizontal:
            pageIndex = qs_horizontalPageIndex < Int(qs_contentWidth / frame.size.width - 1) ? qs_horizontalPageIndex + 1 : qs_horizontalPageIndex
        }
        
        qs_scrollToPage(index: pageIndex, direction: direction, animated: animated)
    }
    
    /// 滚动时调用
    public var qs_didScroll: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didScroll) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            if delegate == nil {
                delegate = self
            }
            objc_setAssociatedObject(self, &AssociatedKeys.didScroll, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 开始拖拽时调用
    public var qs_beginDragging: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.beginDraggingKey) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            if delegate == nil {
                delegate = self
            }
            objc_setAssociatedObject(self, &AssociatedKeys.beginDraggingKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 停止滚动时调用
    public var qs_didEndScroll: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didEndScrollKey) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            if delegate == nil {
                delegate = self
            }
            objc_setAssociatedObject(self, &AssociatedKeys.didEndScrollKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否共享手势
    public var qs_isShareRecognizer: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isShareRecognizer) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isShareRecognizer, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否允许水平滑动
    public var qs_isHorizontalScrollEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isHorizontalScrollEnabled) as? Bool) ?? true
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isHorizontalScrollEnabled, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否允许垂直滑动
    public var qs_isVerticalScrollEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isVerticalScrollEnabled) as? Bool) ?? true
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isVerticalScrollEnabled, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let block = qs_beginDragging {
            block(scrollView)
        }
        
        // 允许水平，禁止垂直
        if qs_isHorizontalScrollEnabled && !qs_isVerticalScrollEnabled {
            if scrollView.qs_scrollDirection == .up || scrollView.qs_scrollDirection == .down {
                scrollView.isScrollEnabled = false
            } else {
                scrollView.isScrollEnabled = true
            }
        }
        
        // 允许垂直，禁止水平
        if !qs_isHorizontalScrollEnabled && qs_isVerticalScrollEnabled {
            if scrollView.qs_scrollDirection == .up || scrollView.qs_scrollDirection == .down {
                scrollView.isScrollEnabled = true
            } else {
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if qs_isHorizontalScrollEnabled || qs_isVerticalScrollEnabled {
            scrollView.isScrollEnabled = true
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let block = qs_didEndScroll {
            block(scrollView)
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let block = qs_didScroll {
            block(scrollView)
        }
    }
}

extension UIScrollView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return qs_isShareRecognizer
    }
}
