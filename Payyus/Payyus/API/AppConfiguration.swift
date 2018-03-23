//
//  AppConfiguration.swift
//  MVVMTemplate
//
//  Created by Thuỳ Nguyễn on 2/7/18.
//  Copyright © 2018 NUS Technology. All rights reserved.
//

import Foundation
class AppConfiguration: NSObject {

    static let shared = AppConfiguration()
    var bankData: PlaidBankAccount?
    var phoneNumber: String?
    var pincode: String?
    var account: Account?
    var lastMerchant: Merchant?
    

    private var _baseURL: String = ""



    private override init() {
        super.init()
        loadConfig()
        if let userAccount = UserDefaults.standard.object(forKey: "UserAccount") as? NSDictionary {
            account = Account(dictionary: userAccount)
        }
//        if let fileURL = fileUrl() {
//            do {
//                if let string = NSDictionary(contentsOf: fileURL){
//                    lastMerchant = Merchant(dictionary: string)
//                }
//            }
//            catch {/* error handling here */}
//        }

    }

    private func fileUrl() -> URL?{
        let file = "lastMerchant.plist"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            return fileURL
        }
        return nil
    }
    func saveData() {
        UserDefaults.standard.set(account?.toDictionary(), forKey: "UserAccount")
//        if let fileURL = fileUrl() {
//            do {
//                lastMerchant?.toDictionary().write(to: fileURL, atomically: true)
//            }
//            catch {/* error handling here */}
//        }
//        UserDefaults.standard.set(lastMerchant?.toDictionary(), forKey: "LastMerchant")
    }

    func baseURL() -> String {
        return _baseURL
    }

    func saveToken(phone: String, token: String) {
        if !token.isEmpty {
            if account == nil {
                account = Account()
            }
            account?.token = token
            account?.phone = phone
        }
    }

    //MARK: Load config from file
    private func loadConfig() {
        let enviromentName = buildEnviromentName()
        if let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"), let config = NSDictionary(contentsOfFile: path), let configData = config[enviromentName] as? Dictionary<String, Any>{
            _baseURL = configData["apiBaseURL"] as! String
        }
    }

    //MARK: Define enviroment
    private enum Environment: String {
        case debug = "Default"
        case staging = "Staging"
        case release = "Release"
    }

    private func buildEnviromentName() -> String {
        #if DEBUG
            return Environment.debug.rawValue
        #elseif RELEASE
            return Environment.release.rawValue
        #else
            return Environment.staging.rawValue
        #endif
    }

}

