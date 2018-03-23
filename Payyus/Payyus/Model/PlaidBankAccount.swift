//
//  BankAccount.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

enum BankCountSubtype: String{
    case savings = "savings"
    case checking = "checking"
}

class PlaidBankAccount: ModelType {
    var accountId: String = ""
    var name: String = ""
    var bankName: String = ""
    var accountNumber: String = ""
    var balance: Double = 0
    var accountRouting: String = ""
    var subtype: String = ""
    var type: String = ""
    var info: BankAccountInfo? = nil

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "accountId", keyInResource: "accid"),
                (keyInObject: "bankName", keyInResource: "bankname"),
                (keyInObject: "accountNumber", keyInResource: "accnum"),
                (keyInObject: "accountRouting", keyInResource: "accrouting")
        ]
    }
    
    init(accountId: String, name: String, accountNumber: String, balance: Double) {
        self.accountId = accountId
        self.name = name
        self.accountNumber = accountNumber
        self.balance = balance

    }

    required init() {
    }

    

}
