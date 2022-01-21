//
//  String+QSEncode.swift
//  QSExtensions
//
//  Created by Song on 2018/11/6.
//  Copyright © 2018 Song. All rights reserved.
//
// 编解码

import Foundation

extension String {
    /// url编码
    public func qs_urlEncode() -> String? {
        // 为了不把url中一些特殊字符也进行转换(以%为例)，需要自己添加到字符集中
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "%")
        let encodeUrlString = addingPercentEncoding(withAllowedCharacters: charSet)
        
        return encodeUrlString
    }
    
    /// url解码
    public func qs_urlDecode() -> String? {
        return removingPercentEncoding
    }
    
    /// base64编码
    public func qs_base64Encode() -> String? {
        let plainData = data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String
    }
    
    /// base64解码
    public func qs_base64Decode() -> String? {
        guard let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0)) else { return nil }
        let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue) as String?
        return decodedString
    }
    
    /// unicode编码
    public func qs_unicodeEncode() -> String? {
        var tempStr = String()
        for v in self.utf16 {
            if v < 128 {
                if let scalar = Unicode.Scalar(v) {
                    tempStr.append(scalar.escaped(asASCII: true))
                }
                continue
            }
            let codeStr = String.init(v, radix: 16, uppercase: false)
            tempStr.append("\\u" + codeStr)
        }
        
        return tempStr.isEmpty ? nil : tempStr
    }
    
    /// unicode解码
    public func qs_unicodeDecode() -> String? {
        let tempStr1 = replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        
        guard let tempData = tempStr3.data(using: String.Encoding.utf8) else { return nil }
        
        var returnStr: String? = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData, options: [.mutableContainers], format: nil) as? String
        } catch {
            print(error)
        }
        return returnStr?.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}
