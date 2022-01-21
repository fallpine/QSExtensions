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
        
        let imgBtnItem = UIBarButtonItem.qs_imgBtnItem(img: "back_arrow") { [weak self] btn in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.setLeftBarButton(imgBtnItem, animated: true)
        
        let titleBtnItem =  UIBarButtonItem.qs_titleBtnItem(title: "文字", color: .black, selectedColor: .red, disabledColor: .green, font: UIFont.systemFont(ofSize: 16.0)) { [weak self] btnItem in
            self?.textLab.text = "文字"
        }
        navigationItem.setRightBarButtonItems([titleBtnItem], animated: true)
    }
    
    // MARK: - Widget
    private lazy var textLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 15.0)
        lab.textAlignment = .center
        lab.text = "xxxxx"
        return lab
    }()
}
