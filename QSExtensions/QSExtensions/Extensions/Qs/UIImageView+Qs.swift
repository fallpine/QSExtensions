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
    ///   - complete: 设置图片完成回调
    public func qs_setImage(with imgName: String, placeholder: String? = nil, complete: ((UIImage?) -> ())? = nil) {
        // 没有图片
        if imgName.isEmpty {
            image = UIImage.init(named: placeholder ?? "")
            return
        }
        
        // 网络图片
        if imgName.lowercased().hasPrefix("http://") ||
            imgName.lowercased().hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setImage(with: ImageResource.init(downloadURL: url), placeholder: UIImage.init(named: placeholder ?? ""), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.35))]) { result in
                    switch result {
                    case .success(let value):
                        if let block = complete {
                            block(value.image)
                        }
                    default:
                        break
                    }
                }
            }
        } else {
            // gif图
            if imgName.lowercased().hasSuffix(".gif") {
                qs_setGifImage(imgName, placeholder: placeholder, complete: complete)
                return
            }
            
            // 本地普通图片
            image = UIImage.init(named: imgName)
            if let block = complete {
                block(image)
            }
        }
    }
    
    /// 设置gif图片
    private func qs_setGifImage(_ imgName: String, placeholder: String? = nil, complete: ((UIImage?) -> ())? = nil) {
        if let path = Bundle.main.path(forResource: imgName, ofType:"") {
            let url = URL.init(fileURLWithPath: path)
            kf.setImage(with: ImageResource.init(downloadURL: url), placeholder: UIImage.init(named: placeholder ?? ""), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.35))], progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    if let block = complete {
                        block(value.image)
                    }
                default:
                    break
                }
            }
        }
    }
}
