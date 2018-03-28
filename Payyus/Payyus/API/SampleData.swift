//
//  SampleData.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class SamepleData {
    static func merchantsList() -> [Merchant] {
        return [
//            Merchant(name: "Kelly Koenecke", logo: "samplelogo1"),
//            Merchant(name: "The Burger Bar", logo: "samplelogo2"),
//            Merchant(name: "Mirrison's", logo: "samplelogo3")
        ]
    }

    static func bankAccountsList() -> [PlaidBankAccount] {
        return [
            PlaidBankAccount(accountId: "1", name: "David", accountNumber: "233322233222", balance: 100 ),
            PlaidBankAccount(accountId: "2", name: "David 1", accountNumber: "233322233233", balance: 500 ),
            PlaidBankAccount(accountId: "3", name: "David 2", accountNumber: "233322233288", balance: 12200 )
        ]
    }
    static func advertsList() -> [Advert] {
        return [
//            Advert(image: "dish3", title: "Join Sammy’s\n Get $5 FREE to Start!"),
//            Advert(image: "dish1", title: "Join The Hake\n Get $5 FREE to Start!"),
//            Advert(image: "dish2", title: "Join The Beer\n Get $10 FREE to Start!"),

        ]
    }
}
