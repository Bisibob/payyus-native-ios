//
//  LoginViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        tfPhoneNumber.delegate = self
        tfPassword.delegate = self
        
        let phoneNumberPlaceHolder: String = "Phone number"
        let passwordPlaceHolder: String = "Password"
        
        tfPhoneNumber.attributedPlaceholder = NSAttributedString(string: phoneNumberPlaceHolder,
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tfPassword.attributedPlaceholder = NSAttributedString(string: passwordPlaceHolder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5, height: 5)
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.shadowOpacity = 1.0
        
        btnLogin.layer.cornerRadius = 20.0
        btnLogin.clipsToBounds = true
        
    }
    
    override func viewDidLayoutSubviews() {
        addShadowForRoundedButton(view: self.view, button: btnLogin, opacity: 0.5)
    }
    
    func addShadowForRoundedButton(view: UIView, button: UIButton, opacity: Float = 1) {
        let shadowView = UIView()
        shadowView.backgroundColor = .black
        shadowView.layer.opacity = opacity
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.cornerRadius = 20.0
        shadowView.frame = CGRect(origin: CGPoint(x: button.frame.origin.x, y: button.frame.origin.y), size: CGSize(width: button.bounds.width, height: button.bounds.height))
        self.view.addSubview(shadowView)
        view.bringSubview(toFront: button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
    }
}
extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfPassword{
            textField.resignFirstResponder()
        }
        return true
    }
}

