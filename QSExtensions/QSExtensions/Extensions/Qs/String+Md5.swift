//
//  String+Md5.swift
//  QSExtensions
//
//  Created by Song on 2018/3/1.
//  Copyright © 2018年 Song. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {
    /// MD5加密，大小写均可
    ///
    /// - Parameter isUpper: 是否大写
    func qs_md5(isUpper: Bool = false) -> String? {
        guard let str = cString(using: String.Encoding.utf8) else { return nil }
        
        let strLen = CC_LONG(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            if isUpper {
                hash.appendFormat("%02X", result[i])
            } else {
                hash.appendFormat("%02x", result[i])
            }
        }
        
        free(result)
        
        return String(format: hash as String)
    }
    
    /// 自定义MD5加密算法
    ///
    /// - Parameter hexDigits: 自定义的16进制数
    func qs_customMd5(_ hexDigits: [Character] = ["0", "1", "2", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "M", "n", "i", "G", "R"]) -> String? {
        guard let cString = cString(using: String.Encoding.utf8) else { return nil }
        
        let strLen = CC_LONG(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(cString, strLen, result)
        
        // 用于存放字符串
        var strArray = Array.init(repeating: "", count: digestLen * 2)
        
        var k: Int = 0
        for i in 0 ..< digestLen {
            let byte = result[i]
            let byte1 = result[i]
            
            strArray[k] = String.init(hexDigits[Int((byte >> 4) & 0xf)])
            k += 1
            strArray[k] = String.init(hexDigits[Int(byte1 & 0xf)])
            k += 1
        }
        
        var encryptedString = String.init()
        for char in strArray {
            encryptedString.append(char)
        }
        
        return encryptedString
    }
}
