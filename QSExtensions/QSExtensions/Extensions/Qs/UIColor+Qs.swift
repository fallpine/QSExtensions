//
//  UIColor+Qs.swift
//  QSExtensions
//
//  Created by Song on 2018/4/26.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

extension UIColor {
    /// 设置16进制颜色
    ///
    /// - Parameters:
    ///   - hex: 16进制数
    ///   - alpha: 透明度
    public static func qs_color(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: CGFloat(Double(((hex & 0xFF0000) >> 16)) / 255.0), green: CGFloat(Double((((hex & 0xFF00) >> 8))) / 255.0), blue: CGFloat(Double(((hex & 0xFF))) / 255.0), alpha: alpha)
    }
    
    /// 渐变颜色
    ///
    /// - Parameters:
    ///   - size: 范围大小
    ///   - angle: 渐变角度（0 ~ 2*Double.pi）
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    public static func qs_gradientColor(size: CGSize, angle: Double, startColor: UIColor, endColor: UIColor) -> UIColor {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        // 设置开始和结束位置
        // (0,0)(1.0,0)代表水平方向渐变
        // (0,0)(0,1.0)代表竖直方向渐变
        var startPoint: CGPoint = CGPoint.init(x: 0.0, y: 0.0)
        var endPoint: CGPoint = CGPoint.init(x: 0.0, y: 0.0)
        if angle == 0.0 || angle == Double.pi {
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0, y: 0.0)
        } else if angle > 0.0 && angle < Double.pi / 4 {
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0, y: tan(angle))
        } else if angle == Double.pi / 4 {
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0, y: 1.0)
        } else if angle > Double.pi / 4 && angle < Double.pi / 2 {
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0 / tan(angle), y: 1.0)
        } else if angle == Double.pi / 2 {
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 0.0, y: 1.0)
        } else if angle > Double.pi / 2 && angle < Double.pi / 4 * 3 {
            startPoint = CGPoint.init(x: 1.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0 / tan(Double.pi - angle), y: 1.0)
        } else if angle == Double.pi / 4 * 3 {
            startPoint = CGPoint.init(x: 1.0, y: 0.0)
            endPoint = CGPoint.init(x: 0.0, y: 1.0)
        } else if angle > Double.pi / 4 * 3 && angle < Double.pi {
            startPoint = CGPoint.init(x: 1.0, y: 0.0)
            endPoint = CGPoint.init(x: 1.0, y: tan(Double.pi - angle))
        }
        
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        // 生成颜色
        UIGraphicsBeginImageContext(size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor.init(patternImage: image!)
    }
}
