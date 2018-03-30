//
//  BillRequestView.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BillRequestView: UIView {

    @IBOutlet weak var lbMerchantName: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    var onPayHandler: ((UIView) -> Void)?

    @IBAction func onPay(_ sender: Any) {
        onPayHandler?(self)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
