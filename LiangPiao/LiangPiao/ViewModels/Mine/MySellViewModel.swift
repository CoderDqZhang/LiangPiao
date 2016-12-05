//
//  MySellViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellViewModel: NSObject {

    let pageViewControllers = [MySellOrderViewController(),MySellManagerViewController()]
    let pageTitle = ["订单交易","票品管理"]
    override init() {
        
    }
    
    func numberOfControllersInPagerController() -> Int{
        return self.pageTitle.count
    }
    
    func pagerControllerTitleForIndex(index:Int) -> String{
        return pageTitle[index] 
    }
    
    func pagerControllerControllerForIndex(index:Int) -> UIViewController {
        return pageViewControllers[index] 
    }
}
