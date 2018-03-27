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
}

