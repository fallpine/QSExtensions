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
            make.centerX.equalToSuperview()
            make.top.equalTo(160.0)
            make.height.equalTo(100.0)
            make.width.equalTo(30.0)
        }
        textView.qs_placeholder = "占位符"
        textView.qs_placeholderColor = .blue
//        textView.qs_limitTextLength = 1000
//        textView.qs_firstLineLeftEdge(30.0)
//        textView.qs_isAllowEmoji = false
//        textView.qs_textContainerInset(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
        
//        textView.qs_textDidChangeBlock = { [weak self] (text) in
//            let height = text.qs_obtainHeight(font: UIFont.systemFont(ofSize: 15.0), width: UIScreen.main.bounds.width - 90.0)
//            self?.textView.snp.updateConstraints({ (make) in
//                make.height.equalTo(height)
//            })
//        }
        
        textView.text = "aaabbb哈哈"
        let attributedString = textView.attributedText.qs_setUnderLine("aaa", color: .blue)
        textView.attributedText = attributedString
        textView.qs_addLink("aaa") {
            print("aaa", "aaa")
        }
        
        textView.qs_addLink("哈哈") {
            print("aaa", "哈哈")
        }
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        var width = textView.text.qs_width(font: UIFont.systemFont(ofSize: 15.0), height: 30.0)
        let height = textView.text.qs_height(font: UIFont.systemFont(ofSize: 15.0), width: UIScreen.main.bounds.width - 20.0)
        if width > (UIScreen.main.bounds.width - 20.0) {
            width = UIScreen.main.bounds.width - 20.0
        }
        textView.snp.updateConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    // MARK: - Widget
    private lazy var textView: QSTextView = {
        let tv = QSTextView.init()
        tv.backgroundColor = .yellow
        tv.font = UIFont.systemFont(ofSize: 15.0)
        tv.textVerticalAlignment = .center
        return tv
    }()
}
