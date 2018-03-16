//
//  SetupMerchantViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SetupMerchantViewController: BaseViewController {
    @IBOutlet weak var tfMerchantName: UITextField!
    
    @IBOutlet weak var tbvMerchants: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var vTableLoading: UIView!
    private var selectedMerchant: Merchant?
    private var merchantsList: [Merchant] = []
    private var delayTypingTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        btnNext.addCorner()
        btnNext.isEnabled = false
        showTableView(false)
        let tfMerchantNamePlaceholder: String = "Merchant Name"
        tfMerchantName.attributedPlaceholder = NSAttributedString(string: tfMerchantNamePlaceholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)])
        tfMerchantName.delegate = self
        tbvMerchants.delegate = self
        tbvMerchants.dataSource = self

    }
    
    @IBAction func onNext(_ sender: Any) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func showTableView(_ value: Bool){
        tbvMerchants.isHidden = !value
        vTableLoading.isHidden = !value
    }
    func scheduleSearchMerchant(timeInterval: TimeInterval) {
        if delayTypingTimer == nil {
            delayTypingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(startSearching(timer:)), userInfo: nil, repeats: false)
        }
    }
    @objc func startSearching(timer: Timer) {
        delayTypingTimer?.invalidate()
        delayTypingTimer = nil
        guard let text = tfMerchantName.text, text.count > 0 else {
            return
        }
        searchMerchant(keyword: text)
    }

    func searchMerchant(keyword: String){
        selectedMerchant = nil
        btnNext.isEnabled = false
        AppAPIService.searchMerchant(name: keyword) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let merchants):
                strongSelf.merchantsList = merchants
                strongSelf.vTableLoading.isHidden = true
                strongSelf.tbvMerchants.reloadData()
            case .error(let error):
                strongSelf.showError(error)
            }
        }
    }
}

extension SetupMerchantViewController:UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = textField.textShouldChangeCharactersIn(range, replacementString: string)
        if updatedText.count > 4 {
            scheduleSearchMerchant(timeInterval: 0.5)
            showTableView(true)
        }else if updatedText.count == 0{
            showTableView(false)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SetupMerchantViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MerchantTableViewCell
        let item = merchantsList[indexPath.row]
        cell.lbName.text = item.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMerchant = merchantsList[indexPath.row]
        tfMerchantName.text = selectedMerchant?.name
        showTableView(false)
        btnNext.isEnabled = true

    }

}

