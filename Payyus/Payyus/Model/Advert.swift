//
//  Advert.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Advert: ModelType {
    var merchantName: String = ""
    var params: AdvertParam?
    var notification: String = ""
//    var image: String = ""
//    var title: String = ""
//    init(image: String, title: String) {
//        self.image = image
//        self.title = title
//    }

    required init() {
        
    }
    class AdvertParam: ModelType {
        var isAdvert: Int = 1
        var type: String = ""
        var title: String = ""
        var merchant: String = ""
        var message: String = ""
        var image: String = ""

        override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
            return [(keyInObject: "advertId", keyInResource: "is_adv")]
        }
    }
}
