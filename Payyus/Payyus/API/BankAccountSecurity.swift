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
    static let shared = BankAccountSecurity()
//    var cardList: [String: AnyObject]?
    var chLocalBankAccountData: Data?
    var chLocalEncryptedDictionary: [String: Data]?
    var currentBankAccount: BankAccount?

    private init(){
        if let fileURL = fileUrl() {
            chLocalEncryptedDictionary = NSDictionary(contentsOf: fileURL) as? [String: Data]

        }
    }

    func saveData() {
        if let fileURL = fileUrl() {
            if let dic = chLocalEncryptedDictionary as NSDictionary?{
                dic.write(to: fileURL, atomically: true)
            }
        }
    }
    func saveBankAccount(_ bankAccount: BankAccount, secretKey: String, chData: String) -> NSDictionary {
        let currentTime = Date().timeIntervalSince1970
        if chLocalEncryptedDictionary == nil {
            chLocalEncryptedDictionary = [String: Data]()
        }
        //save local part
        let localHalf = bankAccount.localPart()
        let data = localHalf.toJsonData()
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: secretKey)
        chLocalEncryptedDictionary?["bankAccount"] = encryptedData
        saveData()
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
        let serverHalf = ["\(currentTime)" :["bankAccount": bankAccount.serverPart().toDictionary()]]
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
