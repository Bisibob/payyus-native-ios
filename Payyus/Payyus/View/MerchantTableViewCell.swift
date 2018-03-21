//
//  MerchantTableViewCell.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MerchantTableViewCell: UITableViewCell {

    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func showData(_ merchant: Merchant) {
        ivLogo.image = UIImage(named: merchant.logo)
        lbName.text = merchant.name
    }

}
