//
//  LocalStorage.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class LocalStorage: NSObject {
    static let shared = LocalStorage()
    var aid: TimeInterval?
    var token: String?
    var gcm_regid: String?
    var email: String?
    var cardList: [String] = []

    private override init() {

    }

    func saveFieldsSetupToLocalStorage(secretKey: String) {
//        if AppConfiguration.shared.bankData. {
//
//        }
    }
}
