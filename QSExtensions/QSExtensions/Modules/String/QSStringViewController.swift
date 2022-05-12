//
//  QSStringViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSStringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "String"
        
        view.addSubview(scrView)
        scrView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 时间戳转换为时间字符串
        scrView.addSubview(dateStrLab)
        dateStrLab.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.left.right.equalToSuperview()
            make.top.equalTo(100.0)
        }
        dateStrLab.text = "时间戳" + Date.init().qs_toTimestamp().qs_toString() + "：" + Date.init().qs_toString(format: "yyyy-MM-dd HH:mm:ss")
        
        // 获取字符串宽度
        scrView.addSubview(getWidthLab)
        getWidthLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateStrLab.snp.bottom).offset(30.0)
        }
        getWidthLab.text = "字符串宽度：" + "\("字符串宽度".qs_width(font: getWidthLab.font, height: 30.0))"
        
        // 获取字符串高度
        scrView.addSubview(getHeightLab)
        getHeightLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(getWidthLab.snp.bottom).offset(30.0)
        }
        getHeightLab.text = "字符串高度：" + "\("字符串高度".qs_height(font: getHeightLab.font, width: UIScreen.main.bounds.width))"
        
        scrView.addSubview(groupLab)
        groupLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(getHeightLab.snp.bottom).offset(30.0)
            make.bottom.equalTo(-100.0)
        }
        
        let groupStr = "123456789a"
        let tempStr = groupStr.qs_group(size: 3, separator: " ")
        groupLab.text = "123456789a：" + tempStr
    }
    
    // MARK: - Widget
    private lazy var scrView: UIScrollView = {
        let scr = UIScrollView.init()
        scr.backgroundColor = .white
        return scr
    }()
    
    private lazy var dateStrLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var getWidthLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var getHeightLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var groupLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
}
