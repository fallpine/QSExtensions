//
//  UITextField+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UITextField: UITextFieldDelegate {
    /// 新增属性key
    private struct AssociatedKeys {
        static var isAllowEditingBlockKey: String = "isAllowEditingBlockKey"
        static var textDidChangeKey: String = "textDidChangeKey"
        static var textDidEndEditKey: String = "textDidEndEditKey"
        static var returnBtnKey: String = "returnBtnKey"
        static var limitTextLengthKey: String = "limitTextLengthKey"
        static var textOverLimitedKey: String = "textOverLimitedKey"
        static var limitDecimalLengthKey: String = "limitDecimalLengthKey"
        static var isObserverTextKey: String = "isObserverTextKey"
    }
    
    /// 设置占位字符的颜色
    var qs_placeholderColor: UIColor {
        get {
            return value(forKeyPath: "placeholderLabel.textColor") as! UIColor
        }
        
        set {
            var change = false
            
            // 保证有占位文字
            if placeholder == nil {
                placeholder = " "
                change = true
            }
            
            // 设置占位文字颜色
            setValue(newValue, forKeyPath: "placeholderLabel.textColor")
            
            // 恢复原状
            if change {
                placeholder = nil
            }
        }
    }
    
    /// 限制输入字符的长度
    var qs_limitTextLength: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.limitTextLengthKey) as? Int
        }
        
        set {
            // 直接用代码设值的时候用KVO监听
            if !(isObserverText ?? false) {
                addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
                isObserverText = true
            }
            
            self.addTarget(self, action: #selector(self.limitTextLength(textField:)), for: .editingChanged)
            
            objc_setAssociatedObject(self, &AssociatedKeys.limitTextLengthKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 限制小数位数
    var qs_limitDecimalLength: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.limitDecimalLengthKey) as? Int
        }
        
        set {
            if !(isObserverText ?? false) {
                addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
                isObserverText = true
            }
            
            delegate = delegate == nil ? self : delegate
            
            keyboardType = UIKeyboardType.decimalPad
            objc_setAssociatedObject(self, &AssociatedKeys.limitDecimalLengthKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 字数超出限制回调
    var qs_textOverLimitedBlock: ((Int) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textOverLimitedKey) as? ((Int) -> ())
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.textOverLimitedKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否允许编辑的回调
    var qs_isAllowEditingBlock: (() -> (Bool))? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isAllowEditingBlockKey) as? (() -> (Bool))
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.isAllowEditingBlockKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 内容改变回调
    var qs_textDidChangeBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textDidChangeKey) as? ((String) -> ())
        }
        
        set {
            if !(isObserverText ?? false) {
                addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
                isObserverText = true
            }
            
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.textDidChangeKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 结束编辑回调
    var qs_textDidEndEditBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textDidEndEditKey) as? ((String) -> ())
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.textDidEndEditKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// return按钮事件回调
    var qs_returnBtnBlock: ((String) -> ())? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.returnBtnKey) as? ((String) -> ())
        }
        
        set {
            delegate = delegate == nil ? self : delegate
            
            objc_setAssociatedObject(self, &AssociatedKeys.returnBtnKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 是否有使用KVO监听输入值变化
    private var isObserverText: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isObserverTextKey) as? Bool
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isObserverTextKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    // MARK: - Private Methods
    /// 字符串是否为空
    private func qs_isStringEmpty(_ string: String?) ->Bool {
        if let str = string {
            return str.isEmpty
        }
        return true
    }
    
    /// 输入改变
    ///
    /// - Parameter not: 通知
    @objc private func textFiledDidChange(_ not: Notification) {
        if qs_textDidChangeBlock != nil {
            qs_textDidChangeBlock!(text!)
        }
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
            let text = change![NSKeyValueChangeKey.newKey] as! String
            
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
            
            // 限制字符长度
            limitTextLength(textField: self)
        }
    }
    
    /// 限制字符长度
    ///
    /// - Parameter textField: 输入框
    @objc private func limitTextLength(textField: UITextField) {
        if textField == self {
            // 获取高亮部分
            let selectedRange = textField.markedTextRange
            if let _ = selectedRange?.start {
            } else {
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if let limitLength = qs_limitTextLength {
                    if (textField.text?.count)! > limitLength {
                        // 截取字符串
                        let toStrIndex = textField.text!.index((textField.text?.startIndex)!, offsetBy: limitLength)
                        
                        textField.text = String(textField.text![textField.text!.startIndex ..< toStrIndex])
                        
                        if qs_textOverLimitedBlock != nil {
                            qs_textOverLimitedBlock!(limitLength)
                        }
                    }
                }
            }
        }
    }
    
    /// 对小数进行正则判断
    ///
    /// - Parameters:
    ///   - number: 数字
    ///   - decimals: 小数位数
    private func validateNumber(number: String, decimals: Int) -> Bool {
        let conditionStr = "^(0\\.\\d{0,\(decimals)}|[1-9][0-9]{0,}+\\.\\d{0,\(decimals)}|[1-9]\\d+|\\d)$"
        let numberPre = NSPredicate(format: "SELF MATCHES %@", conditionStr)
        
        return numberPre.evaluate(with: number)
    }
    
    // MARK: - UITextFieldDelegate
    /// 是否允许开始编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if qs_isAllowEditingBlock != nil {
            return qs_isAllowEditingBlock!()
        }
        
        return true
    }
    
    /// 进入编辑状态
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if !(isObserverText ?? false) {
            addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)
            isObserverText = true
        }
        
        // 监控数据改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFiledDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    /// 结束编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // 删除通知监听者
        textField.removeObserver(self, forKeyPath: "text")
        NotificationCenter.default.removeObserver(self)
        
        if qs_textDidEndEditBlock != nil {
            return qs_textDidEndEditBlock!(textField.text!)
        }
    }
    
    /// 响应键盘的return按钮点击
    ///
    /// - Parameter textField: 输入框
    /// - Returns: true：响应； false：忽略
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        
        if qs_returnBtnBlock != nil {
            qs_returnBtnBlock!(textField.text!)
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
        if qs_isStringEmpty(string) {
            return true
        }
        
        // 限制小数位数
        if qs_limitDecimalLength != nil && qs_limitDecimalLength! > 0 {
            let str = textField.text! + string
            return validateNumber(number: str, decimals: qs_limitDecimalLength!)
        }
        
        return true
    }
}

