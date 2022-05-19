//
//  Observable+HandyJson.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/18.
//  Copyright © 2022 Song. All rights reserved.
//

import HandyJSON
import RxSwift

public extension Observable where Element: Any {
    /// 将JSON数据转成模型对象
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型对象
    func qs_mapObject<T>(type:T.Type) -> Observable<T?> where T: HandyJSON {
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
    func qs_mapArray<T>(type:T.Type) -> Observable<[T]?> where T: HandyJSON {
        return self.map { (element) -> [T]? in
            guard let parsedArray = [T].deserialize(from: element as? [Any]) else {
                return nil
            }
            
            return parsedArray as? [T]
        }
    }
}
