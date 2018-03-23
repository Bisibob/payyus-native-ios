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
    var cardList: [String:BankAccount]?
    var chLocalEncryptedData: Data?

    private init(){
        if let fileURL = fileUrl() {
            do {
                chLocalEncryptedData = try Data(contentsOf: fileURL, options: .mappedRead)
            }
            catch {/* error handling here */}
        }
    }

    func saveData() {
        if let fileURL = fileUrl() {
            do {
                try chLocalEncryptedData?.write(to: fileURL)
            }
            catch {/* error handling here */}
        }
    }

    func saveNewBankAccount(_ bankAccount: BankAccount, secretKey: String, chData: Data?) {
        // Decryption
        do {
            var localCardHalfList: [BankAccount] = []
            if let chLocalEncryptedData = chLocalEncryptedData {
                 let localPlainText = try RNCryptor.decrypt(data: chLocalEncryptedData, withPassword: secretKey)
//                localCardHalfList = [BankAccount](json: localPlainText)

            }

//            let serverPlainText = try RNCryptor.decrypt(data: chData, withPassword: secretKey)
//            cardList.removeValue(forKey: "bankAccount")

            // ...
        } catch {
            print(error)
        }
    }

    func decryptData(secretKey: String, chData: String) {

    }

    func splitC(suffix: String, secretKey: String) {
        let suffix = 0;
        var tmp1 = Dictionary<String, Any>()
        var tmp2 = Dictionary<String, Any>()
        if LocalStorage.shared.aid == nil {
            LocalStorage.shared.aid = Date().timeIntervalSince1970
        }
        var plainText: [String: HalfC] = Dictionary<String, HalfC>()
        for key in plainText.keys {
            if let tmp = plainText[key] {
                var type = "card"
                if let tmpType = tmp.type {
                    type = tmpType
                }

                if tmp.key == nil {
//                    do {
//                        let encrypt = try AES(key: arc4random(), iv: secretKey).encrypt(<#T##bytes: ArraySlice<UInt8>##ArraySlice<UInt8>#>)
//
//                    }catch(){
//
//                    }

                }

            }
        }
    }
    private func fileUrl() -> URL?{
        let file = "payyus.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            return fileURL
        }
        return nil
    }
}
