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
        let url = APIService.getAPIURL(apiName: APIConstants.addPhone.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: ["phone": phone], completionHandler: { (message, data) in
            completionHandler(.success(()))
        }) { (error) in
            completionHandler(.error(error))
        }


    }

    static func verifyPhone(phone: String, code: String, completionHandler: @escaping ((Result<Void>) -> Void)) {
        guard !phone.isEmpty && !code.isEmpty else {
            completionHandler(.error("Verify code can't empty!"))
            return
        }
        let params = ["phone" : phone, "code": code]
        let url = APIService.getAPIURL(apiName: APIConstants.verifyPhone.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters:params, completionHandler: { (message, data) in
            print(String(data: data, encoding: String.Encoding.utf8) ?? "")
            completionHandler(.success(()))
        }) { (error) in
            completionHandler(.error(error))
        }
    }

//    static func getSecretKey(phone: String, pinCode: String, withCHKey: Bool = false, completionHandler: @escaping ((Result<Bool>) -> Void)) {
//        let params = ["phone" : phone, "pincode": pinCode]
//        let url = APIService.getAPIURL(apiName: APIConstants.secretKey.rawValue)
//        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
//            let secretKey = SecretKey(data: data)
//            print(secretKey.secretKey)
//            var hasSecretKey = false
//            if !secretKey.secretKey.isEmpty {//phone and pincode valid
//                hasSecretKey = true
////                AppConfiguration.shared.saveToken(token: secretKey.token)
//            }else {//new phone or wrong pass
//                let result = ResponeResult(data: data)
//                if result.data == "new_phone" {
//
//                }else {
//
//                }
//            }
//            completionHandler(.success(hasSecretKey))
//        }) { (error) in
//            print("error: \(error)")
//            completionHandler(.error(error))
//        }
//    }
    static func login(phone: String, pinCode: String, completionHandler: @escaping ((Result<Bool>) -> Void)) {
        let params = ["phone" : phone, "pincode": pinCode, "login": "1"]
        let url = APIService.getAPIURL(apiName: APIConstants.secretKey.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
            let secretKey = SecretKey(data: data)
//            var hasSecretKey = false
            if !secretKey.secretKey.isEmpty {//phone and pincode valid
//                hasSecretKey = true
                AppConfiguration.shared.saveToken(phone: phone, token: secretKey.token)
                AppConfiguration.shared.account?.pinCode = pinCode
                completionHandler(.success(true))
                return
            }else {//new phone or wrong pass
                let result = ResponeResult(data: data)
                if result.data == "new_phone" {
                    self.registerUser(phone: phone, pinCode: pinCode, completionHandler: { (result) in
                        switch result {
                        case .success(_):
                            AppConfiguration.shared.account?.pinCode = pinCode
                            completionHandler(.success(true))
                        case .error(let error):
                            completionHandler(.error(error))
                        }
                    })
                }else {//wrong pass
                    completionHandler(.error(result.message))
                }
            }
        }) { (error) in
            print("error: \(error)")
            completionHandler(.error(error))
        }
    }

    static func registerUser(phone: String, pinCode: String, completionHandler: @escaping ((Result<Void>) -> Void)) {
        let params = ["phone" : phone, "pincode": pinCode]
        let url = APIService.getAPIURL(apiName: APIConstants.registerUser.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
            let secretKey = SecretKey(data: data)
            print(secretKey.secretKey)
            AppConfiguration.shared.saveToken(phone: phone, token: secretKey.token)
            completionHandler(.success(()))
        }) { (error) in
            print("error: \(error)")
            completionHandler(.error(error))
        }
    }

    // MARK: Merchant
    static func searchMerchant(name: String, completionHandler: @escaping ((Results<Merchant>) -> Void))-> DataRequest? {
        print(name)
        let url = APIService.getAPIURL(apiName: APIConstants.getMerchantsList.rawValue)
        let params = ["searchKey" : name]
        return APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let merchants = [Merchant](data: data)
//            let string = String(data: data, encoding: String.Encoding.utf8)
//            print(string)
            completionHandler(.success(merchants))
        }, errorHandler: { (error) in

        })
//        DispatchQueue.global().async {
//            Thread.sleep(forTimeInterval: 1)
//            DispatchQueue.main.async {
//                var merchants = SamepleData.merchantsList()
//                merchants.append(Merchant(name: name, logo: ""))
//                completionHandler(.success(merchants))
//            }
//        }

    }

    // MARK: Payment
    static func plaidAccounts(publicToken: String, completionHandler: @escaping ((Results<PlaidBankAccount>) -> Void)){
        let url = APIService.getAPIURL(apiName: APIConstants.plaidAccounts.rawValue)
        let params = ["ptoken" : publicToken]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let bankAccount = [PlaidBankAccount](data: data, conversionOptions: ConversionOptions.DefaultDeserialize, forKeyPath: "accounts")
            completionHandler(.success(bankAccount))
        }, errorHandler: { (error) in
            print(error)
        })
//        DispatchQueue.global().async {
//            Thread.sleep(forTimeInterval: 1)
//            DispatchQueue.main.async {
//                let bankAccount = SamepleData.bankAccountsList()
//                completionHandler(.success(bankAccount))
//            }
//        }

    }

    static func getZipCodes(zipCode: String, completionHandler: @escaping (([DataValue]) -> Void)) -> DataRequest? {
        let url = APIService.getAPIURL(apiName: APIConstants.getZipCodes.rawValue)
        return APIService.request(url: url, method: .post, parameters: ["query":zipCode], completionHandler: { (data) in
//            let string = String(data: data, encoding: String.Encoding.utf8)
            let zipCodes = [DataValue](data: data, conversionOptions: ConversionOptions.DefaultDeserialize, forKeyPath: "suggestions")
            completionHandler(zipCodes)
        }) { (error) in
            print("error")
        }
    }

    static func saveSelectedBankAccount(account: BankAccount, completionHandler: @escaping ((Result<Void>) -> Void)) {
        guard let phoneAccount = AppConfiguration.shared.account else {
            completionHandler(.error(""))
            return
        }
        let params = ["phone": phoneAccount.phone, "pincode": phoneAccount.pinCode, "ch" : "1"]
        let url = APIService.getAPIURL(apiName: APIConstants.secretKey.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
            let secretKey = SecretKey(data: data)
//            BankAccountSecurity.shared.saveNewBankAccount(account, secretKey: secretKey.secretKey)
//
//            let serverEncryptedData = BankAccountSecurity.shared.newBankAccountForServerHalf(account, secretKey: secretKey.secretKey, chData: secretKey.ch)
            let serverHalf = BankAccountSecurity.shared.saveBankAccount(account, secretKey: secretKey.secretKey, chData: secretKey.ch)
            let userNames = BankAccountSecurity.shared.storeUserName()
            storeUserNames(names: userNames, completionHandler: nil)
            setHalfC(serverHalf: serverHalf, secretKey: secretKey.secretKey, completionHandler: nil)
            
            completionHandler(.success(()))
        }) { (error) in
            print("error: \(error)")
            completionHandler(.error(error))
        }
    }

    static func storeUserNames(names:[String], completionHandler: ((Result<Void>) -> Void)?){
        do {
            let data = try JSONSerialization.data(withJSONObject: names, options: .prettyPrinted)
            let params = ["data" : data]
            let url = APIService.getAPIURL(apiName: APIConstants.storeUserNames.rawValue)
            _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (_) in
                completionHandler?(.success(()))
            }, errorHandler: { (error) in
                completionHandler?(.error(error))
            })
        }catch{
            completionHandler?(.error(error.localizedDescription))
        }
    }

    static func setHalfC(serverHalf: NSDictionary, secretKey: String, completionHandler: ((Result<Void>) -> Void)?){
        var data = ""
        do{
            let json = try JSONSerialization.data(withJSONObject: serverHalf, options: .prettyPrinted)
            data = String(data: json, encoding: .utf8) ?? ""
        }catch{}

        let params: [String : Any] = ["data" : data, "secret-key" : secretKey]
        let url = APIService.getAPIURL(apiName: APIConstants.setHalfC.rawValue)
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (_) in
            completionHandler?(.success(()))
        }, errorHandler: { (error) in
            completionHandler?(.error(error))
        })

    }
}
