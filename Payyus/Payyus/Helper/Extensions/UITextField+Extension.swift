//
//  UITextField+Extension.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


extension UITextField {

    func textShouldChangeCharactersIn(_ range: NSRange, replacementString string: String) -> String {
        guard let text = text else {
            return ""
        }
        if let textRange = Range(range, in: text){
            return text.replacingCharacters(in: textRange, with: string)
        }
        return text
    }

    func addEyeButton() {
        let buttonSize: CGFloat = 32
        let button = UIButton(frame: CGRect(x: 0 , y: 0, width: buttonSize, height: buttonSize))
        button.setImage(#imageLiteral(resourceName: "visible") , for: .normal)
        button.setImage(#imageLiteral(resourceName: "invisible"), for: .selected)
        button.addTarget(self, action: #selector(onShowPassword(_:)), for: UIControlEvents.touchUpInside)
        rightView = button
        rightViewMode = .always

    }

    @objc func onShowPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isSecureTextEntry = !isSecureTextEntry
        resignFirstResponder()
        becomeFirstResponder()
    }
}

