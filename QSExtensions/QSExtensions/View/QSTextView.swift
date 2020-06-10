//
//  QSTextView.swift
//  QSExtensions
//
//  Created by Song on 2019/5/25.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public class QSTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        // 监控数据改变
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        placeholderTV.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver(self, forKeyPath: "text", context: nil)
    }
    
    // MARK: - Property
    /// 占位文字
    public var qs_placeholder: String? {
        didSet {
            placeholderTV.removeFromSuperview()
            self.addSubview(placeholderTV)
            placeholderTV.text = qs_placeholder
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 占位文字颜色
    public var qs_placeholderColor: UIColor? {
        didSet {
            placeholderTV.removeFromSuperview()
            self.addSubview(placeholderTV)
            placeholderTV.textColor = qs_placeholderColor
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 占位文字字体
    public var qs_placeholderFont: UIFont? {
        didSet {
            placeholderTV.removeFromSuperview()
            self.addSubview(placeholderTV)
            placeholderTV.font = qs_placeholderFont
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 限制输入字符的长度
    public var qs_limitTextLength: Int? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 是否允许输入emoji
    public var qs_isAllowEmoji: Bool = true {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 是否允许开始编辑的回调
    public var qs_isAllowEditingBlock: (() -> (Bool))? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 内容改变的回调
    public var qs_textDidChangeBlock: ((String) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 开始编辑回调
    public var qs_textDidBeginEditBlock: (() -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 结束编辑的回调
    public var qs_textDidEndEditBlock: ((String) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// return事件的回调
    public var qs_returnBtnBlock: ((String) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    // MARK: - Func
    /// 段落首行缩进
    ///
    /// - Parameter eadge: 缩进宽度
    public func qs_firstLineLeftEdge(_ edge: CGFloat) {
        placeholderTV.removeFromSuperview()
        self.addSubview(placeholderTV)
        
        // 真实输入框
        let isTextEmpty = isStringEmpty(self.text)
        
        if isTextEmpty {
            // text必须有值，富文本属性设置才能生效
            self.text = " "
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.firstLineHeadIndent = edge
        
        let rangeArray = getStringRangeArray(with: [text], textView: self)
        if !isArrayEmpty(rangeArray) {
            let mutableAttributedString = NSMutableAttributedString.init(attributedString: attributedText!)
            mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: rangeArray.first!)
            
            attributedText = mutableAttributedString
        }
        
        if isTextEmpty {
            text = ""
        }
        
        // 占位文字输入框
        let isTextEmpty1 = isStringEmpty(placeholderTV.text)
        
        if isTextEmpty1 {
            // text必须有值，富文本属性设置才能生效
            placeholderTV.text = " "
        }
        
        let rangeArray1 = getStringRangeArray(with: [placeholderTV.text], textView: placeholderTV)
        if !isArrayEmpty(rangeArray1) {
            let mutableAttributedString1 = NSMutableAttributedString.init(attributedString: placeholderTV.attributedText!)
            mutableAttributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: rangeArray1.first!)
            
            placeholderTV.attributedText = mutableAttributedString1
        }
        
        if isTextEmpty1 {
            placeholderTV.text = ""
        }
    }
    
    /// 设置内边距
    ///
    /// - Parameter inset: 内边距
    public func qs_textContainerInset(_ inset: UIEdgeInsets) {
        placeholderTV.removeFromSuperview()
        self.addSubview(placeholderTV)
        
        textContainerInset = inset
        placeholderTV.textContainerInset = inset
    }
    
    /// 字符改变
    private func textChange(text: String?) {
        if let myText = text {
            // 触发text改变的block
            if qs_limitTextLength != nil {
                if myText.count <= qs_limitTextLength! {
                    if qs_textDidChangeBlock != nil {
                        qs_textDidChangeBlock!(myText)
                    }
                }
            } else {
                if qs_textDidChangeBlock != nil {
                    qs_textDidChangeBlock!(myText)
                }
            }
            
            // 限制字符长度
            limitTextLength(textView: self)
            
            // 隐藏占位textView
            placeholderTV.isHidden = !isStringEmpty(myText)
        }
    }
    
    /// 限制字符长度
    ///
    /// - Parameter textView: textView
    private func limitTextLength(textView: QSTextView) {
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
    private func getStringRangeArray(with textArray: Array<String>, textView: UITextView) -> Array<NSRange> {
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
    private func isArrayEmpty(_ array: Array<Any>?) ->Bool {
        if let arr = array {
            return arr.isEmpty
        }
        return true
    }
    
    /// 字符串是否为空
    private func isStringEmpty(_ string: String?) ->Bool {
        if let str = string {
            return str.isEmpty
        }
        return true
    }
    
    /// 要输入的字符是否包含emoji表情
    private func isContainsEmoji(text: String) -> Bool {
        // 判断是否是九宫格舒服
        if text.count == 1 {
            let nineKeyBoardText = "➋➌➍➎➏➐➑➒"
            if nineKeyBoardText.contains(text) {
                return false
            }
        }
        
        // emoji表情
        for char in text {
            if let codePoint = char.unicodeScalars.first?.value {
                if (codePoint >= 0x2600 && codePoint <= 0x27BF) ||
                    codePoint == 0x303D ||
                    codePoint == 0x2049 ||
                    codePoint == 0x203C ||
                    (codePoint >= 0x2000 && codePoint <= 0x200F) ||
                    (codePoint >= 0x2028 && codePoint <= 0x202F) ||
                    codePoint == 0x205F ||
                    (codePoint >= 0x2065 && codePoint <= 0x206F) ||
                    (codePoint >= 0x2100 && codePoint <= 0x214F) ||
                    (codePoint >= 0x2300 && codePoint <= 0x23FF) ||
                    (codePoint >= 0x2B00 && codePoint <= 0x2BFF) ||
                    (codePoint >= 0x2900 && codePoint <= 0x297F) ||
                    (codePoint >= 0x3200 && codePoint <= 0x32FF) ||
                    (codePoint >= 0xD800 && codePoint <= 0xDFFF) ||
                    (codePoint >= 0xD800 && codePoint <= 0xDFFF) ||
                    (codePoint >= 0xFE00 && codePoint <= 0xFE0F) ||
                    codePoint >= 0x10000 {
                    return true
                }
            }
        }
        
        return false
    }
    
    // MARK: - KVO
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            let text = change![NSKeyValueChangeKey.newKey] as! String
            textChange(text: text)
        }
    }
    
    // MARK: - Widget
    /// 占位文字输入框
    private lazy var placeholderTV: QSTextView = {
        let tf = QSTextView.init(frame: .zero, textContainer: nil)
        tf.isScrollEnabled = false
        tf.showsVerticalScrollIndicator = false
        tf.showsHorizontalScrollIndicator = false
        tf.isUserInteractionEnabled = false
        tf.backgroundColor = UIColor.clear
        return tf
    }()
}

extension QSTextView: UITextViewDelegate {
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
        textChange(text: textView.text)
    }
    
    /// 开始编辑
    ///
    /// - Parameter textView: 输入框
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if qs_textDidBeginEditBlock != nil {
            qs_textDidBeginEditBlock!()
        }
    }
    
    /// 结束编辑
    ///
    /// - Parameter textView: 输入框
    public func textViewDidEndEditing(_ textView: UITextView) {
        if qs_textDidEndEditBlock != nil {
            qs_textDidEndEditBlock!(textView.text)
        }
    }
    
    /// 某个范围的输入改变
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 不允许输入emoji
        if !qs_isAllowEmoji {
            if isContainsEmoji(text: text) {
                return false
            }
        }
        
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
}
