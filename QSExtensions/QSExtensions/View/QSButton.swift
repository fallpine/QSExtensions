//
//  QSButton.swift
//  QSExtensions
//
//  Created by Song on 2018/4/25.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

/// 图片摆放的位置
public enum QSButtonImageStyle {
    case left       // 图片在左边
    case right      // 图片在右边
    case top        // 图片在上边
    case bottom     // 图片在下边
}

public class QSButton: UIButton {
    /// image和label之间的间距
    public var margin: CGFloat = 0.0
    /// image和label排布的样式
    public var imgStyle: QSButtonImageStyle = .left
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置button内容居中
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 获取imageView的宽高
        let imageWidth = imageView?.frame.size.width ?? 0.0
        let imageHeight = imageView?.frame.size.height ?? 0.0
        
        // 获取titleLabel的宽高
        var textFont = UIFont.systemFont(ofSize: 17.0)
        if titleLabel?.font != nil {
            textFont = (titleLabel?.font)!
        }
        let attributes = [NSAttributedString.Key.font : textFont] // 字体
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        var textRect = CGRect.zero
        if let t = titleLabel?.text {
            textRect = t.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil)
        }
        let labelWidth = textRect.size.width
        let labelHeight = textRect.size.height
        // label的内边距
        var labelEdgeInsets = UIEdgeInsets.zero
        
        // 计算imageEdgeInsets和labelEdgeInsets的值
        switch imgStyle {
        case .left:
            let x = (frame.size.width - imageWidth - labelWidth - margin) / 2.0
            let imgX = x < 0.0 ? 0.0 : x
            let imgY = (frame.size.height - imageHeight) / 2.0
            imageView?.frame = CGRect.init(x: imgX, y: imgY, width: imageWidth, height: imageHeight)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: 0.0)
            
        case .right:
            let x = (frame.size.width - imageWidth - labelWidth - margin) / 2.0 + labelWidth + margin
            let imgX = x > (frame.size.width - imageWidth) ? (frame.size.width - imageWidth) : x
            let imgY = (frame.size.height - imageHeight) / 2.0
            imageView?.frame = CGRect.init(x: imgX, y: imgY, width: imageWidth, height: imageHeight)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageWidth, bottom: 0.0, right: imageWidth + margin)
            
        case .top:
            let imgX = (frame.size.width - imageWidth) / 2.0
            let imgY = (frame.size.height - imageHeight - labelHeight - margin) / 2.0
            imageView?.frame = CGRect.init(x: imgX, y: imgY, width: imageWidth, height: imageHeight)

            let labInsetTop = (frame.size.height - imageHeight - labelHeight - margin) / 2.0 + margin + imageHeight - frame.size.height / 2.0 + labelHeight / 2.0
            labelEdgeInsets = UIEdgeInsets(top: labInsetTop * 2.0, left: -imageWidth, bottom: 0.0, right: 0.0)
            
        case .bottom:
            let imgX = (frame.size.width - imageWidth) / 2.0
            let imgY = (frame.size.height - imageHeight - labelHeight - margin) / 2.0 + labelHeight + margin
            imageView?.frame = CGRect.init(x: imgX, y: imgY, width: imageWidth, height: imageHeight)

            let labInsetTop = -((frame.size.height - imageHeight - labelHeight - margin) / 2.0 + margin + imageHeight - frame.size.height / 2.0 + labelHeight / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: labInsetTop * 2.0, left: -imageWidth, bottom: 0.0, right: 0.0)
        }
        
        titleEdgeInsets = labelEdgeInsets
    }
}
