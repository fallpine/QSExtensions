//
//  QSUIBarButtonItemViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIBarButtonItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textLab)
        textLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        navigationItem.setLeftBarButton(imgBtnItem, animated: true)
        navigationItem.setRightBarButtonItems([titleBtnItem, imgAndTitleBtnItem], animated: true)
    }
    
    // MARK: - Func
    @objc private func imgBtnitemSelector() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func titleBtnItemSelector() {
        textLab.text = "文字"
    }
    
    @objc private func imgAndTitleBtnItemSelector() {
        textLab.text = "图片+文字"
    }
    
    // MARK: - Widget
    private lazy var textLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 15.0)
        lab.textAlignment = .center
        lab.text = "xxxxx"
        return lab
    }()
    
    private lazy var imgBtnItem: UIBarButtonItem = {
        let btn = UIBarButtonItem.qs_imgBtnItem(img: "back_arrow", highlightImg: nil, disabledImg: nil, target: self, action: #selector(self.imgBtnitemSelector))
        return btn
    }()
    
    private lazy var titleBtnItem: UIBarButtonItem = {
        let btn = UIBarButtonItem.qs_titleBtnItem(title: "文字", color: .blue, highlightColor: nil, disabledColor: nil, font: UIFont.systemFont(ofSize: 15.0), target: self, action: #selector(self.titleBtnItemSelector))
        return btn
    }()
    
    private lazy var imgAndTitleBtnItem: UIBarButtonItem = {
        let btn = UIBarButtonItem.qs_imgAndTitleBtnItem(title: "图片", selTitle: nil, disTitle: nil, img: "back_arrow", selImg: nil, disImg: nil, titleColor: .green, selTitleColor: nil, disTitleColor: nil, titleFont: UIFont.systemFont(ofSize: 13.0), target: self, action: #selector(self.imgAndTitleBtnItemSelector))
        return btn
    }()
}
