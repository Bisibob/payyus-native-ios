//
//  ConfirmFundingViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ConfirmFundingViewController: BaseViewController {

    @IBOutlet weak var lbMerchantName: UILabel!

    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var tfPincode: UITextField!
    @IBOutlet weak var lbAmountMessage: UILabel!
    @IBOutlet weak var lbMerchantMessage: UILabel!

    var amount: Double = 100
    var merchant: Merchant?
    var socket: SocketService?
    var secretKey: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = BankAccountSecurity.shared
        setupView()
        showMenu()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket?.disconnect()
    }

    private func setupView() {
        if let merchant = merchant {
            lbMerchantName.text = merchant.merchant
            lbMerchantMessage.text = "to your account with \(merchant.merchant)"
        }
        let amountString = String(format: "$%.2f", amount)
        lbAmount.text = amountString
        lbAmountMessage.text = "You are about to load \(amountString)"
        tfPincode.addEyeButton()
    }

    @IBAction func onForgotPin(_ sender: Any) {
    }

    @IBAction func onConfirm(_ sender: Any) {
        confirmFunding()
    }

    
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func confirmFunding() {
        guard let phone = AppConfiguration.shared.account?.phone, let pincode = tfPincode.text else {
            return
        }
        AppAPIService.getSecretKey(phone: phone, pincode: pincode) {[weak self] (result) in
            guard let strongSelf = self else{
                return
            }
            switch result {
            case .success(let secretKey):
                strongSelf.secretKey = secretKey
                strongSelf.setupSocket()
            case .error(let error):
                strongSelf.showError(error)
            }
        }
    }

    private func setupSocket(){
        socket = SocketService()
        let params = prepareParamsForPayment()
        socket?.onConnected = { (socket) in
            socket.shopperReloadConfirm(params: params)
        }
    }
    private func prepareParamsForPayment() -> NSDictionary {
        var params = NSDictionary()
        if let bankAccount = BankAccountSecurity.shared.getPaymentBankAccount(secretKey: secretKey)
        {
            params = bankAccount.toDictionary()
        }
        if let account = AppConfiguration.shared.account {
            params.setValue(account.phone, forKey: "shopper-phone")
            params.setValue(secretKey, forKey: "secret-key")
            params.setValue(1, forKey: "is-reload")
            params.setValue(merchant?.userName, forKey: "merchant-selected")
            params.setValue(BankAccountSecurity.shared.aid, forKey: "aid")
            params.setValue(amount, forKey: "reload-amount")
        }
        params.setValue("bankAccount", forKey: "card-name")
        params.setValue(1, forKey: "isbank")
        return params
    }
}


