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

    static func getMerchantInfo(merchantId: String, completionHandler: @escaping ((Result<MerchantMoreInfo>) -> Void)) {
        let url = APIService.getAPIURL(apiName: APIConstants.getMerchantInfo.rawValue)
        let params = ["merchantId" : merchantId]
//        let params = ["token": "ec1655a5c2adb291c7182b058299031a", "merchantId" : "90"]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let merchants = MerchantMoreInfo(data: data)
            completionHandler(.success(merchants))
        }, errorHandler: { (error) in
        })
    }

    // MARK: Setup bank account
    static func plaidAccounts(publicToken: String, completionHandler: @escaping ((Result<PlaidAccountsRespone>) -> Void)){
        let url = APIService.getAPIURL(apiName: APIConstants.plaidAccounts.rawValue)
        let params = ["ptoken" : publicToken]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let respone = PlaidAccountsRespone(data: data)
            completionHandler(.success(respone))
        }, errorHandler: { (error) in
            print(error)
        })
    }

    static func getStripeToken(accessToken: String, accountId: String, completionHandler: @escaping ((Result<String>) -> Void)){
        let url = APIService.getAPIURL(apiName: APIConstants.getStripeToken.rawValue)
        let params = ["access_token" : accessToken, "account_id": accountId]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { ( data) in
            let stripe = StripeTokenRespone(data: data)
            completionHandler(.success(stripe.token))
        }, errorHandler: { (error) in
            completionHandler(.error(error))
        })
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
            //TODO: move to login
            return
        }
        let params = ["phone": phoneAccount.phone, "pincode": phoneAccount.pinCode, "ch" : "1"]
        let url = APIService.getAPIURL(apiName: APIConstants.secretKey.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
            let secretKey = SecretKey(data: data)
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

    //MARK: Payment
    static func getReloadLimit(merchantId: String, completionHandler: @escaping (Result<ReloadLimit>) -> Void) {
        let url = APIService.getAPIURL(apiName: APIConstants.getReloadLimit.rawValue)
        let params: [String: Any] = ["availableBalance": 0, "m" : merchantId]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let limit = ReloadLimit(data: data)
            completionHandler(.success(limit))
        }, errorHandler: { (error) in
            completionHandler(.error(error))
        })
    }
    static func getSecretKey(phone: String, pincode: String, completionHandler: @escaping (Result<String>) ->Void) {
        let params = ["phone": phone, "pincode": pincode]
        let url = APIService.getAPIURL(apiName: APIConstants.secretKey.rawValue)
        _ = APIService.requestCheckErrorData(url: url, method: .post, parameters: params, completionHandler: { (message, data) in
            let secretKey = SecretKey(data: data)
            completionHandler(.success(secretKey.secretKey))
        }) { (error) in
            print("error: \(error)")
            completionHandler(.error(error))
        }

    }

    //MARK: Bill Requests
    static func getBills(completionHandler: @escaping (Results<BillRequest>) -> Void){
        let url = APIService.getAPIURL(apiName: APIConstants.getBills.rawValue)
        _ = APIService.authRequest(url: url, method: .post, parameters: nil, completionHandler: { (data) in
            let bills = [BillRequest](data: data, conversionOptions: ConversionOptions.DefaultDeserialize, forKeyPath: "bills")
            completionHandler(.success(bills))
        }, errorHandler: { (error) in
            completionHandler(.error(error))
        })
    }

    static func rejectBill(billNumber: String, completionHandler: @escaping (Result<String>) -> Void){
        let url = APIService.getAPIURL(apiName: APIConstants.rejectBill.rawValue)
        let params = ["billNo": billNumber]
        _ = APIService.authRequest(url: url, method: .post, parameters: params, completionHandler: { (data) in
            let data = ResponeResult(data: data)
            if data.error.isEmpty && data.status == 1 {
                completionHandler(.success(billNumber))
            }else {
                completionHandler(.error(data.error))
            }
        }, errorHandler: { (error) in
            completionHandler(.error(error))
        })
    }

    
}
