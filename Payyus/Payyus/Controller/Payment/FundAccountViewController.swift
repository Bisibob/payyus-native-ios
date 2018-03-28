//
//  FundAccountViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FundAccountViewController: BaseViewController {

    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCustom: UIButton!
    @IBOutlet weak var tfAmount: UITextField!
    private var currentAmount: Double = 100
    private weak var currentAmountButton: UIButton?

    var merchant: Merchant?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        btnConfirm.addCorner()
        let button: UIButton = view.viewWithTag(2) as! UIButton
        button.isSelected = true
        highlightButton(button)
        currentAmountButton = button
        tfAmount.isHidden = true
        
    }

    @IBAction func onCustomAmount(_ sender: UIButton) {
        if let currentAmountButton = currentAmountButton {
            currentAmountButton.isSelected = sender.isSelected
            highlightButton(currentAmountButton)
            setAmountFromButton(currentAmountButton)
        }
        tfAmount.isHidden = sender.isSelected
        sender.isSelected = !sender.isSelected
    }

    @IBAction func onSelectAmount(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        highlightButton(sender)
        setAmountFromButton(sender)
        btnCustom.isSelected = false
        highlightButton(btnCustom)
        tfAmount.isHidden = true
        if let currentAmountButton = currentAmountButton {
            currentAmountButton.isSelected = false
            highlightButton(currentAmountButton)
        }
        currentAmountButton = sender
    }

    @IBAction func onLogoTapped(_ sender: UIButton) {
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        if btnCustom.isSelected {
            currentAmount = Double(tfAmount.text!) ?? 100
        }
        let confirmVC = UIStoryboard.Main.confirmFundingViewController() as! ConfirmFundingViewController
        confirmVC.amount = currentAmount
        confirmVC.merchant = merchant
        navigationController?.pushViewController(confirmVC, animated: true)

    }
    
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func highlightButton(_ button: UIButton){
        if button.isSelected {
            button.backgroundColor = UIColor(hex: "2178FD")
            button.addCorner()
        }else {
            button.backgroundColor = UIColor.clear
        }
    }

    private func setAmountFromButton(_ button: UIButton){
        if button.isSelected {
            if let subString = button.titleLabel?.text?.suffix(from: String.Index(encodedOffset: 1)) {
                let string: String = String(subString)
                if let amount = Double(string) {
                    currentAmount = amount
                }
            }

        }
    }
}
