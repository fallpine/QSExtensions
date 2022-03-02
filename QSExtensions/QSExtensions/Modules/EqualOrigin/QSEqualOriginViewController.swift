//
//  QSEqualOriginViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/27.
//  Copyright © 2019 Song. All rights reserved.
//

import RxCocoa
import RxSwift

class QSEqualOriginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EqualOrigin"
        
        view.addSubview(isEqualTextLab)
        isEqualTextLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        view.addSubview(obervableValueTextField)
        obervableValueTextField.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(isEqualTextLab.snp.bottom).offset(30.0)
        }
        
        view.addSubview(sendBtn)
        sendBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(obervableValueTextField.snp.bottom).offset(30.0)
            make.height.equalTo(35.0)
            make.width.equalTo(80.0)
        }
        
        subject.qs_isEqualToOriginValue()
            .bind(onNext: { [unowned self] (value, isEqual) in
                self.isEqualTextLab.text = "value:" + value
                if isEqual {
                    self.isEqualTextLab.text! += "与原值相等"
                } else {
                    self.isEqualTextLab.text! += "与原值不相等"
                }
            }).disposed(by: self.disposeBag)
        
        sendBtn.qs_addTapAction { [unowned self] (btn) in
            self.subject.onNext(self.obervableValueTextField.text ?? "")
        }
    }
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: "")
    
    // MARK: - Widget
    private lazy var isEqualTextLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "xxxx"
        return lab
    }()
    
    private lazy var obervableValueTextField: QSTextField = {
        let tf = QSTextField.init()
        .qs_placeholder("可监听序列发送的值")
        return tf as! QSTextField
    }()
    
    private lazy var sendBtn: UIButton = {
        let btn = UIButton.init()
        .qs_setTitle("发送", for: .normal)
        .qs_setTitleColor(.blue, for: .normal)
        .qs_setBackgroundColor(.yellow, for: .normal)
        return btn
    }()
}
