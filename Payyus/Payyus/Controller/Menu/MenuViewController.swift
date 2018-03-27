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
    var menuList: [String] = ["Merchants", "Bill Request", "Activity", "Rewards", "Gift Card", "Instant Funds", "Specials", "Feedback", "Settings"]
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
        cell.textLabel?.text = menuList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(hex: "ACAEAE")
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.clear
    }
}
