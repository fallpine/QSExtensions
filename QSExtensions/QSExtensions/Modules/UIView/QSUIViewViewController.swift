//
//  QSUIViewViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIView"
        
        view.addSubview(myView)
        myView.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(160.0)
            make.height.equalTo(80.0)
        }
        
        view.addSubview(frameLab)
        frameLab.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(myView.snp.bottom).offset(30.0)
            make.height.equalTo(200.0)
        }
        frameLab.superview?.layoutIfNeeded()
        frameLab.qs_addRoundingCorners(radius: 6.0, corners: .allCorners)
        frameLab.qs_addBorder(width: 2.0, color: .blue, radius: 6.0, corners: .allCorners, borderPath: nil)
        frameLab.text = "x：" + "\(frameLab.qs_x)" + "\n"
        + "y：" + "\(frameLab.qs_y)" + "\n"
        + "width：" + "\(frameLab.qs_width)" + "\n"
        + "height：" + "\(frameLab.qs_height)"
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.right.equalTo(frameLab)
            make.top.equalTo(frameLab.snp.bottom).offset(20.0)
            make.height.equalTo(60.0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myView.qs_addRoundingCorners(radius: 6.0, corners: .allCorners)
        myView.qs_addBorder(width: 2.0, color: .blue, radius: 6.0, corners: .allCorners, borderPath: nil)
        myView.qs_addShadow(radius: 6.0, horizontalOffset: 0.0, verticalOffset: 0.0, shadowOpacity: 0.5, shadowColor: .red, shadowPath: nil)
    }
    
    // MARK: - Widget
    private lazy var myView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var frameLab: UILabel = {
        let lab = UILabel.init()
        lab.numberOfLines = 0
        lab.backgroundColor = .green
        return lab
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView.init()
        view.backgroundColor = .orange
        return view
    }()
}
