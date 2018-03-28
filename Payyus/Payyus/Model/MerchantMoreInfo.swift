//
//  MerchantMoreInfo.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class MerchantMoreInfo : ModelType {
    var balance: String = ""
    var advertisements: [Advert] = []
    var info: Merchant?
}
