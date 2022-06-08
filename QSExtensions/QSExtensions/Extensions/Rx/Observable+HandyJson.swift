//
//  Observable+HandyJson.swift
//  QSExtensions
//
//  Created by Mac on 2022/5/18.
//  Copyright © 2022 Song. All rights reserved.
//

import HandyJSON
import RxSwift

/// map解析错误
enum QSObjectMapperError: Error {
    case parsingError
}

public extension Observable where Element: Any {
    /// 将JSON数据转成模型对象
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型对象
    func qs_mapObject<T>(type:T.Type) -> Single<T> where T: HandyJSON {
        return self.map { (element) -> T in
            guard let parsedElement = T.deserialize(from: element as? Dictionary) else {
                throw QSObjectMapperError.parsingError
            }
            
            return parsedElement
        }.asSingle()
    }
    
    /// 将JSON数据转成模型数组
    ///
    /// - Parameter type: 模型类
    /// - Returns: 模型数组
    func qs_mapArray<T>(type:T.Type) -> Single<[T]> where T: HandyJSON {
        return self.map { (element) -> [T] in
            guard let parsedArray = [T].deserialize(from: element as? [Any]) else {
                throw QSObjectMapperError.parsingError
            }
            
            guard let resultArray = parsedArray as? [T] else {
                throw QSObjectMapperError.parsingError
            }
            
            return resultArray
        }.asSingle()
    }
}
