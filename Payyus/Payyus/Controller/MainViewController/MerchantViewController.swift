//
//  MerchantViewController.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SDWebImage
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
        showMenu()
//        let string = "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"
//        do {
//            if let data = Data(base64Encoded: string){
//                let serverPlainText = try RNCryptor.decrypt(data: data, withPassword: "26019618fd2df6eec502d32015bc8d9f47f55c5fe924b19af55f2aea8bd82164")
//                if let dic = try JSONSerialization.jsonObject(with: serverPlainText, options: .mutableContainers) as? NSDictionary{
//                    //                serverHalf = dic
//                }
//            }
//        }catch {}

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

    
//    @IBAction func onLogoTapped(_ sender: UIButton) {
//       showMenu(sender: sender)
//    }


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
            return 1.5
        case .wrap:
            return 0
        case .showBackfaces:
            return 1
        case .arc:
            return CGFloat(2*Double.pi)
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
        let advert = advImages[index].params
        if let view = view as? UIImageView {
            itemView = view


        }else {
            let screenSize = UIScreen.main.bounds.size
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width , height:screenSize.width))
            itemView.contentMode = .scaleAspectFill
            itemView.backgroundColor = UIColor.white
//            let labelFrame = itemView.bounds
//            labelFrame.origin.y = labelFrame.height -
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width , height:screenSize.width))

            label.font = UIFont(name: "OpenSans-Bold", size: 30)
            label.textColor = UIColor.white
            label.tag = 2
            itemView.addSubview(label)


        }
        let label = itemView.viewWithTag(2) as! UILabel
        label.text = advert?.title
        print("current: \(carousel.currentItemIndex), index: \(index)")
        label.isHidden = index != carousel.currentItemIndex

        if let image = advImages[index].params?.image {
            let url = URL(string: image)
            itemView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "empty-picture"))
        }else {
            itemView.image = #imageLiteral(resourceName: "empty-picture")
        }

        return itemView
    }


}

