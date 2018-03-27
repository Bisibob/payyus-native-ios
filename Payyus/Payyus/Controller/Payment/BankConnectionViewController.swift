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
        let string = "AwFVbC6GrSu6XdIRncCCrQ16+jQi+cecrg9SO+ENnCM2chWnfo6r/vcQZ6wIU50m4kyROvwEJ4+9NDCEiuwvL3Hiu+yunojhxSz3pYfKYplFcZH9PXWU2Gz8hxj2nxtCyh854yu6gJcEGxy2aPs0oWqZ9pJ926aoH2p6Z4xjhreoINkDaktRIsOrwvxCs1Fmi9lUdts3hQJcNfQMjMy8V8dlznkWPNA09ezm7AFFoOSTZGUCqlTfG0rH3p6i2bD5I3fGwa04w4C0PHbJtCb89cy+GqWZ93rgkljpAKPjlIELQDxeiVZaX42h7TIPH0tnhJHuMhQ+h6A0RWJ89W1dAErg9iKEv1n1bVvwKpm4jB253qn0TTJspPT9zpJzqB2SxylT8+S+EMYz5dlOdGMK+4x2ixebvDj/nSx9vK3JfGF26BXGwxVyeYFQfZpKO7UY2wUH9QSAa8CmAKTF//5jS8xGCyiNdM3w/hYxLF4rXCpWi5vJQsE0+vOdKk6aiU/fIk0Sgq8RSXJfDslVLA0EqNqtm4Z0pS6mf+6fQdBXQuolk2MdnAE0vq6cFOewJySmFiK4eagf+DbuP3HUuL4nnY691XVUqqJBxifZANQDBhEn0cOuv2kI1LsDLNBt8E/hactjzAG4F6NRpRQ5aNMz6W1Qbe3h/2SM9MBfHPty1NRufmHYWJxu7Iq/pbnBeCFkuqSY4RMisl8vDPfAaecGdaCJyIBeoz6836cRRsmTL5Eb0eK35AloDgicLS7I0TfctQdDyXQfiyCEX1Qig7D0Y/X2fJD10rCeaKn+tvcXsO4BRkfUEnYfOy2Eg5uaCfVTAnlT94AI9Mr2O3OMZ9NH+jo1BrdBHp5wvagSQQcc0bgRXX0w9CHZwAcwgpKmtky0gnwX1u7yna6lV9GL77kIevTKpJjYaXCNUp9AwibJkjgiiz+/Duf14wGmiVnrHbQ4zC1zW5YRDmOH/dd5afORVh7luaGe2Ux46tAgROVu+/QcB047a/eFYsFltECdJ75TGs3Gr/f9jB/WkLdBgL4CoOpNCJ/upkUqqiOwOhdE+dHrEkavUxziTCyVboXFtgrxmu3c6CMAqSOV6Wobu/urA/rrqxy8AcEmB3fe0erL23GGUTqyYJ4VA6mC9NG16W1Yv+XO1P0QnnjnhInF2W9cLxUcYlRxCDom6gbyLHqUDgfxySg9YM1637zffBSWIQItYhzG+H3v4OBi0LdAOQilbOvXZ9qsOenXLIDo59vchVEhYA=="
        do {
            if let data = Data(base64Encoded: string){
                let serverPlainText = try RNCryptor.decrypt(data: data, withPassword: "26019618fd2df6eec502d32015bc8d9f47f55c5fe924b19af55f2aea8bd82164")
                if let dic = try JSONSerialization.jsonObject(with: serverPlainText, options: .mutableContainers) as? NSDictionary{
                    //                serverHalf = dic
                }
            }
        }catch {}

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
