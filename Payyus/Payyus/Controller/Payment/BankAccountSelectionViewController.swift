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

    private var bankAccounts: [BankAccount] = []
    private var selectedAccount: BankAccount?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        publicToken = "fsdaf"
        setupView()
        loadBankAccount()
    }

    func setupView(){
        btnDone.addCorner()
        btnDone.isEnabled = false
        tbvBankAccount.rowHeight = 103
        tbvBankAccount.delegate = self
        tbvBankAccount.dataSource = self
    }

    @IBAction func onDone(_ sender: Any) {
        
    }


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
            case .success(let accounts):
                strongSelf.bankAccounts = accounts
                strongSelf.tbvBankAccount.reloadData()
                break
            case .error(let error):
                break
            }
        }
    }

    private func saveBankAccount(_ account: BankAccount) {
        guard let info = account.info else {
            AppConfiguration.shared.bankData = account
            //TODO: move to setup bank billing
            return
        }
        if info.address.isEmpty || info.holderName.isEmpty || info.phoneNumber.isEmpty || info.zipcode.isEmpty {
            //TODO: move to setup bank billing
        }
        if let loginAccount = AppConfiguration.shared.account {
            AppAPIService.getSecretKey(account: loginAccount, withCHKey: true, completionHandler: { (result) in
                switch (result) {
                case .success(let u):
                    break
                case .error(let error):
                    break
                }
            })
        }

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
        selectedAccount = bankAccounts[indexPath.row]
        btnDone.isEnabled = true
    }

}
