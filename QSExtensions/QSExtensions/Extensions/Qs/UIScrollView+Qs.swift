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
            return self.contentSize.width
        }
        
        set {
            self.contentSize = CGSize.init(width: newValue, height: self.frame.size.height)
        }
    }
    
    public var qs_contentHeight: CGFloat {
        get {
            return self.contentSize.height
        }
        
        set {
            self.contentSize = CGSize.init(width: self.frame.size.width, height: newValue)
        }
    }
    
    public var qs_contentOffsetX: CGFloat {
        get {
            return self.contentOffset.x
        }
        
        set {
            self.contentOffset = CGPoint.init(x: newValue, y: self.contentOffset.y)
        }
    }
    
    public var qs_contentOffsetY: CGFloat {
        get {
            return self.contentOffset.y
        }
        
        set {
            self.contentOffset = CGPoint.init(x: self.contentOffset.x, y: newValue)
        }
    }
    
    /// 手指滚动方向
    public var qs_scrollDirection: QSScrollDirection {
        get {
            if self.panGestureRecognizer.translation(in: self.superview).y > 0.0 {
                return QSScrollDirection.down
            } else if self.panGestureRecognizer.translation(in: self.superview).y < 0.0 {
                return QSScrollDirection.up
            } else if self.panGestureRecognizer.translation(in: self.superview).x < 0.0 {
                return QSScrollDirection.left
            } else {
                return QSScrollDirection.right
            }
        }
    }
    
    /// 页码
    public var qs_verticalPageIndex: Int {
        get {
            return Int((self.contentOffset.y + (self.frame.size.height * 0.5)) / self.frame.size.height)
        }
    }
    
    public var qs_horizontalPageIndex: Int {
        get {
            return Int((self.contentOffset.x + (self.frame.size.width * 0.5)) / self.frame.size.width)
        }
    }
    
    /// 获取offset
    public var qs_getTopContentOffset: CGFloat {
        get {
            return -self.contentInset.top
        }
    }
    
    public var qs_getBottomContentOffset: CGFloat {
        get {
            return self.contentSize.height + self.contentInset.bottom - self.bounds.size.height
        }
    }
    
    public var qs_getLeftContentOffset: CGFloat {
        get {
            return -self.contentInset.left
        }
    }
    
    public var qs_getRightContentOffset: CGFloat {
        get {
            return self.contentSize.width + self.contentInset.right - self.bounds.size.width
        }
    }
    
    /// 是否滚动到顶、底、左、右
    public var qs_isScrolledToTop: Bool {
        get {
            return self.contentOffset.y <= self.qs_getTopContentOffset
        }
    }
    
    public var qs_isScrolledToBottom: Bool {
        get {
            return self.contentOffset.y >= self.qs_getBottomContentOffset
        }
    }
    
    public var qs_isScrolledToLeft: Bool {
        get {
            return self.contentOffset.x <= qs_getLeftContentOffset
        }
    }
    
    public var qs_isScrolledToRight: Bool {
        get {
            return self.contentOffset.x >= qs_getRightContentOffset
        }
    }
    
    /// 设置滚动到顶、底、左、右
    public func qs_scrollToTop(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: 0.0, y: self.qs_getTopContentOffset), animated: animated)
    }
    
    public func qs_scrollToBottom(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: 0.0, y: self.qs_getBottomContentOffset), animated: animated)
    }
    
    public func qs_scrollToLeftAnimated(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: self.qs_getLeftContentOffset, y: 0.0), animated: animated)
    }
    
    public func qs_scrollToRightAnimated(animated: Bool) {
        self.setContentOffset(CGPoint.init(x: self.qs_getRightContentOffset, y: 0.0), animated: animated)
    }
    
    /// 滚动到指定页码
    public func qs_scrollToPage(index: Int, scrollDirection: QSScrollDirection, animated: Bool) {
        var offset = self.contentOffset
        
        switch scrollDirection {
        case .up, .down, .vertical:
            offset.y = CGFloat(index) * self.frame.size.height
            
        case .left, .right, .horizontal:
            offset.x = CGFloat(index) * self.frame.size.width
        }
        
        self.setContentOffset(offset, animated: animated)
    }
    
    /// 滚动到上一页
    ///
    /// - Parameters:
    ///   - scrollDirection: 滚动方向
    ///   - animated: 动画
    public func qs_scrollToUpPage(scrollDirection: QSScrollDirection, animated: Bool) {
        var pageIndex = 0
        
        switch scrollDirection {
        case .up, .down, .vertical:
            pageIndex = self.qs_verticalPageIndex > 0 ? self.qs_verticalPageIndex - 1 : self.qs_verticalPageIndex
            
        case .left, .right, .horizontal:
            pageIndex = self.qs_horizontalPageIndex > 0 ? self.qs_horizontalPageIndex - 1 : self.qs_horizontalPageIndex
        }
        
        self.qs_scrollToPage(index: pageIndex, scrollDirection: scrollDirection, animated: animated)
    }
    
    /// 滚动到下一页
    ///
    /// - Parameters:
    ///   - scrollDirection: 滚动方向
    ///   - animated: 动画
    public func qs_scrollToNextPage(scrollDirection: QSScrollDirection, animated: Bool) {
        var pageIndex = 0
        
        switch scrollDirection {
        case .up, .down, .vertical:
            pageIndex = self.qs_verticalPageIndex < Int(self.qs_contentHeight / self.frame.size.height - 1) ? self.qs_verticalPageIndex + 1 : self.qs_verticalPageIndex
            
        case .left, .right, .horizontal:
            pageIndex = self.qs_horizontalPageIndex < Int(self.qs_contentWidth / self.frame.size.width - 1) ? self.qs_horizontalPageIndex + 1 : self.qs_horizontalPageIndex
        }
        
        self.qs_scrollToPage(index: pageIndex, scrollDirection: scrollDirection, animated: animated)
    }
    
    /// 滚动时调用
    public var qs_didScroll: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didScroll) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            self.delegate = self.delegate == nil ? self : self.delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.didScroll, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 开始拖拽时调用
    public var qs_beginDragging: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.beginDraggingKey) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            self.delegate = self.delegate == nil ? self : self.delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.beginDraggingKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 停止滚动时调用
    public var qs_didEndScroll: ((_ scrView: UIScrollView) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didEndScrollKey) as? ((_ scrView: UIScrollView) -> ())
        }
        
        set {
            self.delegate = self.delegate == nil ? self : self.delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.didEndScrollKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.qs_beginDragging != nil {
            self.qs_beginDragging!(scrollView)
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.qs_didEndScroll != nil {
            self.qs_didEndScroll!(scrollView)
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.qs_didScroll != nil {
            self.qs_didScroll!(scrollView)
        }
    }
}


