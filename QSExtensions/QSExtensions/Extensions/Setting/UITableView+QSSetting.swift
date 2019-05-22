//
//  UITableView+QSSetting.swift
//  QSExtensions
//
//  Created by Song on 2019/2/21.
//  Copyright © 2019 Song. All rights reserved.
//

import UIKit

extension UITableView {
    /// 创建tableView
    ///
    /// - Parameter style: 样式
    public class func qs_init(style: UITableView.Style) -> UITableView {
        let tableView = UITableView.init(frame: .zero, style: style)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        // 自适应cell高度
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // 自适应headerView的高度
        tableView.estimatedSectionHeaderHeight = 100.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        // 自适应footerView的高度
        tableView.estimatedSectionFooterHeight = 100.0
        tableView.sectionFooterHeight = UITableView.automaticDimension
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }
    
    /// 设置背景颜色
    public func qs_backgroundColor(_ color: UIColor) -> UITableView {
        backgroundColor = color
        return self
    }
    
    /// 设置数据源
    public func qs_dataSource(_ dataSource: UITableViewDataSource) -> UITableView {
        self.dataSource = dataSource
        return self
    }
    
    /// 设置代理
    public func qs_delegate(_ delegate: UITableViewDelegate) -> UITableView {
        self.delegate = delegate
        return self
    }
}
