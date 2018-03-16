//
//  Merchant.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class Merchant: ModelType {
    var name: String = ""
    var logo: String = ""

    init(name: String, logo: String) {
        self.name = name
        self.logo = logo
    }

    required init() {

    }
}
