//
//  QSMd5ViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSMd5ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MD5"
        
        view.addSubview(md5StrLab)
        md5StrLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        md5StrLab.text = "123：" + ("123".qs_md5() ?? "")
    }
    
    // MARK: - Widget
    private lazy var md5StrLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
}
