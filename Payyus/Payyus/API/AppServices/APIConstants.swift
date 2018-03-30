//
//  APIConstants.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/21/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

enum APIConstants : String{
    case addPhone = "v3/addPhone"
    case verifyPhone = "v3/verifyPhone"
    case secretKey = "v3/getSecretKey"
    case registerUser = "v3/registerUser"
    case getMerchantsList = "v3/getMerchantsList"
    case getMerchantInfo = "v3/getMerchantInfo"
    case plaidAccounts = "plaidAccounts"
    case getZipCodes = "getZipCodes"
    case storeUserNames = "v3/storeUserNames"
    case setHalfC = "v3/setHalfC"
    case getReloadLimit = "v3/getReloadLimit"
    case getStripeToken = "v3/getStripeToken"
    case getBills = "getBills"
    case rejectBill = "rejectBill"
    case getBill = "v3/getBill"
}
