//
//  Merchant.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
class Merchant: ModelType {
    var id: String = ""
    var merchant: String = ""
    var image: String = ""
    var paymentType: String = ""
    var backgroundColor: String = ""
    var foreColor: String = ""

    let logo: UIImage? = {
//        let data = self.image.
        return UIImage()
    }()
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "paymentType", keyInResource: "payment_type"),
                (keyInObject: "backgroundColor", keyInResource: "background_color"),
                (keyInObject: "foreColor", keyInResource: "fore_color")
        ]
    }

//    init(name: String, logo: String) {
//        self.name = name
//        self.logo = logo
//    }

    required init() {

    }


}
