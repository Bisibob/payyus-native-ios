//
//  UIImage+Extension.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


extension UIImage {
    public convenience init(base64String: String) {
        let data = base64String.components(separatedBy: "base64,")
        if let decodedData = Data(base64Encoded: data[1], options: .ignoreUnknownCharacters) {
            self.init(data: decodedData)!
            return
        }
        self.init()
    }
}
