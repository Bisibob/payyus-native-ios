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
    @IBOutlet weak var lbMessage: UILabel!
    
    private var currentAmount: Double = 100
    private weak var currentAmountButton: UIButton?
    private var limit: ReloadLimit?
    var merchant: Merchant?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showMenu()
        loadData()
    }

    private func setupView() {
        btnConfirm.addCorner()
//        selectAmountWithTag(100)
        tfAmount.isHidden = true
        lbMessage.isHidden = true
        
    }

    private func loadData() {
        guard let merchant = merchant else {
            return
        }
        showLoading(alpha: 1)
        AppAPIService.getReloadLimit(merchantId: merchant.id) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hiddenLoading()
            switch result {
            case .success(let limit):
                strongSelf.limit = limit
                strongSelf.showData()
            case .error(let error):
                print(error)
            }
        }
    }

    private func showData(){
        guard  let limit = limit else {
            return
        }
        if limit.noLimit == 0 {
            let limits = [25, 50, 100, 250]
            for i in limits {
                let button: UIButton = view.viewWithTag(i) as! UIButton
                if limit.limit >= Double(i) {
                    button.isEnabled = true
                    selectAmountWithTag(i)
                }else {
                    button.isEnabled = false
                }
            }
        }
    }

    private func selectAmountWithTag(_ tag: Int){
        let button: UIButton = view.viewWithTag(tag) as! UIButton
       selectedAmount(button)
    }
    private func selectedAmount(_ sender: UIButton){
        if let currentAmountButton = currentAmountButton {
            currentAmountButton.isSelected = false
            highlightButton(currentAmountButton)
        }
        sender.isSelected = !sender.isSelected
        highlightButton(sender)
        setAmountFromButton(sender)
        currentAmountButton = sender
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
//        sender.isSelected = !sender.isSelected
//        highlightButton(sender)
//        setAmountFromButton(sender)
        selectedAmount(sender)
        btnCustom.isSelected = false
        highlightButton(btnCustom)
        tfAmount.isHidden = true
//        if let currentAmountButton = currentAmountButton {
//            currentAmountButton.isSelected = false
//            highlightButton(currentAmountButton)
//        }
//        currentAmountButton = sender
    }

    @IBAction func onLogoTapped(_ sender: UIButton) {
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        guard let limit = limit else {
            showError("Can't reload! Please try it at another time!")
            return
        }
        if btnCustom.isSelected {
            currentAmount = Double(tfAmount.text!) ?? 100
            if limit.noLimit == 0 && currentAmount > limit.limit {
                lbMessage.text = limit.limitText
                lbMessage.isHidden = false
                return
            }
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
