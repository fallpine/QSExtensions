//
//  UIImageView+QSSetting.swift
//  QSExtensions
//
//  Created by Mac on 2022/4/26.
//  Copyright © 2022 Song. All rights reserved.
//

import UIKit
import Kingfisher

public extension UIImageView {
    /// 创建
    ///
    /// - Parameter contentMode: 样式
    convenience init(contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.init(frame: .zero)
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
    
    /// 设置图片
    ///
    /// - Parameters:
    ///   - imgName: 图片名
    ///   - placeholder: 占位图片
    ///   - complete: 设置图片完成回调
    @discardableResult
    func qs_setImage(_ imgName: String, placeholder: String? = nil, complete: ((UIImage?) -> ())? = nil) -> UIImageView {
        // 占位图
        if let placeholder = placeholder {
            if !placeholder.isEmpty {
                image = UIImage.init(named: placeholder)
            }
        }
        
        // 没有图片
        if imgName.isEmpty {
            return self
        }
        
        // 网络图片
        if imgName.lowercased().hasPrefix("http://") ||
            imgName.lowercased().hasPrefix("https://") {
            if let url = URL.init(string: imgName) {
                kf.setImage(with: ImageResource.init(downloadURL: url), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.35))]) { result in
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
                qs_setGifImage(imgName, complete: complete)
                return self
            }
            
            // 本地普通图片
            image = UIImage.init(named: imgName)
            if let block = complete {
                block(image)
            }
        }
        
        return self
    }
    
    /// 设置gif图片
    private func qs_setGifImage(_ imgName: String, complete: ((UIImage?) -> ())? = nil) {
        if let path = Bundle.main.path(forResource: imgName, ofType:"") {
            let url = URL.init(fileURLWithPath: path)
            kf.setImage(with: ImageResource.init(downloadURL: url), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.35))], progressBlock: nil) { result in
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
