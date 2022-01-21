//
//  QSUIButtonViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Button"
        
        view.addSubview(textLab)
        textLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        view.addSubview(blueBtn)
        blueBtn.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.top.equalTo(textLab.snp.bottom).offset(60.0)
            make.right.equalTo(-45.0)
            make.height.equalTo(33.0)
        }
        blueBtn.qs_setAction { [unowned self] (btn) in
            self.count += 1
            self.textLab.text = "点击了蓝色按钮：" + "\(self.count)"
        }
    }
    
    // MARK: - Property
    var count: Int = 0
    
    // MARK: - Widget
    private lazy var textLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 15.0)
        lab.textAlignment = .center
        lab.text = "xxxxx"
        return lab
    }()
    
    private lazy var blueBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("blue btn", for: .normal)
        btn.qs_setBackgroundColor(.blue, state: .normal)
        btn.qs_setEnlargeEdge(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
        return btn
    }()
}
