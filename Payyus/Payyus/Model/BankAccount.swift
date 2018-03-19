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
    case debit = "debit"
}

class BankAccount: ModelType {
    var accountId: String = ""
    var name: String = ""
    var bankName: String = ""
    var accountNumber: String = ""
    var balance: Double = 0
    var routingNumber: String = ""
    var subtype: BankCountSubtype = .savings
    var info: BankAccountInfo? = nil


    init(accountId: String, name: String, accountNumber: String, balance: Double) {
        self.accountId = accountId
        self.name = name
        self.accountNumber = accountNumber
        self.balance = balance

    }

    required init() {
    }

    

}
