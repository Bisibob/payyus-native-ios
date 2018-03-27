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
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let lastMerchant = AppConfiguration.shared.lastMerchant{
//            ivLogo.image = UIImage(base64String: lastMerchant.image)
//            lbMerchantName.text = lastMerchant.merchant
//            lbBalance.text = "$0.00"
//        }
        iCarouselAdvs.type = .rotary
        iCarouselAdvs.isVertical = true
        iCarouselAdvs.bounces = false
        iCarouselAdvs.scrollSpeed = 0.5
//        iCarouselAdvs.offsetMultiplier = 2
//        iCarouselAdvs.centerItemWhenSelected = false
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("\(UIScreen.main.bounds.width) ")
//        iCarouselAdvs.perspective = -0.0005
//        iCarouselAdvs.contentOffset = view.frame.size
//        iCarouselAdvs.viewpointOffset = CGSize(width: 60, height: 60)
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//
    }

    
    @IBAction func onLogoTapped(_ sender: UIButton) {
       showMenu(sender: sender)
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
//        var itemView: UIImageView
//        if let view = view as? UIImageView {
//            itemView = view
//
//
//        }else {
//            let screenSize = UIScreen.main.bounds.size
//            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width , height: screenSize.height/2.0))
//            itemView.contentMode = .scaleAspectFit
//        }
//        itemView.image = UIImage(named: advImages[index].image)
        return UIView()
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        if let view = view as? UIImageView {
            itemView = view


        }else {
            let screenSize = UIScreen.main.bounds.size
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width , height:screenSize.width))
//            print("w \(screenSize.width) ")
            itemView.contentMode = .scaleAspectFill
            itemView.backgroundColor = UIColor.blue
        }
        itemView.image = UIImage(named: advImages[index].image)
        return itemView
    }


}

