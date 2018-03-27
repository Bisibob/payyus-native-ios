//
//  BaseViewController.swift
//  Payyus
//
//  Created by admin on 3/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var loadingView: UIView = {
        let v = UIView(frame: UIScreen.main.bounds)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.startAnimating()
        v.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        v.addSubview(indicator)
        indicator.center = v.center
        return v
    }()
    lazy var menuVC = UIStoryboard.Main.menuViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu(sender: UIButton) {
        if sender.isSelected {
            menuVC.view.removeFromSuperview()
        }else{
            let buttonFrame = sender.frame
            menuVC.view.frame = CGRect(x: buttonFrame.origin.x, y: buttonFrame.origin.y + 30, width: 180, height: 470)
            menuVC.view.layoutIfNeeded()
            sender.superview?.addSubview(menuVC.view)
        }
        sender.isSelected = !sender.isSelected
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



    func showError(_ message: String) {
        showMessage(title: "Error", message: message)
    }



    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }



    func showLoading() {
        if !view.subviews.contains(loadingView){
            view.addSubview(loadingView)
        }
    }

    func showAlert(title: String, message: String, cancelTitle: String, cancelHandler: ((UIAlertAction) -> Void)? = nil, doneTitle: String? = nil, doneHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(cancelTitle, comment: ""), style: .cancel, handler: cancelHandler))
        if let doneTitle = doneTitle {
            alert.addAction(UIAlertAction(title: NSLocalizedString(doneTitle, comment: ""), style: .cancel, handler: doneHandler))
        }
        self.present(alert, animated: true, completion: nil)
    }

    
    func hiddenLoading() {
        loadingView.removeFromSuperview()
    }
}
