//
//  Extension.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

protocol Traceable {
    var cornerRadius: CGFloat { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    
    func addCorner()
}

extension Traceable where Self: UIView {
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return  UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    func addCorner() {
        layer.masksToBounds = true
        layer.cornerRadius = 4
    }
}
extension UIButton: Traceable {}


