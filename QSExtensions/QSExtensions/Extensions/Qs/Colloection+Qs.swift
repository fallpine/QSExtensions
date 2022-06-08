//
//  Colloection+Qs.swift
//  QSExtensions
//
//  Created by Mac on 2022/6/8.
//  Copyright © 2022 Song. All rights reserved.
//

import Foundation

public extension Collection {
    /// 集合转json字符串
    func toJsonString(prettyPrint: Bool = false) -> String? {
        if JSONSerialization.isValidJSONObject(self) {
            do {
                let jsonData: Data
                if prettyPrint {
                    jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
                } else {
                    jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
                }
                return String(data: jsonData, encoding: .utf8)
            } catch let error {
                print(error)
            }
        } else {
            print("is not a valid JSON Object")
        }
        return nil
    }
}
