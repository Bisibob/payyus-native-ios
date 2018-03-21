//
//  AppAPIService.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

class AppAPIService {
    // MARK: Verify phone
    static func addPhone(phone: String, completionHandler: @escaping ((Result<Void>) -> Void)){
        guard !phone.isEmpty else {
            completionHandler(.error("Phone number can't empty!"))
            return
        }
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                completionHandler(.success(()))
            }
        }
        let dic = ["phone" : phone]


    }

    static func verifyPhone(phone: String, code: String, completionHandler: @escaping ((Result<Void>) -> Void)) {
        guard !phone.isEmpty && !code.isEmpty else {
            completionHandler(.error("Verify code can't empty!"))
            return
        }
        let dic = ["phone" : phone, "code": code]
        completionHandler(.success(()))
    }

    static func getSecretKey(account: Account, withCHKey: Bool = false, completionHandler: @escaping ((Result<Void>) -> Void)) {
         completionHandler(.success(()))
    }

    // MARK: Merchant
    static func searchMerchant(name: String, completionHandler: @escaping ((Results<Merchant>) -> Void)) {
        print(name)
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                var merchants = SamepleData.merchantsList()
                merchants.append(Merchant(name: name, logo: ""))
                completionHandler(.success(merchants))
            }
        }

    }

    // MARK: Payment
    static func plaidAccounts(publicToken: String, completionHandler: @escaping ((Results<BankAccount>) -> Void)){
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                let bankAccount = SamepleData.bankAccountsList()
                completionHandler(.success(bankAccount))
            }
        }
    }

    static func getZipCodes(zipCode: String, completionHandler: @escaping (([DataValue]) -> Void)) -> DataRequest? {
        return APIService.request(url: AppConfiguration.shared.baseURL()+"getZipCodes", method: .post, parameters: ["query":zipCode], completionHandler: { (data) in
//            let string = String(data: data, encoding: String.Encoding.utf8)
            let zipCodes = [DataValue](data: data, conversionOptions: ConversionOptions.DefaultDeserialize, forKeyPath: "suggestions")
            completionHandler(zipCodes)
        }) { (error) in
            print("error")
        }
    }
}
