//
//  SetupBankBillingViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/20/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire


class SetupBankBillingViewController: BaseViewController {
    @IBOutlet weak var tfShopperFirstName: UITextField!
    @IBOutlet weak var tfShopperLastName: UITextField!
    @IBOutlet weak var tfAddress1: UITextField!
    @IBOutlet weak var tfAddress2: UITextField!
    @IBOutlet weak var tfZipCode: AutoCompleteTextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfState: AutoCompleteTextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!

    private var loadZipCodeTask: DataRequest?
    private lazy var USStates: [(value: String, data: String)] = CommonHelper.USStates()
    private var suggestStates: [(value: String, data: String)] = []

    var accountInfo: BankAccountInfo? = BankAccountInfo()
    var doneHandler: ((UIViewController, BankAccountInfo) -> ())?
    var cancelHandler: ((UIViewController) ->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfZipCode.updateFrame()
        tfState.updateFrame()
//        if let info = accountInfo {
//            let fullName = info.holderName.components(separatedBy: " ")
//            tfShopperFirstName
//        }
    }
   
    func setupView() {
        configureAutoCompleteTextField(tfZipCode)
        handleZipCodeAutoComplete()
        handleStateAutoComplete()
        btnDone.isEnabled = valid()
        tfAddress1.delegate = self
        tfCity.delegate = self
        tfShopperLastName.delegate = self
        tfShopperFirstName.delegate = self
    }


    func configureAutoCompleteTextField(_ textField: AutoCompleteTextField) {
        textField.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        textField.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        textField.autoCompleteCellHeight = 35.0
        textField.maximumAutoCompleteCount = 10
        textField.hidesWhenSelected = true
        textField.hidesWhenEmpty = true
        textField.enableAttributedText = true
        var attributes = [NSAttributedStringKey:Any]()
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.black
        attributes[NSAttributedStringKey.font] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        textField.autoCompleteAttributes = attributes
    }

    private func handleZipCodeAutoComplete() {
        tfZipCode.onTextChange = {[weak self] text in
            guard let strongSelf = self else {
                return
            }
            strongSelf.btnDone.isEnabled = strongSelf.valid()
            if !text.isEmpty{
                if let dataTask = strongSelf.loadZipCodeTask {
                    dataTask.cancel()
                }
                strongSelf.fetchAutoCompleteZipCode(text)
            }
        }

        tfZipCode.onSelect = {[weak self] text, indexpath in
            guard let strongSelf = self else {
                return
            }
            let data = text.components(separatedBy: ", ")
            strongSelf.tfZipCode.text = data[0]
            strongSelf.tfCity.text = data[1]
            strongSelf.tfState.text = data[2]
            strongSelf.btnDone.isEnabled = strongSelf.valid()
        }
    }

    private func handleStateAutoComplete() {
        tfState.onTextChange = { [weak self] text in
            guard let strongSelf = self else {
                return
            }
            strongSelf.btnDone.isEnabled = strongSelf.valid()
            if !text.isEmpty{
                strongSelf.suggestStates = strongSelf.USStates.filter({ (state) -> Bool in
                    return state.value.lowercased().contains(text.lowercased())
                })
                strongSelf.tfState.autoCompleteStrings = strongSelf.suggestStates.map{$0.value}
            }
        }
        tfState.onSelect = {[weak self] text, indexpath in
            guard let strongSelf = self else {
                return
            }
            strongSelf.tfState.text = strongSelf.suggestStates[indexpath.row].data
            strongSelf.btnDone.isEnabled = strongSelf.valid()
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        guard let cancelHandler = cancelHandler else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        cancelHandler(self)

    }

    @IBAction func onDone(_ sender: Any) {
        //TODO: Save data to database
        guard let doneHandler = doneHandler else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if accountInfo == nil{
            accountInfo = BankAccountInfo()
        }
        accountInfo?.address = tfAddress1.text!
        accountInfo?.holderName = tfShopperFirstName.text! + " " + tfShopperLastName.text!
        accountInfo?.zipcode = tfZipCode.text!
        doneHandler(self, accountInfo!)
    }

    private func valid() -> Bool{
        if tfShopperFirstName.text!.isEmpty
            || tfShopperLastName.text!.isEmpty
            || tfCity.text!.isEmpty
            || tfState.text!.isEmpty
            || tfZipCode.text!.isEmpty
            || tfAddress1.text!.isEmpty
        {
            return false
        }
        return true
    }

    private func fetchAutoCompleteZipCode(_ zipCode: String) {
        loadZipCodeTask = AppAPIService.getZipCodes(zipCode: zipCode, completionHandler: { [weak self] (data) in
            self?.tfZipCode.autoCompleteStrings = data.map{$0.value}
        })
    }

    @objc private func hiddenKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension SetupBankBillingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        btnDone.isEnabled = valid()
        return true
    }
}
