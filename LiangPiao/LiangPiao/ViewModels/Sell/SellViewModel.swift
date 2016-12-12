//
//  SellViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SellViewModel: NSObject {

    override init() {
        
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat{
        return 140
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:SellTicketsViewController) {
        if indexPath.row != 0 {
            let controllerVC = MySellConfimViewController()
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
}
