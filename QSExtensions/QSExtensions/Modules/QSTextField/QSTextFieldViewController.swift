//
//  QSTextFieldViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/25.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSTextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "QSTextField"
        
        view.addSubview(limitCountLab)
        limitCountLab.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        view.addSubview(returnBtnLab)
        returnBtnLab.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(limitCountLab.snp.bottom).offset(10.0)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(returnBtnLab.snp.bottom).offset(10.0)
        }
        
        textField.placeholder = "限制输入字符长度"
        textField.qs_placeholderColor = .darkGray
        textField.qs_limitTextLength = 11
        textField.qs_isAllowEmoji = true
        textField.qs_textOverLimitedBlock = { [unowned self] (count) in
            self.limitCountLab.text = "限制输入字符长度：" + "\(count)"
        }
        textField.qs_textDidChangeBlock = { [unowned self] (text) in
            if let limitCount = self.textField.qs_limitTextLength {
                if text.count < limitCount {
                    self.limitCountLab.text = "限制输入字符长度"
                }
            }
        }
        textField.text = "sdfsfds12345"
        
        textField.qs_returnBtnBlock = { [unowned self] (text) in
            self.returnBtnLab.text = "returnValue：" + text
        }
        
        view.addSubview(limitDecimalTF)
        limitDecimalTF.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(textField.snp.bottom).offset(10.0)
        }
        limitDecimalTF.placeholder = "限制小数位数"
        limitDecimalTF.qs_limitDecimalLength = 3
        limitDecimalTF.text = "11hj"
        
        view.addSubview(isAllowEditLab)
        isAllowEditLab.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(limitDecimalTF.snp.bottom).offset(30.0)
        }
        
        view.addSubview(isAllowEditTF)
        isAllowEditTF.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(isAllowEditLab.snp.bottom).offset(10.0)
        }
        
        isAllowEditTF.qs_isAllowEditingBlock = { [unowned self] in
            self.isAllowEditLab.text = self.isAllowEditTF.placeholder
            return false
        }
        
        view.addSubview(isOnlyLetterAndNumberTF)
        isOnlyLetterAndNumberTF.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(isAllowEditTF.snp.bottom).offset(10.0)
        }
    }
    
    // MARK: - Widget
    private lazy var textField: QSTextField = {
        let tf = QSTextField.init()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var limitCountLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "限制输入字符长度"
        return lab
    }()
    
    private lazy var returnBtnLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "returnValue"
        return lab
    }()
    
    private lazy var limitDecimalTF: QSTextField = {
        let tf = QSTextField.init()
        .qs_placeholderColor(.red) as! QSTextField
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var isAllowEditLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "xxxx"
        return lab
    }()
    
    private lazy var isAllowEditTF: QSTextField = {
        let tf = QSTextField.init()
        tf.borderStyle = .roundedRect
        tf.placeholder = "不允许编辑"
        return tf
    }()
    
    private lazy var isOnlyLetterAndNumberTF: QSTextField = {
        let tf = QSTextField.init()
        tf.borderStyle = .roundedRect
        tf.placeholder = "只允许数字和字母"
        tf.qs_isOnlyLetterAndNumber = true
        return tf
    }()
}
