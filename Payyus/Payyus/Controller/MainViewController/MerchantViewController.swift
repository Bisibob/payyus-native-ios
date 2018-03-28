//
//  MerchantViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MerchantViewController: BaseViewController {
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lbMerchantName: UILabel!
    @IBOutlet weak var lbBalance: UILabel!
    @IBOutlet weak var iCarouselAdvs: iCarousel!
    
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    var advImages: [Advert] = SamepleData.advertsList()
    var firstLoad: Bool = false
    var currentMerchant: MerchantMoreInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        iCarouselAdvs.type = .rotary
        iCarouselAdvs.isVertical = true
        iCarouselAdvs.bounces = false
        iCarouselAdvs.scrollSpeed = 0.5
        loadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("\(UIScreen.main.bounds.width) ")
        if !firstLoad {
            firstLoad = true
            let screenSize = UIScreen.main.bounds
//            let y = (screenSize.height)/2
            topViewConstraint.constant =  -(screenSize.height - screenSize.width)
        }
    }

    
    @IBAction func onLogoTapped(_ sender: UIButton) {
       showMenu(sender: sender)
    }


    @IBAction func onFundAccount(_ sender: Any) {
        let fundAccountVC = UIStoryboard.Main.fundAccountViewController() as! FundAccountViewController
        fundAccountVC.merchant = currentMerchant?.info
        navigationController?.pushViewController(fundAccountVC, animated: true)
    }

    private func loadData() {
        if let merchantId = AppConfiguration.shared.account?.mainMerchantId {
            showLoading(alpha: 1)
            AppAPIService.getMerchantInfo(merchantId: merchantId, completionHandler: {[weak self] (result) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.hiddenLoading()
                switch result {
                case .success(let merchantInfo):
                    strongSelf.currentMerchant = merchantInfo
                    strongSelf.showData()
                case .error(let error):
                    strongSelf.showError(error)
                }
            })
        }

    }
    private func showData(){
        if let merchant = currentMerchant?.info {
            let logo = UIImage(base64String: merchant.image)
            ivLogo.image = logo
            lbMerchantName.text = merchant.merchant
            if let balance = currentMerchant?.balance {
                lbBalance.text = String(format: "$%@",balance)
            }
            if let adverts = currentMerchant?.advertisements, adverts.count > 0 {
                advImages = adverts
                iCarouselAdvs.reloadData()
            }else {
                let imageView = UIImageView(frame: iCarouselAdvs.bounds)
                imageView.image = logo
                let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = imageView.frame
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                imageView.addSubview(blurEffectView)
                iCarouselAdvs.addSubview(imageView)
            }
        }
    }
}


extension MerchantViewController: iCarouselDelegate, iCarouselDataSource {

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {

        case .visibleItems:
            return 3
        case .spacing:
            return 1.8
        case .wrap:
            return 0
        case .showBackfaces:
            return 1
        case .arc:
            return CGFloat(Double.pi)
//        case .
        default:
            return value
        }

    }
    func numberOfPlaceholders(in carousel: iCarousel) -> Int {
        return 1
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return advImages.count
    }


    func carousel(_ carousel: iCarousel, placeholderViewAt index: Int, reusing view: UIView?) -> UIView {
        return UIView()
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        if let view = view as? UIImageView {
            itemView = view


        }else {
            let screenSize = UIScreen.main.bounds.size
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width , height:screenSize.width))
            itemView.contentMode = .scaleAspectFill
            itemView.backgroundColor = UIColor.blue
        }
//        itemView.image = UIImage(named: advImages[index].image)
        return itemView
    }


}

