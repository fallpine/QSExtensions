//
//  QSUIColorViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/20.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.top.equalTo(160.0)
            make.right.equalTo(-45.0)
            make.height.equalTo(60.0)
        }
        colorView.backgroundColor = UIColor.qs_color(hex: 0x123456, alpha: 1.0)
        
        view.addSubview(gradientColorView)
        gradientColorView.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.top.equalTo(colorView.snp.bottom).offset(30.0)
            make.right.equalTo(-45.0)
            make.height.equalTo(60.0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientColorView.backgroundColor = UIColor.qs_gradientColor(size: gradientColorView.frame.size, angle: Double.pi / 4, startColor: .red, endColor: .green)
    }
    
    // MARK: - Widget
    private lazy var colorView: UIView = {
        let btn = UIView.init()
        return btn
    }()
    
    private lazy var gradientColorView: UIView = {
        let btn = UIView.init()
        return btn
    }()
}
