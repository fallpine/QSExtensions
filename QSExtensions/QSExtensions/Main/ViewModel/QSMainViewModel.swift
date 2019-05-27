//
//  QSMainViewModel.swift
//  QSExtensions
//
//  Created by Song on 2019/5/18.
//  Copyright © 2019 Song. All rights reserved.
//

import Foundation

class QSMainViewModel {
    lazy var dataSource: [String] = {
        let arr = ["Date",
                   "Md5",
                   "Encode",
                   "String",
                   "Timer",
                   "UIBarButtonItem",
                   "UIButton",
                   "UIColor",
                   "UIFont",
                   "UIImage",
                   "UIImageView",
                   "UILabel",
                   "QSTextField",
                   "QSTextView",
                   "UIView",
                   "UIViewController",
                   "EqualOrigin",
                   "MJRefresh+HandyJSON"]
        return arr
    }()
}
