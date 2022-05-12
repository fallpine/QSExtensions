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
            make.width.equalTo(300.0)
        }
        textView.qs_placeholder = "占位符"
        textView.qs_placeholderColor = .blue
        textView.qs_limitCount = 1000
        textView.qs_firstLineLeftEdge(30.0)
        textView.qs_textContainerInset(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
        
        textView.text = "哈哈123456"
        let attributedString = textView.attributedText.qs_setUnderLine("哈哈", color: .blue)
        textView.attributedText = attributedString
        textView.qs_addLink("哈哈") {
            print("哈哈")
        }
        
        // 设置左右边距
        textView.textContainer.lineFragmentPadding = 50
    }
    
    func test() -> (String) -> (String) -> String {
        return test1(a:)
    }
    
    func test1(a: String) -> (String) -> String {
        return block
    }
    
    func test2(b: String) -> String {
        return "ccc"
    }
    
    var block: (String) -> String = { (aaa) in
        return aaa
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
