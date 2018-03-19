//
//  BankAccountSecurityHelper.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class BankAccountSecurityHelper {
    static func splitC(suffix: String, secretKey: String) {
        let suffix = 0;
        var tmp1 = Dictionary<String, Any>()
        var tmp2 = Dictionary<String, Any>()
        if LocalStorage.shared.aid == nil {
            LocalStorage.shared.aid = Date().timeIntervalSince1970
        }
        var plainText: [String: HalfC] = Dictionary<String, HalfC>()
        for key in plainText.keys {
            if let tmp = plainText[key] {
                var type = "card"
                if let tmpType = tmp.type {
                    type = tmpType
                }

//                if tmp.key == nil {
//                    tmp.key =
//                }

            }
        }
    }
}
