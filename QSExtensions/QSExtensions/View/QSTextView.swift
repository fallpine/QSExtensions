//
//  QSTextView.swift
//  QSExtensions
//
//  Created by Song on 2019/5/25.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

/// 文字垂直对齐方式
public enum QSTextVerticalAlignment {
    case top
    case center
    case bottom
}

public class QSTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        // 监控数据改变
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
        addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        placeholderTV.frame = CGRect.init(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver(self, forKeyPath: "text", context: nil)
        removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    
    // MARK: - Property
    /// 占位文字
    public var qs_placeholder: String? {
        didSet {
            if placeholderTV.superview == nil {
                self.addSubview(placeholderTV)
            }
            
            if delegate == nil {
                delegate = self
            }
            
            placeholderTV.text = qs_placeholder
        }
    }
    
    /// 占位文字颜色
    public var qs_placeholderColor: UIColor? {
        didSet {
            if placeholderTV.superview == nil {
                self.addSubview(placeholderTV)
            }
            
            if delegate == nil {
                delegate = self
            }
            
            placeholderTV.textColor = qs_placeholderColor
        }
    }
    
    /// 占位文字字体
    public var qs_placeholderFont: UIFont? {
        didSet {
            if placeholderTV.superview == nil {
                self.addSubview(placeholderTV)
            }
            
            if delegate == nil {
                delegate = self
            }
            
            placeholderTV.font = qs_placeholderFont
        }
    }
    
    /// 文字垂直对齐方式
    public var textVerticalAlignment: QSTextVerticalAlignment = .top
    
    /// 设置内边距，为了配合垂直对齐方式使用
    public var qs_contentInset: UIEdgeInsets? {
        didSet {
            contentInset = qs_contentInset ?? .zero
        }
    }
    
    /// 限制输入字符的长度
    public var qs_limitCount: UInt = 0 {
        didSet {
            if qs_limitCount > 0 && delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 是否允许编辑
    public var qs_isAllowEditingAction: (() -> (Bool))? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 内容改变
    public var qs_textDidChangeAction: ((String) -> ())? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 开始编辑
    public var qs_textDidBeginEditAction: (() -> ())? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 结束编辑
    public var qs_textDidEndEditAction: ((String) -> ())? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// return按钮点击事件
    public var qs_returnBtnAction: ((String) -> ())? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 是否允许输入字符，string是即将输入的字符
    /// 返回false表示不能输入，true表示可以输入
    public var qs_shouldChangeCharactersAction: ((String) -> (Bool))? {
        didSet {
            if delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 链接点击事件
    private var linkActionDict = [String: () -> ()]()
    
    // MARK: - Func
    /// 段落首行缩进
    ///
    /// - Parameter eadge: 缩进宽度
    public func qs_firstLineLeftEdge(_ edge: CGFloat) {
        if placeholderTV.superview == nil {
            self.addSubview(placeholderTV)
        }
        
        // 真实输入框
        let isTextEmpty = text.isEmpty
        
        if isTextEmpty {
            // text必须有值，富文本属性设置才能生效
            self.text = " "
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.firstLineHeadIndent = edge
        
        let rangeArray = getStringRangeArray(with: [text], textView: self)
        if !rangeArray.isEmpty {
            let mutableAttributedString = NSMutableAttributedString.init(attributedString: attributedText!)
            mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: rangeArray.first!)
            
            attributedText = mutableAttributedString
        }
        
        if isTextEmpty {
            text = ""
        }
        
        // 占位文字输入框
        let isTextEmpty1 = placeholderTV.text.isEmpty
        
        if isTextEmpty1 {
            // text必须有值，富文本属性设置才能生效
            placeholderTV.text = " "
        }
        
        let rangeArray1 = getStringRangeArray(with: [placeholderTV.text], textView: placeholderTV)
        if !rangeArray1.isEmpty {
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
    /// 还可以通过textContainer.lineFragmentPadding设置左右边距
    public func qs_textContainerInset(_ inset: UIEdgeInsets) {
        if placeholderTV.superview == nil {
            self.addSubview(placeholderTV)
        }
        
        textContainerInset = inset
        placeholderTV.textContainerInset = inset
    }
    
    /// 添加点击链接
    public func qs_addLink(_ link: String, action: @escaping (() -> ())) {
        // 获取点击的范围
        var linkRangeDict = [String: [NSRange]]()
        let rangeArr = getStringRangeArray(with: [link], textView: self)
        if !rangeArr.isEmpty {
            linkRangeDict[link] = rangeArr
        }
        
        // 编码
        guard let linkStr = link.qs_urlEncode() else { return }
        linkActionDict[linkStr] = action
        
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: attributedText!)
        if let linkRanges = linkRangeDict[link] {
            for range in linkRanges {
                mutableAttributedString.addAttribute(.link, value: "qs_scheme://" + linkStr, range: range)
            }
        }
        
        attributedText = mutableAttributedString
        linkTextAttributes = [:]
        delegate = self
    }
    
    /// 字符改变
    private func textChange(text: String?) {
        guard let text = text else { return }
        
        // 限制字符长度
        limitTextLength(text: text)
        // 隐藏占位textView
        placeholderTV.isHidden = !text.isEmpty
        
        // 触发text改变的block
        if let block = qs_textDidChangeAction {
            if (qs_limitCount == 0) || text.count <= qs_limitCount {
                block(text)
            }
        }
    }
    
    /// 限制字符长度
    ///
    /// - Parameter textView: textView
    private func limitTextLength(text: String) {
        guard qs_limitCount > 0 else { return }
        
        // 获取高亮部分
        let selectedRange = self.markedTextRange
        if let _ = selectedRange?.start {
        } else {
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if text.count > qs_limitCount {
                let toStrIndex = text.index(text.startIndex, offsetBy: Int(qs_limitCount))
                self.text = String(text[text.startIndex ..< toStrIndex])
            }
        }
    }
    
    /// 获取对应字符串的range数组
    ///
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
    private func getStringRangeArray(with textArray: Array<String>, textView: UITextView) -> Array<NSRange> {
        var rangeArray = Array<NSRange>.init()
        
        // 获取所有的text
        guard let totalStr = textView.attributedText?.string else { return rangeArray }
        
        // 遍历
        for str in textArray {
            if let range = totalStr.range(of: str) {
                if !range.isEmpty {
                    let range = NSRange.init(range, in: totalStr)
                    rangeArray.append(range)
                }
            }
        }
        
        return rangeArray
    }
    
    /// 设置文字垂直对齐
    private func setTextVerticalAlignment() {
        var offset = qs_contentInset == nil ? .zero : qs_contentInset!
        
        // 如果文字内容高度超过textView的高度
        if contentSize.height >= (frame.size.height - offset.top - offset.bottom) {
            return
        }
        
        // 上对齐是默认方式
        if textVerticalAlignment == .top {
            return
        }
        
        
        switch textVerticalAlignment {
        case .center:
            let offsetY = (frame.size.height - contentSize.height - offset.top - offset.bottom) / 2.0
            offset = UIEdgeInsets.init(top: offsetY, left: 0.0, bottom: 0.0, right: 0.0)
            
        case .bottom:
            let offsetY = (frame.size.height - offset.top - offset.bottom - contentSize.height)
            offset = UIEdgeInsets.init(top: offsetY, left: 0.0, bottom: 0.0, right: 0.0)
            
        default:
            break
        }
        
        contentInset = offset
    }
    
    // MARK: - KVO
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            let text = change![NSKeyValueChangeKey.newKey] as! String
            
            // 设置占位符的对齐方式
            if let superV = superview as? QSTextView,
               let placehoder = superV.qs_placeholder {
                if !placehoder.isEmpty &&
                    placehoder == text {
                    textAlignment = superV.textAlignment
                    textVerticalAlignment = superV.textVerticalAlignment
                }
            }
            
            textChange(text: text)
        } else if keyPath == "contentSize" {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
                // 设置文字垂直对齐
                self?.setTextVerticalAlignment()
            }
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
        guard let block = qs_isAllowEditingAction else { return true }
        return block()
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
        if let block = qs_textDidBeginEditAction {
            block()
        }
    }
    
    /// 结束编辑
    ///
    /// - Parameter textView: 输入框
    public func textViewDidEndEditing(_ textView: UITextView) {
        if let block = qs_textDidEndEditAction {
            block(textView.text)
        }
    }
    
    /// 某个范围的输入改变
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 总是允许删除
        if text.isEmpty {
            return true
        }
        
        // 是否响应键盘的return按钮点击
        if text.elementsEqual("\n") {
            textView.resignFirstResponder()
            
            if let block = qs_returnBtnAction {
                block(textView.text)
            }
            
            return false
        }
        
        // 限制字符长度
        if qs_limitCount > 0 {
            let isOverLimit = ((textView.text ?? "") + text).count > qs_limitCount
            if isOverLimit {
                return !isOverLimit
            }
        }
        
        // 是否允许输入
        if let block = qs_shouldChangeCharactersAction {
            return block(text)
        }
        
        return true
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.relativeString.starts(with: "qs_scheme") {
            let link = URL.relativeString.replacingOccurrences(of: "qs_scheme://", with: "")
            if let block = linkActionDict[link] {
                block()
            }
            return false
        }
        
        return true
    }
}
