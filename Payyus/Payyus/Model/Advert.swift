//
//  Advert.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Advert: ModelType {
    var image: String = ""
    var title: String = ""
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }

    required init() {
        
    }
}
