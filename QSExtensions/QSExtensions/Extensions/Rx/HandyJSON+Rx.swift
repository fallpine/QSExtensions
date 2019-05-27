//
//  HandyJSON+Rx.swift
//  QSExtensions
//
//  Created by Song on 2018/9/14.
//  Copyright © 2018年 Song. All rights reserved.
//

import HandyJSON
import RxSwift

public extension Observable where Element:Any {
    /// 将JSON数据转成模型对象
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型对象
    func qs_mapModel<T>(type:T.Type) -> Observable<T?> where T: HandyJSON {
        return self.map { (element) -> T? in
            guard let parsedElement = T.deserialize(from: element as? Dictionary) else {
                return nil
            }
            
            return parsedElement
        }
    }
    
    /// 将JSON数据转成模型数组
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型数组
    func qs_mapModels<T>(type:T.Type) -> Observable<[T]?> where T: HandyJSON {
        return self.map { (element) -> [T]? in
            guard let parsedArray = [T].deserialize(from: element as? [Any]) else {
                return nil
            }
            
            return parsedArray as? [T]
        }
    }
}
