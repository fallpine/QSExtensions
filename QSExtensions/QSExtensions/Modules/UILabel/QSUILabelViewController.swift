//
//  QSUILabelViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/20.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUILabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UILabel"
        
        view.addSubview(changeAndColorLab)
        changeAndColorLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        changeAndColorLab.qs_setText("颜色", color: .red)
        changeAndColorLab.qs_setText(font: UIFont.systemFont(ofSize: 22.0), range: NSRange.init(location: 7, length: 2))
        
        view.addSubview(lineSpaceLab)
        lineSpaceLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(changeAndColorLab.snp.bottom).offset(30.0)
        }
        lineSpaceLab.qs_setLineSpace(20.0)
        
        view.addSubview(underLineLab)
        underLineLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(lineSpaceLab.snp.bottom).offset(30.0)
        }
        underLineLab.qs_setUnderLine(underLineLab.text!, color: .blue, stytle: .single)
        
        view.addSubview(deleteLineLab)
        deleteLineLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(underLineLab.snp.bottom).offset(30.0)
        }
        deleteLineLab.qs_setDeleteLine(color: .red, range: NSRange.init(location: 0, length: deleteLineLab.text!.count))
        
        view.addSubview(insertImageLab)
        insertImageLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(deleteLineLab.snp.bottom).offset(30.0)
        }
        insertImageLab.qs_insertImage("back_arrow", imgBounds: CGRect.init(x: 0.0, y: 0.0, width: 15.0, height: 25.0), imgIndex: 1)
        
        view.addSubview(lineLeftEdgeLab)
        lineLeftEdgeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(insertImageLab.snp.bottom).offset(10.0)
        }
    }
    
    // MARK: - Property
    private var count: Int = 0
    
    // MARK: - Widget
    private lazy var changeAndColorLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "修改字体颜色颜色和大小...颜色"
        return lab
    }()
    
    private lazy var lineSpaceLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.textColor = .green
        lab.backgroundColor = .red
        lab.numberOfLines = 0
        lab.text = "设置行间距\n设置行间距2"
        return lab
    }()
    
    private lazy var underLineLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "添加下划线"
        return lab
    }()
    
    private lazy var deleteLineLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "添加中间删除线"
        return lab
    }()
    
    private lazy var insertImageLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.textColor = .yellow
        lab.text = "插入图片"
        return lab
    }()
    
    private lazy var lineLeftEdgeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 20.0)
        lab.textAlignment = .left
        lab.numberOfLines = 0
        lab.text = "首行缩进sfdjkfksakjfkjasfksfjklsjfklsjdlfksdlfjsdfsfdjkfksakjfkjasfksfjklsjfklsjdlfksdlfjsdf"
        
        lab.backgroundColor = .yellow
        lab.qs_firstLineLeftEdge(30.0)
        return lab
    }()
}
