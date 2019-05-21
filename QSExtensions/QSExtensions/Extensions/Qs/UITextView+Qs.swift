//
//  UITextView+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UITextView: UITextViewDelegate {
    /// 新增属性key
    private struct AssociatedKeys {
        static var placeholderTextViewKey: String = "placeholderTextViewKey"
        static var placeholderTextKey: String = "placeholderTextKey"
        static var placeholderTextColorKey: String = "placeholderTextColorKey"
        static var placeholderTextFontKey: String = "placeholderTextFontKey"
        static var isAllowEditingBlockKey: String = "isAllowEditingBlockKey"
        static var textDidChangeBlockKey: String = "textDidChangeBlockKey"
        static var textDidEndEditBlockKey: String = "textDidEndEditBlockKey"
        static var returnKeyBlockKey: String = "returnKeyBlockKey"
        static var limitTextLengthKey: String = "limitTextLengthKey"
    }
    
    /// 占位文字的textView
    private var qs_placeholderTextView: UITextView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderTextViewKey) as? UITextView
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderTextViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 占位文字
    var qs_placeholder: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderTextKey) as? String
        }
        
        set {
            if qs_placeholderTextView == nil {
                qs_createPlaceholderTextView()
            }
            
            qs_placeholderTextView?.text = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderTextKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 占位文字颜色
    var qs_placeholderColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderTextColorKey) as? UIColor
        }
        
        set {
            if qs_placeholderTextView == nil {
                qs_createPlaceholderTextView()
            }
            
            qs_placeholderTextView?.textColor = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderTextColorKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 占位文字字体
    var qs_placeholderFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderTextFontKey) as? UIFont
        }
        
        set {
            if qs_placeholderTextView == nil {
                qs_createPlaceholderTextView()
            }
            
            qs_placeholderTextView?.font = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderTextFontKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 限制输入字符的长度
    var qs_limitTextLength: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.limitTextLengthKey) as? Int
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.limitTextLengthKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否允许开始编辑的回调
    var qs_isAllowEditingBlock: (() -> (Bool))? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isAllowEditingBlockKey) as? (() -> (Bool))
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.isAllowEditingBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 内容改变的回调
    var qs_textDidChangeBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textDidChangeBlockKey) as? ((String) -> ())
        }
        
        set {
            delegate = delegate == nil ? self :delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.textDidChangeBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 结束编辑的回调
    var qs_textDidEndEditBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textDidEndEditBlockKey) as? ((String) -> ())
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.textDidEndEditBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// return事件的回调
    var qs_returnBtnBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.returnKeyBlockKey) as? ((String) -> ())
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.returnKeyBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 段落首行缩进
    ///
    /// - Parameter eadge: 缩进宽度
    func qs_firstLineLeftEdge(_ edge: CGFloat) {
        // 真实输入框
        let isTextEmpty = qs_isStringEmpty(self.text)
        
        if isTextEmpty {
            // text必须有值，富文本属性设置才能生效
            self.text = " "
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.firstLineHeadIndent = edge
        
        let rangeArray = qs_getStringRangeArray(with: [text], textView: self)
        if !qs_isArrayEmpty(rangeArray) {
            let mutableAttributedString = NSMutableAttributedString.init(attributedString: attributedText!)
            mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: rangeArray.first!)
            
            attributedText = mutableAttributedString
        }
        
        if isTextEmpty {
            text = ""
        }
        
        // 占位文字输入框
        if let placeholderTV = qs_placeholderTextView {
            let isTextEmpty1 = qs_isStringEmpty(placeholderTV.text)
            
            if isTextEmpty1 {
                // text必须有值，富文本属性设置才能生效
                placeholderTV.text = " "
            }
            
            let rangeArray1 = qs_getStringRangeArray(with: [placeholderTV.text], textView: placeholderTV)
            if !qs_isArrayEmpty(rangeArray1) {
                let mutableAttributedString1 = NSMutableAttributedString.init(attributedString: placeholderTV.attributedText!)
                mutableAttributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: rangeArray1.first!)
                
                placeholderTV.attributedText = mutableAttributedString1
            }
            
            if isTextEmpty1 {
                placeholderTV.text = ""
            }
        }
    }
    
    /// 设置内边距
    ///
    /// - Parameter inset: 内边距
    func qs_textContainerInset(_ inset: UIEdgeInsets) {
        textContainerInset = inset
        if let placeholderTV = qs_placeholderTextView {
            placeholderTV.textContainerInset = inset
        }
    }
    
    // MARK: - System
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if qs_placeholderTextView != nil {
            qs_placeholderTextView?.frame = bounds
        }
        
        // 直接用代码设值的时候用KVO监听
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    // MARK: - KVO
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            let text = change![NSKeyValueChangeKey.newKey] as! String
            
            // 隐藏占位textView
            if qs_placeholderTextView != nil {
                qs_placeholderTextView?.isHidden = !qs_isStringEmpty(text)
            }
            
            // 限制字符长度
            qs_limitTextCount(textView: self)
            
            // 触发text改变的block
            if qs_limitTextLength != nil {
                if text.count < qs_limitTextLength! {
                    if qs_textDidChangeBlock != nil {
                        qs_textDidChangeBlock!(text)
                    }
                }
            } else {
                if qs_textDidChangeBlock != nil {
                    qs_textDidChangeBlock!(text)
                }
            }
        }
    }
    
    // MARK: - UITextViewDelegate
    /// 是否允许开始编辑
    ///
    /// - Parameter textView: 输入框
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if qs_isAllowEditingBlock != nil {
            return qs_isAllowEditingBlock!()
        }
        
        return true
    }
    
    /// textView输入发生改变
    ///
    /// - Parameter textView: 输入框
    public func textViewDidChange(_ textView: UITextView) {
        if qs_placeholderTextView != nil {
            qs_placeholderTextView?.isHidden = !qs_isStringEmpty(textView.text)
        }
        
        if qs_textDidChangeBlock != nil {
            qs_textDidChangeBlock!(textView.text)
        }
        
        qs_limitTextCount(textView: textView)
    }
    
    /// 结束编辑
    ///
    /// - Parameter textView: 输入框
    public func textViewDidEndEditing(_ textView: UITextView) {
        // 删除监听者
        textView.removeObserver(self, forKeyPath: "text")
        
        if qs_textDidEndEditBlock != nil {
            qs_textDidEndEditBlock!(textView.text)
        }
    }
    
    /// 某个范围的输入改变
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 是否响应键盘的return按钮点击
        if text.elementsEqual("\n") {
            textView.resignFirstResponder()
            
            if qs_returnBtnBlock != nil {
                qs_returnBtnBlock!(textView.text)
            }
            
            return false
        }
        
        return true
    }
    
    // MARK: - Private Methods
    /// 创建占位TextView
    private func qs_createPlaceholderTextView() {
        let textView = UITextView.init(frame: self.bounds)
        self.addSubview(textView)
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.isUserInteractionEnabled = false
        textView.textColor = self.textColor
        textView.backgroundColor = UIColor.clear
        textView.font = self.font
        
        delegate = delegate == nil ? self : delegate
        qs_placeholderTextView = textView
    }
    
    /// 限制字符长度
    ///
    /// - Parameter textView: textView
    private func qs_limitTextCount(textView: UITextView) {
        if qs_limitTextLength != nil {
            //获取高亮部分
            let selectedRange = textView.markedTextRange
            if let _ = selectedRange?.start {
            } else {
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if let limitLength = qs_limitTextLength {
                    if (textView.text?.count)! > qs_limitTextLength! {
                        let toStrIndex = textView.text.index(textView.text.startIndex, offsetBy: limitLength)
                        textView.text = String(textView.text[textView.text.startIndex ..< toStrIndex])
                    }
                }
            }
        }
    }
    
    /// 获取对应字符串的range数组
    ///
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
    private func qs_getStringRangeArray(with textArray: Array<String>, textView: UITextView) -> Array<NSRange> {
        // 获取所有的text
        let totalStr = textView.attributedText?.string
        
        
        var rangeArray = Array<NSRange>.init()
        
        // 遍历
        for str in textArray {
            let range = totalStr?.range(of: str)
            
            if range != nil && !(range?.isEmpty)! {
                let range = NSRange.init(range!, in: totalStr!)
                
                rangeArray.append(range)
            }
        }
        
        return rangeArray
    }
    
    /// 数组是否为空
    private func qs_isArrayEmpty(_ array: Array<Any>?) ->Bool {
        if let arr = array {
            return arr.isEmpty
        }
        return true
    }
    
    /// 字符串是否为空
    private func qs_isStringEmpty(_ string: String?) ->Bool {
        if let str = string {
            return str.isEmpty
        }
        return true
    }
}
