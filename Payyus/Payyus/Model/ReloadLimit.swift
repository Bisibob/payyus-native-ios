//
//  ReloadLimit.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class ReloadLimit: ModelType {
    var noLimit: Double = 0
    var limit: Double = 0
    var formattedLimit: String = ""
    var limitText: String = ""

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "noLimit", keyInResource: "no_limit"),
                (keyInObject: "formattedLimit", keyInResource: "formated_limit"),
                (keyInObject: "limitText", keyInResource: "limit_text"),
        ]
    }

}
