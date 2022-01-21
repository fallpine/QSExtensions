//
//  UITableView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

public extension UITableView {
    /// 创建tableView
    ///
    /// - Parameter style: 样式
    convenience init(style: UITableView.Style) {
        self.init(frame: .zero, style: style)
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
        
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0.0
            self.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 0.0, height: 0.01))
        }
    }
    
    /// 设置背景颜色
    func qs_backgroundColor(_ color: UIColor) -> UITableView {
        self.backgroundColor = color
        return self
    }
    
    /// 设置数据源
    func qs_dataSource(_ dataSource: UITableViewDataSource) -> UITableView {
        self.dataSource = dataSource
        return self
    }
    
    /// 设置代理
    func qs_delegate(_ delegate: UITableViewDelegate) -> UITableView {
        self.delegate = delegate
        return self
    }
    
    /// 设置自适应cell高度
    func qs_automaticRowHeight() -> UITableView {
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableView.automaticDimension
        return self
    }
    
    /// 设置自适应headerView高度
    func qs_automaticSectionHeaderHeight() -> UITableView {
        self.estimatedSectionHeaderHeight = 100.0
        self.sectionHeaderHeight = UITableView.automaticDimension
        return self
    }
    
    /// 设置自适应footerView高度
    func qs_automaticSectionFooterHeight() -> UITableView {
        self.estimatedSectionFooterHeight = 100.0
        self.sectionFooterHeight = UITableView.automaticDimension
        return self
    }
}
