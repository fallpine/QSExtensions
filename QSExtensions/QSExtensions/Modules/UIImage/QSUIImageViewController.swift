//
//  QSUIImageViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/20.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

class QSUIImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIImage"
        
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(160.0)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200.0)
        }
        
        let img = UIImage.qs_createImage(color: .yellow, size: CGSize.init(width: 200.0, height: 200.0))
        let waterImg = img?.qs_addWatermark(rect: CGRect.init(x: 0, y: 0, width: 40.0, height: 30.0), text: "水印", attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue.cgColor])
        imgView.image = waterImg
    }
    
    // MARK: - Widget
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView.init()
        imgV.backgroundColor = .white
        return imgV
    }()
}
