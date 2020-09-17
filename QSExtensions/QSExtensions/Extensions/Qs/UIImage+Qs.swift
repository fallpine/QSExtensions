//
//  UIImage+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIImage {
    /// 添加文字水印
    ///
    /// - Parameters:
    ///   - rect: 水印文字的位置
    ///   - text: 水印文字
    ///   - attributes: 水印文字的一些属性设置
    /// - Returns: 带有水印的图片
    public func qs_addWatermark(rect: CGRect, text: String, attributes: [NSAttributedString.Key : Any]) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        if #available(iOS 7, *) {
            text.draw(in: rect, withAttributes: attributes)
        } else {
            text.draw(in: rect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 添加图片水印
    ///
    /// - Parameters:
    ///   - rect: 水印图片的位置
    ///   - image: 水印图片
    /// - Returns: 带有水印的图片
    public func qs_addWatermark(rect: CGRect, image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        image.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 压缩图片到指定大小(质量大小，即data)
    ///
    /// - Parameter length: 图片大小
    /// - Returns: 压缩后的图片
    public func qs_compressToLength(_ length: Int) -> UIImage? {
        var compress : CGFloat = 1.0
        var data = jpegData(compressionQuality: compress)
        
        guard var _ = data?.count else {
            return nil
        }
        
        while compress > 0.01 && (data?.count)! / 1000 > length {
            compress -= 0.02
            data = jpegData(compressionQuality: compress)
        }
        
        if let newImgData = data {
            if let newImg = UIImage.init(data: newImgData) {
                return newImg.qs_scaled(to: newImg.size)
            }
        }
        return nil
    }
    
    /// 将图片缩放成指定尺寸
    ///
    /// - Parameter newSize: 指定的尺寸
    /// - Returns: 缩放后的图片
    public func qs_scaled(to newSize: CGSize) -> UIImage {
        // 计算比例
        let aspectWidth = newSize.width / size.width
        let aspectHeight = newSize.height / size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        // 图片绘制区域
        let scaledImageRect = CGRect.init(x: 0.0, y: 0.0, width: size.width * aspectRatio, height: size.height * aspectRatio)
        
        // 绘制并获取最终图片
        UIGraphicsBeginImageContext(CGSize.init(width: size.width * aspectRatio, height: size.height * aspectRatio))
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /// 生成一张纯色的图片
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小
    /// - Returns: 生成的图片
    public class func qs_createImage(color: UIColor, size: CGSize) -> UIImage? {
        
        let rect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 拉伸图片
    ///
    /// - Parameters:
    ///   - topCap: 上端盖高度
    ///   - leftCap: 左端盖高度
    ///   - bottomCap: 下端盖高度
    ///   - rightCap: 右端盖高度
    ///   - finalImgSize: 图片最后的大小
    /// - Returns: 拉伸后的图片
    public func qs_stretch(topCap: CGFloat, leftCap: CGFloat, bottomCap: CGFloat, rightCap: CGFloat, finalImgSize: CGSize) -> UIImage {
        let insets = UIEdgeInsets(top: topCap, left: leftCap, bottom: bottomCap, right: rightCap)
        // 拉伸图片
        let image = resizableImage(withCapInsets: insets, resizingMode: .stretch)
        
        // 绘制图片
        UIGraphicsBeginImageContext(finalImgSize)
        image.draw(in: CGRect.init(x: 0.0, y: 0.0, width: ceil(finalImgSize.width), height: ceil(finalImgSize.height)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
}
