//
//  QSUIImageViewViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/20.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIImageViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIImageView"
        
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(160.0)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200.0)
        }
        imgView.qs_setImage("star")
    }
    
    // MARK: - Widget
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView.init()
        imgV.backgroundColor = .white
        return imgV
    }()
}
