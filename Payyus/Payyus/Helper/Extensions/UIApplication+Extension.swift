//
//  UIApplication+Extension.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
extension UIApplication {

    var topViewController: UIViewController? {

        guard keyWindow?.rootViewController != nil else {
            return keyWindow?.rootViewController
        }
        var topVC = keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            switch topVC?.presentedViewController {
            case let navigationController as UINavigationController :
                topVC = navigationController.viewControllers.last
            case let tabBarController as UITabBarController :
                topVC = tabBarController.selectedViewController
            default:
                topVC = topVC?.presentedViewController
            }
        }
        return topVC
    }
}
