//
//  PlaidAccountsRespone.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/29/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class PlaidAccountsRespone: ModelType {
    var accounts: [PlaidBankAccount] = []
    var accessToken: String = ""
}
