//
//  HalfCBankAccount.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class HalfCBankAccount: ModelType, HalfC {
    var type: String? = "bank"

    var key: String? = ""

    var version: Int? = 0

    var bankName: String = ""
    var bankRoutingNumber: String = ""
    var bankAccountNumber: String = ""
    var yourPhoneNumber: String = ""
    var zipcode: String = ""

    init(withBankAccount account: PlaidBankAccount){
        bankName = account.bankName
        bankRoutingNumber = account.accountRouting
        bankAccountNumber = account.accountNumber
        yourPhoneNumber = account.info?.phoneNumber ?? ""
        zipcode = account.info?.zipcode ?? ""
    }

    required init() {
    }

    
}
