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
        
        textView.superview?.layoutIfNeeded()
        textView.qs_addRoundingCorners(radius: 5.0, corners: [.topLeft, .topRight])
        
        view.addSubview(scrlView)
        scrlView.snp.makeConstraints { (make) in
            make.left.right.equalTo(textView)
            make.top.equalTo(textView.snp.bottom).offset(20.0)
            make.height.equalTo(60.0)
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        myView.qs_addRoundingCorners(radius: 6.0, corners: .allCorners)
//        myView.qs_addBorder(width: 2.0, color: .blue, radius: 6.0, corners: .allCorners, borderPath: nil)
//        myView.qs_addShadow(radius: 6.0, horizontalOffset: 0.0, verticalOffset: 0.0, shadowOpacity: 0.5, shadowColor: .red, shadowPath: nil)
//
//        scrlView.qs_addRoundingCorners(radius: 10.0)
//    }
    
    // MARK: - Widget
    private lazy var myView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .yellow
        view.qs_addRoundingCorners(radius: 16.0, corners: [.topLeft, .bottomRight])
        view.qs_addBorder(width: 2.0, color: .blue, radius: 16.0, corners: [.topLeft, .bottomRight], borderPath: nil)
        view.qs_addShadow(radius: 16.0, horizontalOffset: 0.0, verticalOffset: 0.0, shadowOpacity: 1.0, shadowColor: .red, shadowPath: nil)
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
    
    private lazy var scrlView: UIScrollView = {
        let view = UIScrollView.init()
        view.backgroundColor = .blue
        view.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()
}
