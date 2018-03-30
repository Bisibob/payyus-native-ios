//
//  BillRequestTableViewCell.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BillRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var lbMerchantName: UILabel!
    @IBOutlet weak var lbAmountBill: UILabel!
    var indexPath: IndexPath?
    var rejectHandler: ((IndexPath) -> Void)?
    var payHandler: ((IndexPath) -> Void)?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPay(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }
        payHandler?(indexPath)
    }

    @IBAction func onReject(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }
        rejectHandler?(indexPath)
    }

    func showData(_ bill: BillRequest) {
        lbMerchantName.text = bill.merchantName
        lbAmountBill.text = bill.formatAmount
    }

}
