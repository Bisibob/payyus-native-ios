//
//  BankAccountSelectionViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BankAccountSelectionViewController: BaseViewController {
    @IBOutlet weak var tbvBankAccount: UITableView!
    @IBOutlet weak var vLoading: UIView!
    @IBOutlet weak var btnDone: UIButton!
    var publicToken: String?
    var accessToken: String?
    private var bankAccounts: [PlaidBankAccount] = []
    private var selectedAccount: BankAccount?

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view.
//        publicToken = "public-sandbox-2d9cfdee-0b02-410c-b929-e1a874491536"
        setupView()
        loadBankAccount()
    }

    func setupView(){
        btnDone.addCorner()
        btnDone.isEnabled = false
        btnDone.isHidden = true
        tbvBankAccount.rowHeight = 103
        tbvBankAccount.delegate = self
        tbvBankAccount.dataSource = self
    }

//    @IBAction func onDone(_ sender: Any) {
////        saveBankAccount(selectedAccount!)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.moveToMainViewController()
//    }


    private func loadBankAccount() {
        guard let publicToken = publicToken else {
            return
        }
        vLoading.isHidden = false
        AppAPIService.plaidAccounts(publicToken: publicToken) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.vLoading.isHidden = true
            switch result {
            case .success(let respone):
                strongSelf.bankAccounts = respone.accounts
                strongSelf.tbvBankAccount.reloadData()
                strongSelf.accessToken = respone.accessToken
                break
            case .error(let error):
                break
            }
        }
    }

    private func saveBankAccount(stripe: String, account: PlaidBankAccount) {

        selectedAccount = BankAccount(plaidAccount: account)
        selectedAccount?.stripeToken = stripe
        guard let info = account.info else {
            AppConfiguration.shared.bankData = account
            //move to setup bank billing
            moveToSetupBankBilling(info: nil)
            return
        }
        if info.address.isEmpty || info.holderName.isEmpty || info.phoneNumber.isEmpty || info.zipcode.isEmpty {
            //move to setup bank billing
            moveToSetupBankBilling(info: info)
            return
        }

//       saveSelectedBankAccount(account: <#T##BankAccount#>)
    }

    private func moveToSetupBankBilling(info: BankAccountInfo?) {
        let setupBankBillingVC = UIStoryboard.Main.setupBankBillingViewController() as! SetupBankBillingViewController
        setupBankBillingVC.accountInfo = info
        setupBankBillingVC.cancelHandler = { viewController in
            viewController.navigationController?.popViewController(animated: true)
        }
        setupBankBillingVC.doneHandler = {[unowned self] (viewController, bankInfo) in
            self.selectedAccount?.updateInfo(info: bankInfo)
            self.selectedAccount?.yourPhoneNumber = (AppConfiguration.shared.account?.phone)!
            self.saveSelectedBankAccount(account: self.selectedAccount!)
            viewController.navigationController?.popViewController(animated: true)

        }
        navigationController?.pushViewController(setupBankBillingVC, animated: true)
    }

    

    private func saveSelectedBankAccount(account: BankAccount) {
//        AppConfiguration.shared.account?.isSetupBank = true
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.moveToMainViewController()
        AppAPIService.saveSelectedBankAccount(account: account) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(_):
                AppConfiguration.shared.account?.isSetupBank = true
                AppConfiguration.shared.saveData()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.moveToMainViewController()

            case .error(let error):
                strongSelf.showError(error)
            }
        }
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

extension BankAccountSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankAccounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BankAccountTableViewCell
        let account = bankAccounts[indexPath.row]
        cell.showData(account)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedAccount = bankAccounts[indexPath.row]
//        btnDone.isEnabled = true
        guard let accessToken = accessToken else {
            showError("Cant setup bank this time.")
            return
        }
        showLoading()
        AppAPIService.getStripeToken(accessToken: accessToken, accountId: bankAccounts[indexPath.row].accountId) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let stripeToken):
                strongSelf.saveBankAccount(stripe: stripeToken, account: strongSelf.bankAccounts[indexPath.row])
            case .error(let error):
                strongSelf.showError(error)
            }
        }

    }

}
