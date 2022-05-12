//
//  QSTextField.swift
//  QSExtensions
//
//  Created by Song on 2019/5/24.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public class QSTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 监控数据改变
        addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.editingChanged), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        removeObserver(self, forKeyPath: "text", context: nil)
    }
    
    // MARK: - Property
    /// 限制输入字符的长度
    public var qs_limitCount: UInt = 0 {
        didSet {
            if qs_limitCount > 0 && delegate == nil {
                delegate = self
            }
        }
    }
    
    /// 限制小数位数
    public var qs_limitDecimalCount: UInt = 0 {
        didSet {
            if qs_limitDecimalCount > 0 {
                keyboardType = UIKeyboardType.decimalPad
                if delegate == nil {
                    delegate = self
                }
            }
        }
    }
    
    /// 字数超出限制
    public var qs_textOverCountAction: (() -> ())? {
        didSet {
            if delegate == nil {
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
    
    /// 点击return按钮
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
    
    // MARK: - Func
    /// 字符改变
    @objc private func editingChanged() {
        self.textChange(text: self.text)
    }
    private func textChange(text: String?) {
        guard let text = text else { return }
        
        // 限制字符长度
        limitTextLength(text: text)
        // 限制小数位数
        limitDecimalLength(text: text)
        
        // 触发text改变的block
        if let block = qs_textDidChangeAction {
            if (qs_limitCount == 0) || text.count <= qs_limitCount {
                block(text)
            }
        }
    }
    
    /// 限制字符长度
    private func limitTextLength(text: String) {
        guard qs_limitCount > 0 else { return }
        
        // 获取高亮部分
        let selectedRange = self.markedTextRange
        if let _ = selectedRange?.start {
        } else {
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if text.count > qs_limitCount {
                // 截取字符串
                let toStrIndex = text.index(text.startIndex, offsetBy: Int(qs_limitCount))
                self.text = String(text[text.startIndex ..< toStrIndex])
                if let block = qs_textOverCountAction {
                    block()
                }
            }
        }
    }
    
    /// 限制小数位数
    ///
    /// - Parameter text: 文字
    private func limitDecimalLength(text: String) {
        guard qs_limitDecimalCount > 0 else { return }
        
        let isNumber = isDecimal(string: text)
        if isNumber {
            let strArr = text.components(separatedBy: CharacterSet.init(charactersIn: "."))
            if strArr.count > 1 {
                if let str = strArr.last {
                    if str.count > qs_limitDecimalCount {
                        let toStrIndex = text.index(text.startIndex, offsetBy: text.count - (str.count - Int(qs_limitDecimalCount)))
                        self.text = String(text[text.startIndex ..< toStrIndex])
                    }
                }
            }
        }
    }
    
    /// 判断是否是小数
    ///
    /// - Parameter string: 字符
    private func isDecimal(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val: Float = 0.0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 对小数进行正则判断
    ///
    /// - Parameters:
    ///   - number: 数字
    ///   - decimals: 小数位数
    private func validateNumber(number: String, decimals: UInt) -> Bool {
        let conditionStr = "^(0\\.\\d{0,\(decimals)}|[1-9][0-9]{0,}+\\.\\d{0,\(decimals)}|[1-9]\\d+|\\d)$"
        let numberPre = NSPredicate(format: "SELF MATCHES %@", conditionStr)
        
        return numberPre.evaluate(with: number)
    }
    
    /// 字符串是否为空
    private func isStringEmpty(_ string: String?) ->Bool {
        if let str = string {
            return str.isEmpty
        }
        return true
    }
    
    /// KVO监听
    ///
    /// - Parameters:
    ///   - keyPath: key
    ///   - object: 对象
    ///   - change: 改变状态
    ///   - context: 上下文
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            let text = change![NSKeyValueChangeKey.newKey] as? String
            textChange(text: text)
        }
    }
}

extension QSTextField: UITextFieldDelegate {
    /// 是否允许开始编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let block = qs_isAllowEditingAction{
            return block()
        }
        
        return true
    }
    
    /// 开始编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let block = qs_textDidBeginEditAction {
            block()
        }
    }
    
    /// 结束编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let block = qs_textDidEndEditAction {
            block(textField.text ?? "")
        }
    }
    
    /// 响应键盘的return按钮点击
    ///
    /// - Parameter textField: 输入框
    /// - Returns: true：响应； false：忽略
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let block = qs_returnBtnAction {
            block(textField.text ?? "")
        }
        
        return false
    }
    
    /// 在某个区域改变字符
    ///
    /// - Parameters:
    ///   - textField: 输入框
    ///   - range: 区域
    ///   - string: 字符
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 总是允许删除
        if isStringEmpty(string) {
            return true
        }
        
        // 限制字符长度
        if qs_limitCount > 0 {
            let isOverLimit = ((textField.text ?? "") + string).count > qs_limitCount
            if isOverLimit {
                if let block = qs_textOverCountAction {
                    block()
                }
                return !isOverLimit
            }
        }
        
        // 限制小数位数
        if qs_limitDecimalCount > 0 {
            let str = (textField.text ?? "") + string
            let isNumber = validateNumber(number: str, decimals: qs_limitDecimalCount)
            if !isNumber {
                return !isNumber
            }
        }
        
        // 是否允许输入
        if let block = qs_shouldChangeCharactersAction {
            return block(string)
        }
        
        return true
    }
}
