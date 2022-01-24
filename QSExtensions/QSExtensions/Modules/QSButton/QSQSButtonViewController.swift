//
//  QSQSButtonViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/8/10.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSQSButtonViewController: UIViewController {
    override func viewDidLoad() {
        title = "QSButton"
        
        super.viewDidLoad()
        
        view.addSubview(leftImgBtn)
        leftImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(100.0)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(rightImgBtn)
        rightImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(leftImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(topImgBtn)
        topImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(rightImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bottomImgBtn)
        bottomImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }
        
        leftImgBtn.qs_setAction { btn in
            print("leftImgBtn")
        }
    }
    
    // MARK: - Widget
    private lazy var leftImgBtn: QSButton = {
        let btn = QSButton.init(btnStyle: .imageLeft, margin: 5.0)
        .qs_setImage(UIImage.init(named: "star"), for: .normal)
        .qs_setTitle("title", for: .normal)
        .qs_setBackgroundColor(.red, for: .normal)
        .qs_setTitleColor(.black, for: .normal)
        .qs_setContentInset(UIEdgeInsets.init(top: 10, left: 10, bottom: -10, right: -10))
        return btn
    }()
    
    private lazy var rightImgBtn: QSButton = {
        let btn = QSButton.init(btnStyle: .imageRight, margin: 5.0)
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.green, for: .normal)
            .qs_setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private lazy var topImgBtn: QSButton = {
        let btn = QSButton.init(btnStyle: .imageTop, margin: 5.0)
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.blue, for: .normal)
            .qs_setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private lazy var bottomImgBtn: QSButton = {
        let btn = QSButton.init(btnStyle: .imageBottom, margin: 5.0)
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.yellow, for: .normal)
            .qs_setTitleColor(.black, for: .normal)
        return btn
    }()
}
