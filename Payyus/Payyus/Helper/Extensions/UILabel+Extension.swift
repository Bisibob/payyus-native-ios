//
//  UILabel+Extension.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
extension UILabel {
    convenience init(centerLabelWithFrame frame: CGRect, text: String, textSize: CGFloat = 30, color: UIColor? = UIColor.black, backgroundColor: UIColor? = UIColor.white) {
        self.init(frame:frame)
        self.text = text
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: textSize)
        self.textColor = color
        self.backgroundColor = UIColor.white
    }
}
