//
//  UIViewController+NavigationBar.swift
//  Meet
//
//  Created by Zhang on 7/1/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func setNavigationItemBack(){
        let leftImage = UIImage.init(named: "Icon_Back_Normal")
        let spacBarButton = UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: nil, action: nil);
        self.navigationItem.leftBarButtonItems = [spacBarButton,UIBarButtonItem(image: leftImage?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(UIViewController.backBtnPress(_:)))]
    }

    func backBtnPress(sender:UIButton){
        self.navigationController?.popViewControllerAnimated(true)
    }
//
//    func setNavigationItemTinteColor() {
//        self.navigationController?.navigationBar.tintColor = UIColor.black
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.systemFont(ofSize: 18.0)]
//    }
//    
//    func setNavigationItemDisMiss() {
//        let leftImage = UIImage.init(named:"me_dismissBlack")
//        let spacBarButton = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil);
//        self.navigationItem.leftBarButtonItems = [spacBarButton,UIBarButtonItem(image: leftImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIViewController.disMissBtnPress(_:)))]
//    }
//    
//    func disMissBtnPress(_ sender:UIBarButtonItem){
//        self.dismiss(animated: true) {
//            
//        }
//    }
}
