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
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setNavigationItemCleanButton(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: nil, style: .Plain, target: nil, action: nil)
    }
    
}
