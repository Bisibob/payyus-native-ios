//
//  BankAccountTableViewCell.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BankAccountTableViewCell: UITableViewCell {
    @IBOutlet weak var lbAccountName: UILabel!
    @IBOutlet weak var lbAccountNumber: UILabel!
    @IBOutlet weak var lbAvailableBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func showData(_ account: BankAccount) {
        lbAccountName.text = account.name
        let accountNumber = account.accountNumber
        let showNumber = String(accountNumber.suffix(from: accountNumber.index(accountNumber.endIndex, offsetBy: -4)))
        let hiddenNumber = String(repeating: "*", count: accountNumber.count - 4)
        lbAccountNumber.text =  hiddenNumber + showNumber
        lbAvailableBalance.text = "$\(account.balance)"
    }

}
