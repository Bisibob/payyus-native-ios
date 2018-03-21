//
//  SetupPhoneViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SetupPhoneViewController: BaseViewController {

    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfDigitCode: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbResendDigitCode: UILabel!
    private lazy var tapOnResendDigitCode: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(resendDigitCode(sender:)))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        let tfPhoneNumberPlaceholder = "Phone"
        let tfDigitCodePlaceholder = "6 Digit Code"
        tfPhoneNumber.attributedPlaceholder = NSAttributedString(string: tfPhoneNumberPlaceholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)])
        
        tfDigitCode.attributedPlaceholder = NSAttributedString(string: tfDigitCodePlaceholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)])
        enableDigitCode(false)
        btnSend.addCorner()
        btnNext.addCorner()
        tfPhoneNumber.delegate = self
        tfDigitCode.delegate = self
        lbResendDigitCode.addGestureRecognizer(tapOnResendDigitCode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onSend(_ sender: Any) {
        addPhone()
    }
    
    @IBAction func onNext(_ sender: Any) {
        verifyCode()
    }

    @objc func resendDigitCode(sender: UITapGestureRecognizer) {
        addPhone()
    }
    private func enablePhoneNumber(_ value: Bool) {
        btnSend.isEnabled = value
    }

    private func enableDigitCode(_ value: Bool) {
        btnNext.isEnabled = value
        tfDigitCode.isEnabled = value
        tapOnResendDigitCode.isEnabled = value
    }


    // MARK - API service
    func addPhone() {
        showLoading()
        AppAPIService.addPhone(phone: tfPhoneNumber.text!) {[weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.hiddenLoading()
            switch result {
            case .success():
                strongSelf.enableDigitCode(true)
                strongSelf.tfDigitCode.becomeFirstResponder()
                strongSelf.enablePhoneNumber(false)
                strongSelf.showMessage(title: "Success", message: "Please check for sms box for verification code.")
                break
            case .error(let error):
                strongSelf.showError(error)
                break
            }
        }
    }

    func verifyCode() {
        showLoading()
        AppAPIService.verifyPhone(phone: tfPhoneNumber.text!, code: tfDigitCode.text!) {[weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.hiddenLoading()
            switch result {
            case .success():
                let setupPasswordVC = UIStoryboard.Main.setupPasswordViewController()
                strongSelf.navigationController?.pushViewController(setupPasswordVC, animated: true)
                break
            case .error(let error):
                strongSelf.showError(error)
                break
            }
        }
    }
}

extension SetupPhoneViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfDigitCode {
            btnNext.isEnabled =  textField.text?.checkLength(comparison: .equalTo, length: 6, shouldChangeCharactersIn: range, replacementString: string) ?? false
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfPhoneNumber {
            enablePhoneNumber(true)
            enableDigitCode(false)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfPhoneNumber{
            textField.resignFirstResponder()
        }else if textField == tfDigitCode{
            textField.resignFirstResponder()
        }
        return true
    }
}
