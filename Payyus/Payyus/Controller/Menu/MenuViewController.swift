//
//  MenuViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    @IBOutlet weak var tbvMenu: UITableView!
    typealias Menu = (title: String, SID: String)
    var menuList: [Menu] = [ (title: "Merchants", SID: ""),
                             (title: "Bill Requests", SID: "SIBillRequests"),
                             (title: "Activity", SID: ""),
                             (title: "Rewards", SID: ""),
                             (title: "Gift Card", SID: ""),
                             (title: "Feedback", SID: ""),
                             (title: "Settings", SID: "")]
    var showViewControllerHandler:((UIViewController) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    private func setupView() {
        view.layer.cornerRadius = 5
        tbvMenu.delegate = self
        tbvMenu.dataSource  = self
        tbvMenu.isScrollEnabled = false
    }


}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuList[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(hex: "ACAEAE")
        if let vc = UIStoryboard.Main.viewControler(sid: menuList[indexPath.row].SID) {
            showViewControllerHandler?(vc)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.clear
    }
}
