//
//  ConfirmAlertView.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ConfirmAlertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lbTitle: UILabel!

    @IBOutlet weak var lbMessage: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, title: String, message: String) {
        super.init(frame: frame)
        commonInit()
        lbTitle.text = title
        lbMessage.text = message
        contentView.updateConstraints()
        contentView.layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ConfirmAlertView", owner: self, options: nil)
        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.setContentHuggingPriority(.required, for: .horizontal)
        contentView.setContentHuggingPriority(.required, for: .vertical)
        contentView.autoresizingMask = [.flexibleHeight]
    }

    func setLeftButton(title: String, handler: (()-> Void)?) {

    }
    func setRightButton(title: String, handler: (()-> Void)?) {

    }

    @IBAction func onClose(_ sender: Any) {
    }

    @IBAction func onNo(_ sender: Any) {
    }

    @IBAction func onYes(_ sender: Any) {
    }
    
}
