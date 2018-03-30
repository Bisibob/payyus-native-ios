//
//  Card.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class HalfCCard: ModelType, HalfC {
    var type: String? = "card"
    var key: String?
    var version: Int?

    var cardNumber: String
    var cardName: String
    var CVV2: String
    var expMM: String
    var expYY: String
    var shopperFirstName: String?
    var shopperLastName: String?
    var address1: String?
    var address2: String?
    var city: String?
    var zipcode: String?
    var state: String?
    var phone: String?

    required convenience init() {
        self.init(cardName: "", cardNumber: "", CVV2: "", expMM: "", expYY: "")
    }

    init(cardName: String, cardNumber: String, CVV2: String, expMM: String, expYY: String) {
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.CVV2 = CVV2
        self.expMM = expMM
        self.expYY = expYY
    }

    func localPart() -> HalfCCard {
        let card = HalfCCard()
        let ccLength = cardNumber.count / 2
        card.cardNumber = String(cardNumber.prefix(ccLength))
        card.CVV2 = String(CVV2.prefix(1))
        card.expMM = String(expMM.prefix(1))
        card.expYY = String(expYY.prefix(1))
        return card
    }
    func serverPart() -> HalfCCard {
        let card = HalfCCard()
        let ccLength = cardNumber.count / 2
        card.cardNumber = String(cardNumber.suffix(ccLength))
        card.CVV2 = String(CVV2.suffix(CVV2.count - 1 ))
        card.expMM = String(expMM.suffix(1))
        card.expYY = String(expYY.suffix(1))
        return card
    }
}
