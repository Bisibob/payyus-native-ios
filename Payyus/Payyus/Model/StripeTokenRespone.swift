//
//  StripeTokenRespone.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/29/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class StripeTokenRespone: ModelType {
    var token: String = ""
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "token", keyInResource: "stripe_bank_account_token")]
    }
}
