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
    /// 设置占位字符的颜色
    public var qs_placeholderColor: UIColor? {
        didSet {
            var change = false
            
            // 保证有占位文字
            if placeholder == nil {
                placeholder = " "
                change = true
            }
            
            // 设置占位文字颜色
            setValue(qs_placeholderColor, forKeyPath: "placeholderLabel.textColor")
            
            // 恢复原状
            if change {
                placeholder = nil
            }
        }
    }
    
    /// 限制输入字符的长度
    public var qs_limitTextLength: Int? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 限制小数位数
    public var qs_limitDecimalLength: Int? {
        didSet {
            keyboardType = UIKeyboardType.decimalPad
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 是否允许输入emoji
    public var qs_isAllowEmoji: Bool = true {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 只允许输入数字和字母
    public var qs_isOnlyLetterAndNumber: Bool = false {
        didSet {
            delegate = delegate == nil ? self : delegate
            // 关闭联想
            self.autocorrectionType = .no
        }
    }
    
    /// 只显示大写字母
    public var qs_onlyShowUpperLetter: Bool = false {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 字数超出限制回调
    public var qs_textOverLimitedBlock: ((Int) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 是否允许编辑的回调
    public var qs_isAllowEditingBlock: (() -> (Bool))? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// 内容改变回调
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
    
    /// 结束编辑回调
    public var qs_textDidEndEditBlock: ((String) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    /// return按钮事件回调
    public var qs_returnBtnBlock: ((String) -> ())? {
        didSet {
            delegate = delegate == nil ? self : delegate
        }
    }
    
    // MARK: - Func
    /// 字符改变
    @objc private func editingChanged() {
        self.textChange(text: self.text)
    }
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
            limitTextLength()
            // 限制小数位数
            limitDecimalLength(text: myText)
        }
    }
    
    /// 限制字符长度
    private func limitTextLength() {
        if let myText = self.text {
            // 获取高亮部分
            let selectedRange = self.markedTextRange
            if let _ = selectedRange?.start {
            } else {
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if let limitLength = qs_limitTextLength {
                    if myText.count > limitLength {
                        // 截取字符串
                        let toStrIndex = myText.index(myText.startIndex, offsetBy: limitLength)
                        
                        self.text = String(myText[myText.startIndex ..< toStrIndex])
                        
                        if qs_textOverLimitedBlock != nil {
                            qs_textOverLimitedBlock!(limitLength)
                        }
                    }
                }
            }
        }
    }
    
    /// 限制小数位数
    ///
    /// - Parameter text: 文字
    private func limitDecimalLength(text: String) {
        if qs_limitDecimalLength != nil && qs_limitDecimalLength! > 0 {
            let isNumber = isDecimal(string: text)
            if isNumber {
                let strArr = text.components(separatedBy: CharacterSet.init(charactersIn: "."))
                if strArr.count > 1 {
                    if let str = strArr.last {
                        if str.count > qs_limitDecimalLength! {
                            let toStrIndex = text.index(text.startIndex, offsetBy: text.count - (str.count - qs_limitDecimalLength!))
                            
                            self.text = String(text[text.startIndex ..< toStrIndex])
                        }
                    }
                }
            } else {
                #if DEBUG
                debugPrint("输入内容不符合格式！")
                #endif
            }
        }
    }
    
    /// 显示大写字母
    private func onlyShowUpperLetter(text: String) {
        self.text = (self.text ?? "") + text.uppercased()
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
    private func validateNumber(number: String, decimals: Int) -> Bool {
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
    
    /// 要输入的字符是否包含emoji表情
    private func isContainsEmoji(text: String) -> Bool {
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
    
    /// 判断是否是数字或字母
    private func qs_isLetterOrNumber(text: String) -> Bool {
        let passwordStr = "^[0-9a-zA-Z]$"
        let passwordPre = NSPredicate(format: "SELF MATCHES %@", passwordStr)
        
        return passwordPre.evaluate(with: text)
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
        if qs_isAllowEditingBlock != nil {
            return qs_isAllowEditingBlock!()
        }
        
        return true
    }
    
    /// 开始编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if qs_textDidBeginEditBlock != nil {
            return qs_textDidBeginEditBlock!()
        }
    }
    
    /// 结束编辑
    ///
    /// - Parameter textField: 输入框
    public func textFieldDidEndEditing(_ textField: UITextField) {
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
        if isStringEmpty(string) {
            return true
        }
        
        // 不允许输入emoji
        if !qs_isAllowEmoji {
            if isContainsEmoji(text: string) {
                return false
            }
        }
        
        // 只允许输入数字和字母
        if qs_isOnlyLetterAndNumber {
            if !qs_isLetterOrNumber(text: string) {
                if !string.isEmpty {
                    return false
                }
            }
        }
        
        // 只显示大写字母
        if qs_onlyShowUpperLetter {
            if !string.isEmpty {
                self.onlyShowUpperLetter(text: string)
                return false
            }
        }
        
        // 限制小数位数
        if qs_limitDecimalLength != nil && qs_limitDecimalLength! > 0 {
            let str = textField.text! + string
            return validateNumber(number: str, decimals: qs_limitDecimalLength!)
        }
        
        return true
    }
}
