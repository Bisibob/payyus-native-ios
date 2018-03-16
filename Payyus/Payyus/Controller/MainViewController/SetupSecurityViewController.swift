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
        let account = Account()
        AppAPIService.getSecretKey(account: account) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hiddenLoading()
            switch result {
            case .success():
                let merchantVC = UIStoryboard.Main.setupMerchantViewController()
                strongSelf.navigationController?.pushViewController(merchantVC, animated: true)
                break
            case .error(let error):
                strongSelf.showError(error)
                break
            }
        }
    }
}

extension SetupSecurityViewController: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        btnNext.isEnabled = textField.text?.checkLength(comparison: .greaterThan, length: 6, shouldChangeCharactersIn: range, replacementString: string) ?? false
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfPassword{
            textField.resignFirstResponder()
        }
        return true
    }
}
