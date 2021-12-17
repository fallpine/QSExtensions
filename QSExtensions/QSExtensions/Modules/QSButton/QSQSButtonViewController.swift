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
            make.width.equalTo(80.0)
            make.height.equalTo(30.0)
        }
        
        view.addSubview(rightImgBtn)
        rightImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(leftImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(80.0)
            make.height.equalTo(30.0)
        }
        
        view.addSubview(topImgBtn)
        topImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(rightImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(80.0)
            make.height.equalTo(60.0)
        }
        
        view.addSubview(bottomImgBtn)
        bottomImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topImgBtn.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(80.0)
            make.height.equalTo(60.0)
        }
    }
    
    
    private lazy var leftImgBtn: QSButton = {
        let btn = QSButton.init()
        .qs_setImage(UIImage.init(named: "star"), for: .normal)
        .qs_setTitle("title", for: .normal)
        .qs_setBackgroundColor(.red, for: .normal)
        .qs_setTitleColor(.black, for: .normal) as! QSButton
        
        btn.margin = 5.0
        btn.imgStyle = .left   // 默认就是图片在左边
        return btn
    }()
    
    private lazy var rightImgBtn: QSButton = {
        let btn = QSButton.init()
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.green, for: .normal)
            .qs_setTitleColor(.black, for: .normal) as! QSButton
        
        btn.margin = 5.0
        btn.imgStyle = .right
        return btn
    }()
    
    private lazy var topImgBtn: QSButton = {
        let btn = QSButton.init()
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.blue, for: .normal)
            .qs_setTitleColor(.black, for: .normal) as! QSButton
        
        btn.margin = 5.0
        btn.imgStyle = .top
        return btn
    }()
    
    private lazy var bottomImgBtn: QSButton = {
        let btn = QSButton.init()
            .qs_setImage(UIImage.init(named: "star"), for: .normal)
            .qs_setTitle("title", for: .normal)
            .qs_setBackgroundColor(.yellow, for: .normal)
            .qs_setTitleColor(.black, for: .normal) as! QSButton
        
        btn.margin = 5.0
        btn.imgStyle = .bottom
        return btn
    }()
}
