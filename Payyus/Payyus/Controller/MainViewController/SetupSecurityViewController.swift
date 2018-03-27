//
//  SetupSecurityViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SetupSecurityViewController: BaseViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tfPassword: UITextField!

    @IBOutlet weak var btnVisiblePassword: UIButton!
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    func setupView(){
        btnNext.addCorner()
        btnNext.isEnabled = false
        tfPassword.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNext(_ sender: Any) {
        self.showLoading()
        guard let phoneNumber = phoneNumber, let pinCode = tfPassword.text else {
            return
        }
        AppAPIService.login(phone: phoneNumber, pinCode: pinCode) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hiddenLoading()
            switch result {
            case .success(let canMoveToMerchant):
                if canMoveToMerchant {
                    strongSelf.goToSelectMerchantViewController()
                }else {
                    strongSelf.showAlertToRegisterPhone()
                }
            case .error(let error):
                strongSelf.showError(error)
            }
        }
//        AppAPIService.getSecretKey(phone: phoneNumber, pinCode: pinCode) {[weak self] (result) in
//            guard let strongSelf = self else {
//                return
//            }
//            strongSelf.hiddenLoading()
//            switch result {
//            case .success(let canMoveToMerchant):
//                if canMoveToMerchant {
//                    strongSelf.goToSelectMerchantViewController()
//                }else {
//                    strongSelf.showAlertToRegisterPhone()
//                }
//            case .error(let error):
//                strongSelf.showError(error)
//            }
//        }
    }

    @IBAction func onVisiblePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
        tfPassword.becomeFirstResponder()
    }
    func showAlertToRegisterPhone() {
        showAlert(title: "Warning", message: "", cancelTitle: "Cancel", doneTitle: "Confirm") {[unowned self] (_) in
            self.showLoading()
            guard let phoneNumber = self.phoneNumber, let pinCode = self.tfPassword.text else {
                return
            }
            AppAPIService.registerUser(phone: phoneNumber, pinCode: pinCode, completionHandler: {[weak self] (result) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.hiddenLoading()
                switch result {
                case .success(_):
                    strongSelf.goToSelectMerchantViewController()
                case .error(let error):
                    strongSelf.showError(error)
                }
            })
        }
    }

    func goToSelectMerchantViewController() {
        let merchantVC = UIStoryboard.Main.setupMerchantViewController()
        navigationController?.pushViewController(merchantVC, animated: true)
    }
}

extension SetupSecurityViewController: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        btnNext.isEnabled = textField.text?.checkLength(comparison: .greaterThanOrEqualTo, length: 6, shouldChangeCharactersIn: range, replacementString: string) ?? false
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfPassword{
            textField.resignFirstResponder()
        }
        return true
    }
}
