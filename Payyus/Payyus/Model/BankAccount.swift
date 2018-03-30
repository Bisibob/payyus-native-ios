//
//  BankAccount.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class BankAccount: ModelType {
    var type: String = ""
    var bankName: String = ""
    var bankRoutingNumber: String = ""
    var bankAccountNumber: String = ""
    var yourPhoneNumber: String = ""
    var bankAccountName: String = ""
    var yourAddress: String = ""
    var zipcode: String = ""
    var acctType: Int = 0
    var stripeToken: String = ""
    required init() {

    }

    init(plaidAccount account: PlaidBankAccount){
        super.init()
        type = "bank"
        bankName = account.bankName
        bankRoutingNumber = account.accountRouting
        bankAccountNumber = account.accountNumber
        acctType = account.subtype == "savings" ? 1 : 0
        self.updateInfo(info: account.info)
    }

    func updateInfo(info: BankAccountInfo?) {
        yourPhoneNumber = info?.phoneNumber ?? ""
        bankAccountName = info?.holderName ?? ""
        yourAddress = info?.address ?? ""
        zipcode = info?.zipcode ?? ""
    }

    func localPart() -> BankAccount {
        let account = BankAccount()
        account.bankAccountNumber = bankAccountNumber.prefixAHalf()
        account.bankName = bankName.prefixAHalf()
        account.bankRoutingNumber = bankRoutingNumber.prefixAHalf()
        account.yourPhoneNumber = yourPhoneNumber.prefixAHalf()
        account.zipcode = zipcode.prefixAHalf()
        account.stripeToken = stripeToken.prefixAHalf()
        return account
    }

    func serverPart() -> BankAccount {
        let account = BankAccount()
        account.bankAccountNumber = bankAccountNumber.suffixAHalf()
        account.bankName = bankName.suffixAHalf()
        account.bankRoutingNumber = bankRoutingNumber.suffixAHalf()
        account.yourPhoneNumber = yourPhoneNumber.suffixAHalf()
        account.zipcode = zipcode.suffixAHalf()
        account.stripeToken = stripeToken.suffixAHalf()
        return account
    }

}
