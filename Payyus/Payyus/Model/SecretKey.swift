//
//  SecretKey.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/21/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class SecretKey: ModelType {
    var secretKey: String = ""
    var token: String = ""
    var ch: String = ""

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "secretKey", keyInResource: "secret-key")]
    }
}
