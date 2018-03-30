//
//  BillRequestsViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BillRequestsViewController: BaseViewController {
    @IBOutlet weak var tbvBillRequests: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    var billsList: [BillRequest] = []
    var selectedIndexPath : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        loadData()
        showMenu()
    }

    func setupView() {
        tbvBillRequests.delegate = self
        tbvBillRequests.dataSource = self
        tbvBillRequests.rowHeight = 100
        btnBack.addCorner()
    }
    override func onMenu(sender: UIButton) {
        super.onMenu(sender: sender)
        tbvBillRequests.isUserInteractionEnabled = !sender.isSelected

    }
    override func showViewControllerFromMenu(vc: UIViewController) {
        if !(vc is BillRequestsViewController) {
            dismiss(animated: false) {
                UIApplication.shared.topViewController?.present(vc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func loadData(){
        showLoading()
        AppAPIService.getBills {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hiddenLoading()
            switch result {
            case .success(let bills):
                strongSelf.billsList = bills
                strongSelf.tbvBillRequests.reloadData()
            case .error(let error):
                strongSelf.showError(error)
            }
        }
    }
    private func showAlertToRejectBillRequest(){
//        let alertView = ConfirmAlertView(frame: CGRect(x: 0, y: 0, width: 300, height: 400) , title: "Payment Request", message: "Do you want to reject selected payment request")
//        view.addSubview(alertView)
        self.showAlert(title: "Payment Request", message: "Do you want to reject selected payment request", cancelTitle: "No", cancelHandler: nil, doneTitle: "Yes", doneHandler: {[unowned self] (_) in
            self.rejectBillResquest()
        })
    }
    private func rejectBillResquest(){
        guard let indexPath = selectedIndexPath else{
            return
        }
        showLoading()
        let bill = billsList[indexPath.row]
        AppAPIService.rejectBill(billNumber: bill.billNo) {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hiddenLoading()
            switch result {
            case .success(_):
                strongSelf.billsList.remove(at: indexPath.row)
                strongSelf.tbvBillRequests.reloadData()
            case .error(let error):
                strongSelf.showError(error)
            }
        }
    }
    
}

extension BillRequestsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if billsList.count == 0 {
            let v = UIView(frame: tableView.bounds)
            let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100)
            let noResultLabel = UILabel(centerLabelWithFrame: frame, text: "No Bill Request!", color: UIColor(hex: "FFFFFF"))
            noResultLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            noResultLabel.font = UIFont(name: "OpenSans", size: 20)
            v.addSubview(noResultLabel)
            v.backgroundColor = UIColor.clear
            tableView.backgroundView = v
            tableView.separatorStyle = .none
        }else{
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return billsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BillRequestTableViewCell
        cell.showData(billsList[indexPath.row])
        cell.indexPath = indexPath
        cell.rejectHandler = {[unowned self] indexPath in
            self.selectedIndexPath = indexPath
            self.showAlertToRejectBillRequest()
        }
        return cell
    }

}
