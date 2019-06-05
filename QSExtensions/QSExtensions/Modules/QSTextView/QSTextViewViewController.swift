//
//  QSTextViewViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/25.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSTextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "QSTextView"
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(45.0)
            make.right.equalTo(-45.0)
            make.top.equalTo(160.0)
            make.height.equalTo(200.0)
        }
        textView.qs_placeholder = "占位符"
        textView.qs_placeholderColor = .blue
        textView.qs_limitTextLength = 10
        textView.qs_firstLineLeftEdge(30.0)
        textView.qs_textContainerInset(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
    }
    // MARK: - Widget
    private lazy var textView: QSTextView = {
        let tv = QSTextView.init()
        tv.backgroundColor = .yellow
        return tv
    }()
}
