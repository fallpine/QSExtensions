//
//  QSUIFontViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/20.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIFontViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIFont"
        
        view.addSubview(sysFontLab)
        sysFontLab.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.left.right.equalToSuperview()
            make.top.equalTo(100.0)
        }
        sysFontLab.font = UIFont.qs_systemFont(size: 36.0)
        
        view.addSubview(boldFontLab)
        boldFontLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sysFontLab.snp.bottom).offset(30.0)
        }
        boldFontLab.font = UIFont.qs_boldFont(size: 36.0)
        
        view.addSubview(otherFontLab)
        otherFontLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(boldFontLab.snp.bottom).offset(30.0)
        }
        otherFontLab.font = UIFont.qs_otherFont(fontName: ".SFUIDisplay-Medium", size: 36.0)
    }
    
    // MARK: - Widget
    private lazy var sysFontLab: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center
        lab.text = "普通字体"
        return lab
    }()
    
    private lazy var boldFontLab: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center
        lab.text = "加粗字体"
        return lab
    }()
    
    private lazy var otherFontLab: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center
        lab.text = "其他字体"
        return lab
    }()
}
