//
//  QSMJRefreshViewController.swift
//  QSExtensions
//
//  Created by Song on 2019/5/27.
//  Copyright © 2019 Song. All rights reserved.
//

import RxSwift
import RxCocoa

class QSMJRefreshViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MJRefresh+HandyJSON"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.rx.qs_reachedTop.asObservable()
            .bind { _ in
                print("到顶了")
            }.disposed(by: disposeBag)
        
        tableView.rx.qs_reachedBottom.asObservable()
            .bind { _ in
                print("到底了")
            }.disposed(by: disposeBag)
        
        tableView.qs_addHeaderRefresh()
        viewModel.headerRefresh(tableView: tableView, header: tableView.mj_header!.rx.qs_refreshing.asObservable(), disposeBag: disposeBag)
        // 停止下拉
        viewModel.endHeaderRefreshing
            .bind(to: tableView.mj_header!.rx.qs_endRefreshing)
            .disposed(by: disposeBag)
        
        // 上拉加载
        tableView.qs_addFooterRefresh()
        viewModel.footerRefresh(tableView: tableView, footer: tableView.mj_footer!.rx.qs_refreshing.asObservable(), disposeBag: disposeBag)
        // 停止上拉
        viewModel.endFooterRefreshing
            .bind(to: tableView.mj_footer!.rx.qs_endRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.listData
            .bind(to: tableView.rx.items) { (tableView, row, model) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                
                cell?.textLabel?.text = model.str ?? ""
                
                return cell!
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
    private lazy var viewModel: QSMJRefreshViewModel = {
        let vm = QSMJRefreshViewModel.init()
        return vm
    }()
    
    // MARK: - Widget
    private lazy var tableView: UITableView = {
        let table = UITableView.init()
        table.backgroundColor = .white
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
}
