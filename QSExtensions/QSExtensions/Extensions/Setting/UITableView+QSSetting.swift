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
    func `init`(style: UITableView.Style) -> UITableView {
        let tableView = UITableView.init(frame: .zero, style: style)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        return tableView
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
    
    /// 设置自适应cell高度
    public func qs_automaticRowHeight() -> UITableView {
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableView.automaticDimension
        return self
    }
    
    /// 设置自适应headerView高度
    public func qs_automaticSectionHeaderHeight() -> UITableView {
        self.estimatedSectionHeaderHeight = 100.0
        self.sectionHeaderHeight = UITableView.automaticDimension
        return self
    }
    
    /// 设置自适应footerView高度
    public func qs_automaticSectionFooterHeight() -> UITableView {
        self.estimatedSectionFooterHeight = 100.0
        self.sectionFooterHeight = UITableView.automaticDimension
        return self
    }
}
