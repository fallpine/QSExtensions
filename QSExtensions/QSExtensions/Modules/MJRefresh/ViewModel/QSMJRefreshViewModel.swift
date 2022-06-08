//
//  QSMJRefreshViewModel.swift
//  QSExtensions
//
//  Created by Song on 2019/5/27.
//  Copyright © 2019 Song. All rights reserved.
//

import RxSwift
import RxCocoa

class QSMJRefreshViewModel {
    // 序列数据
    let listData = BehaviorRelay<[QSMJRefreshDataModel]>(value: [])
    
    // 停止头部刷新
    var endHeaderRefreshing: Observable<QSEndRefreshType> = Observable<QSEndRefreshType>.empty()
    // 停止尾部刷新
    var endFooterRefreshing: Observable<QSEndRefreshType> = Observable<QSEndRefreshType>.empty()
    
    // 下拉刷新
    func headerRefresh(tableView: UITableView, header: Observable<Void>, disposeBag: DisposeBag) {
        let headerRefreshData = header.startWith()
            .flatMapLatest { [unowned self]  _ -> Observable<[QSMJRefreshDataModel]> in
                return self.getRandoms().qs_mapArray(type: QSMJRefreshDataModel.self).asObservable()
            }.share()
        
        headerRefreshData.bind { [unowned self] (response) in
            self.listData.accept(response)
            }.disposed(by: disposeBag)
        
        // 停止刷新
        endHeaderRefreshing = Observable.merge(
            headerRefreshData.map{ _ in .end },
            tableView.rx.qs_isUpDrag.map({ (isEnd) -> QSEndRefreshType in
                return .end
            })
        )
    }
    
    // 上拉加载
    func footerRefresh(tableView: UITableView, footer: Observable<Void>, disposeBag: DisposeBag) {
        // 上拉结果序列
        let footerRefreshData = footer
            .flatMapLatest{ [unowned self] _ -> Observable<[QSMJRefreshDataModel]> in
                return self.getRandoms().qs_mapArray(type: QSMJRefreshDataModel.self).asObservable()
            }.share(replay: 1)
        
        footerRefreshData
            .bind(onNext: { [unowned self] (response) in
                self.listData.accept(self.listData.value + response)
            }).disposed(by: disposeBag)
        
        // 停止尾部刷新
        self.endFooterRefreshing = Observable.merge(
            footerRefreshData.map{ _ in .end },
            tableView.rx.qs_isDrowDrag.map { (isEnd) in
                return .end
            }
        )
    }
    
    /// 获取随机数数组
    private func getRandoms() -> Observable<Array<Dictionary<String, String>>> {
        sleep(2)
        var dataArray = Array<Dictionary<String, String>>()
        for _ in 0 ..< 5 {
            let data = arc4random()
            var dict = Dictionary<String, String>()
            dict["str"] = "\(data)"
            dataArray.append(dict)
        }
        
        return Observable.just(dataArray)
    }
}
