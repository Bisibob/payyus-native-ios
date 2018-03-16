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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    
    func hiddenLoading() {
        loadingView.removeFromSuperview()
    }
}
