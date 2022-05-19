//
//  Single+HandyJson.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/18.
//  Copyright © 2022 Song. All rights reserved.
//

import HandyJSON
import RxSwift

public extension Single where Element: Any {
    /// 将JSON数据转成模型对象
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型对象
    func qs_mapObject<T>(type:T.Type) -> Single<T?> where T: HandyJSON {
        return self.asObservable()
            .qs_mapObject(type: type)
            .asSingle()
    }
    
    /// 将JSON数据转成模型数组
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型数组
    func qs_mapArray<T>(type:T.Type) -> Single<[T]?> where T: HandyJSON {
        return self.asObservable()
            .qs_mapArray(type: type)
            .asSingle()
    }
}
