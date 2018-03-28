//
//  BankConnectionViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import LinkKit
import RNCryptor

class BankConnectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet;
        }
        present(linkViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BankConnectionViewController: PLKPlaidLinkViewDelegate {
    func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [String : Any]?) {
        print(publicToken)
        linkViewController.dismiss(animated: true) {[unowned self] in
            let bankAccountSelectionVC = UIStoryboard.Main.bankAccountSelectionViewController() as! BankAccountSelectionViewController
            bankAccountSelectionVC.publicToken = publicToken
            self.navigationController?.pushViewController(bankAccountSelectionVC, animated: true)
        }
//        print(metadata)
        

    }

    func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
        linkViewController.dismiss(animated: true) {[unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }


    
}
