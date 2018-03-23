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
    var bankData: BankAccount?
    var phoneNumber: String?
    var pincode: String?
    var account: Account?
    

    private var _baseURL: String = ""



    private override init() {
        super.init()
        loadConfig()
        if let userAccount = UserDefaults.standard.object(forKey: "UserAccount") as? NSDictionary {
            account = Account(dictionary: userAccount)
        }
    }

    func saveData() {
        UserDefaults.standard.set(account?.toDictionary(), forKey: "UserAccount")

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

