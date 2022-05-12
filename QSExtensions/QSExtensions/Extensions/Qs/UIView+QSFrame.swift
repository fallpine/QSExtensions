//
//  UIView+QSFrame.swift
//  QSExtensions
//
//  Created by Song on 2018/7/19.
//  Copyright © 2018年 Song. All rights reserved.
//

import UIKit

public extension UIView {
    /// 左上角x
    var qs_x: CGFloat {
        get {
            return frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    /// 左上角y
    var qs_y: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    /// 左上角坐标
    var qs_origin: CGPoint {
        get {
            return frame.origin
        }
        
        set {
            qs_x = newValue.x
            qs_y = newValue.y
        }
    }
    
    /// 中点x
    var qs_centerX: CGFloat {
        get {
            return center.x
        }
        
        set {
            center = CGPoint.init(x: newValue, y: center.y)        }
    }
    
    /// 中点y
    var qs_centerY: CGFloat {
        get {
            return center.x
        }
        
        set {
            center = CGPoint.init(x: center.x, y: newValue)
        }
    }
    
    /// 宽
    var qs_width: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /// 高
    var qs_height: CGFloat {
        get {
            return frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /// 大小
    var qs_size: CGSize {
        get {
            return frame.size
        }
        
        set {
            qs_width = newValue.width
            qs_height = newValue.height
        }
    }
}

