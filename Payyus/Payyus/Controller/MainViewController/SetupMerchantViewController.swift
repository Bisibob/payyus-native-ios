//
//  SetupMerchantViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SetupMerchantViewController: BaseViewController {
    @IBOutlet weak var tfMerchantName: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        btnNext.addCorner()
        let tfMerchantNamePlaceholder: String = "Merchant Name"
        tfMerchantName.attributedPlaceholder = NSAttributedString(string: tfMerchantNamePlaceholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)])
        tfMerchantName.delegate = self
    }
    
    @IBAction func onNext(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
extension SetupMerchantViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
