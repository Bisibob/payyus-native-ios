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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    }

    
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }


}
