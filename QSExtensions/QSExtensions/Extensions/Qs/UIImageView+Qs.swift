//
//  UIImageView+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// 设置图片
    ///
    /// - Parameters:
    ///   - imgName: 图片名
    ///   - placeholder: 占位图片
    public func qs_setImage(with imgName: String, placeholder: String? = nil) {
        if imgName.isEmpty {
            image = UIImage.init(named: placeholder ?? "")
            return
        }
        
        // gif图
        if imgName.hasSuffix(".gif") {
            qs_setGifImage(imgName)
            return
        }
        
        // 网络图片
        if imgName.hasPrefix("http://") || imgName.hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setImage(with: ImageResource.init(downloadURL: url), placeholder: UIImage.init(named: placeholder ?? ""), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.35))], progressBlock: nil, completionHandler: nil)
            }
        } else {
            image = UIImage.init(named: imgName)
        }
    }
    
    /// 设置gif图片
    private func qs_setGifImage(_ imgName: String) {
        if let path = Bundle.main.path(forResource: imgName, ofType:"") {
            let url = URL.init(fileURLWithPath: path)
            kf.setImage(with: ImageResource.init(downloadURL: url))
        }
    }
}
