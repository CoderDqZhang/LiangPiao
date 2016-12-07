//
//  DiscountViewController.swift
//  LiangPiao
//
//  Created by Zhang on 01/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController {

    let discountView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.view.backgroundColor = UIColor.init(hexString: "F6F7FA")
        self.setNavigationItemBack()
        self.navigationItem.title =  "优惠券"
        self.talKingDataPageName = "优惠券"
        // Do any additional setup after loading the view.
    }

    func setUpView(){
        let image = UIImage.init(named: "Icon_Coupon")
        let imageView = UIImageView()
        imageView.image = image
        discountView.addSubview(imageView)
        
        let label = UILabel()
        label.text = "暂无优惠劵，敬请期待"
        label.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        label.font = App_Theme_PinFan_R_16_Font
        label.textAlignment = .Center
        discountView.addSubview(label)
        
        self.view.addSubview(discountView)
        
        imageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake((image?.size.width)!, (image?.size.height)!))
            make.centerX.equalTo(discountView.snp_centerX).offset(0)
            make.top.equalTo(discountView.snp_top).offset(0)
        }
        
        label.snp_makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom).offset(26)
            make.centerX.equalTo(discountView.snp_centerX).offset(0)
        }
        
        discountView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX).offset(0)
            make.centerY.equalTo(self.view.snp_centerY).offset(-94)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
