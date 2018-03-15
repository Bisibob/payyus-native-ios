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
        
        btnSend.addCorner()
        btnNext.addCorner()
        tfPhoneNumber.delegate = self
        tfDigitCode.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onSend(_ sender: Any) {
    }
    
    @IBAction func onNext(_ sender: Any) {
    }    
}
extension SetupPhoneViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfPhoneNumber{
            textField.resignFirstResponder()
        }else if textField == tfDigitCode{
            textField.resignFirstResponder()
        }
        return true
    }
}
