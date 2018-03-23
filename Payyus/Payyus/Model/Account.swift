//
//  Account.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class Account: ModelType {
    var phone: String = ""
//    var pinCode: String = ""
    var token: String = ""
    var secretKey: String = ""
    var mainMerchantId: String = ""
    var isSetupBank: Bool = false
}
