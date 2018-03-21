//
//  UIStoryboardExtension.swift
//  MVVMTemplate
//
//  Created by Thuỳ Nguyễn on 2/8/18.
//  Copyright © 2018 NUS Technology. All rights reserved.
//

import Foundation
import UIKit


//TODO: Rename this file to UIStoryboardExtension
protocol StoryboardScene: RawRepresentable {

    static var storyboardName : String { get }

}


extension StoryboardScene {

    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }

    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue as! String)
    }
}



extension UIStoryboard {

    struct Main {

        private enum Identifier : String, StoryboardScene {
            static let storyboardName = "Main"
            case mainVC = "SIMain"
            case setupPasswordVC = "SISetupPassword"
            case setupMerchantVC = "SISetupMerchant"
            case bankConnectionVC = "SIBankConnection"
            case bankAccountSelectionVC = "SIBankAccountSelection"
            case setupBankBillingVC = "SISetupBankBilling"
        }

        static func mainViewController() -> UIViewController {
            return Identifier.mainVC.viewController()
        }

        static func setupPasswordViewController() -> UIViewController {
            return Identifier.setupPasswordVC.viewController()
        }

        static func setupMerchantViewController() -> UIViewController {
            return Identifier.setupMerchantVC.viewController()
        }

        static func bankConnectionViewController() -> UIViewController {
            return Identifier.bankConnectionVC.viewController()
        }

        static func bankAccountSelectionViewController() -> UIViewController {
            return Identifier.bankAccountSelectionVC.viewController()
        }

        static func setupBankBillingViewController() -> UIViewController {
            return Identifier.setupBankBillingVC.viewController()
        }
    }


}
