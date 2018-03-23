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
//    @IBOutlet weak var iCarouselAdvs: iCarousel!
    var advImages: [Advert] = SamepleData.advertsList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lastMerchant = AppConfiguration.shared.lastMerchant{
            ivLogo.image = UIImage(base64String: lastMerchant.image)
            lbMerchantName.text = lastMerchant.merchant
            lbBalance.text = "$0.00"
        }
//        iCarouselAdvs.type = .rotary
//        iCarouselAdvs.isVertical = true
//        iCarouselAdvs.offsetMultiplier = 2
//        iCarouselAdvs.centerItemWhenSelected = false
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        iCarouselAdvs.perspective = -0.0005
//        iCarouselAdvs.contentOffset = view.frame.size
//        iCarouselAdvs.viewpointOffset = CGSize(width: 60, height: 60)
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

}
extension MerchantViewController: iCarouselDelegate, iCarouselDataSource {
//    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
//        return CATransform3DTranslate(transform, 0, -100, 0)
//    }
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .visibleItems:
            return 2
        case .spacing:
            return 2.0
        case .wrap:
            return 0
        case .showBackfaces:
            return 0
        default:
            return value
        }

    }
//    func numberOfPlaceholders(in carousel: iCarousel) -> Int {
//        return 1
//    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return advImages.count
    }



    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        if let view = view as? UIImageView {
            itemView = view


        }else {
            let screenSize = UIScreen.main.bounds.size
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width , height: screenSize.height/2.0))
            itemView.contentMode = .scaleAspectFit
        }
        itemView.image = UIImage(named: advImages[index].image)
        return itemView
    }


}

