//
//  UIScrollView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UIScrollView {
    public class func qs_init() -> UIScrollView {
        let scrView = UIScrollView.init()
        
        scrView.showsVerticalScrollIndicator = false
        scrView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            scrView.contentInsetAdjustmentBehavior = .never
        }
        
        return scrView
    }
}
