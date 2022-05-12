//
//  QSEncodeViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSEncodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Encode"
        
        view.addSubview(urlTitleLab)
        urlTitleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(160.0)
        }
        
        view.addSubview(base64EncodeLab)
        base64EncodeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(urlTitleLab.snp.bottom).offset(30.0)
        }
        base64EncodeLab.text = "base64 encode 123：" + ("123".qs_toData()?.qs_base64Encode() ?? "")
        
        view.addSubview(base64DecodeLab)
        base64DecodeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(base64EncodeLab.snp.bottom).offset(30.0)
        }
        
        base64DecodeLab.text = "base64 decode " + ("123".qs_toData()?.qs_base64Encode() ?? "") + "：" + ("123".qs_toData()?.qs_base64Encode().qs_base64Decode()?.qs_toString() ?? "")
        
        view.addSubview(unicodeEncodeLab)
        unicodeEncodeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(base64DecodeLab.snp.bottom).offset(30.0)
        }
        unicodeEncodeLab.text = "unicode encode 😂：" + ("😂".qs_unicodeEncode() ?? "")
        
        view.addSubview(unicodeDecodeLab)
        unicodeDecodeLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(unicodeEncodeLab.snp.bottom).offset(30.0)
        }
        unicodeDecodeLab.text = "unicode decode " + ("😂".qs_unicodeEncode() ?? "") + "：" + ("😂".qs_unicodeEncode()?.qs_unicodeDecode() ?? "")
    }
    
    // MARK: - Widget
    private lazy var urlTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        lab.text = "url编解码不演示"
        return lab
    }()
    
    private lazy var base64EncodeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var base64DecodeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var unicodeEncodeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var unicodeDecodeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14.0)
        lab.textAlignment = .center
        return lab
    }()
}
