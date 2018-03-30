//
//  BillRequest.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation


class BillRequest : ModelType {
    var merchantName: String = ""
    var billNo: String = ""
    var amount: String = ""
    var detail: String = ""
    var merchantUserName: String = ""
    var formatAmount: String = ""

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [
            (keyInObject: "merchantName", keyInResource: "name"),
            (keyInObject: "billNo", keyInResource: "bill_no"),
            (keyInObject: "detail", keyInResource: "description"),
            (keyInObject: "merchantUserName", keyInResource: "uname"),
            (keyInObject: "formatAmount", keyInResource: "famount"),
        ]
    }
}
