//
//  BankAccountSecurityHelper.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import RNCryptor

class BankAccountSecurity {
    private enum InformationKey: String {
        case bankAccount = "bankAccount"
        case card = "card"
        case shopperBankInfo = "shopperBankInfo"
        case aid = "aid"
//        case stripeToken = "stripeToken"
    }
    static let shared = BankAccountSecurity()
//    var cardList: [String: AnyObject]?
    private var chLocalBankAccountData: Data?
    private var chLocalEncryptedDictionary: [String: Any]?
    private var currentBankAccount: BankAccount?

    private var _shopperBankInfo: ShopperBankInfo?{
        didSet {
            chLocalEncryptedDictionary?[InformationKey.shopperBankInfo.rawValue] = _shopperBankInfo?.toDictionary()
        }
    }
    var shopperBankInfo: ShopperBankInfo?
    var aid: String?
//    var stripeToken: String? {
//        didSet {
//            chLocalEncryptedDictionary?[InformationKey.stripeToken.rawValue] = stripeToken
//            saveData()
//        }
//    }
    private init(){
        if let fileURL = fileUrl() {
            chLocalEncryptedDictionary = NSDictionary(contentsOf: fileURL) as? [String: Any]
//            chLocalEncryptedDictionary?[InformationKey.aid.rawValue] = "1522305032229"
            aid = chLocalEncryptedDictionary?[InformationKey.aid.rawValue] as? String
            if let bankInfo = chLocalEncryptedDictionary?[InformationKey.shopperBankInfo.rawValue] as? NSDictionary{
                shopperBankInfo = ShopperBankInfo(dictionary: bankInfo)
            }
//            saveData()
        }
    }
    
    func getPaymentBankAccount(secretKey: String) -> BankAccount? {
        if let dic = chLocalEncryptedDictionary, let data = dic[InformationKey.bankAccount.rawValue] as? Data {
            do {
                let decryptData = try RNCryptor.decrypt(data: data, withPassword: secretKey)
                return BankAccount(data: decryptData)
            }catch {

            }
        }
        return nil
    }

    func saveData() {
        if let fileURL = fileUrl() {
            if let dic = chLocalEncryptedDictionary as NSDictionary?{
                dic.write(to: fileURL, atomically: true)
            }
        }
    }
    func saveBankAccount(_ bankAccount: BankAccount, secretKey: String, chData: String) -> NSDictionary {
        if aid == nil {
            aid = String(format: "%.f",Date().timeIntervalSince1970)
        }
        if chLocalEncryptedDictionary == nil {
            chLocalEncryptedDictionary = [String: Data]()
        }
        //save local part
        let localHalf = bankAccount.localPart()
        let data = localHalf.toJsonData()
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: secretKey)
        chLocalEncryptedDictionary?[InformationKey.bankAccount.rawValue] = encryptedData
        chLocalEncryptedDictionary?[InformationKey.aid.rawValue] = aid
        saveData()
        currentBankAccount = bankAccount
//        let serverHalf = NSDictionary()
//        do {
//            if !chData.isEmpty {
//                if let data = Data(base64Encoded: chData){
//                    let serverPlainText = try RNCryptor.decrypt(data: data, withPassword: secretKey)
//                    if let dic = try JSONSerialization.jsonObject(with: serverPlainText, options: .mutableContainers) as? NSDictionary{
//                        serverHalf = dic
//                    }
//                }
//            }
//        }catch {
//
//        }
        let serverHalf = ["\(aid)" :[InformationKey.bankAccount.rawValue: bankAccount.serverPart().toDictionary()]]
        return serverHalf as NSDictionary
    }

    func storeUserName() -> [String]{
        guard let currentBankAccount = currentBankAccount else {
            return []
        }
        return [currentBankAccount.bankAccountName]
    }

    private func fileUrl() -> URL?{
        let file = "payyus.plist"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            return fileURL
        }
        return nil
    }
}
