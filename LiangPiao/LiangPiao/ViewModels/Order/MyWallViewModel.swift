//
//  MyWallViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 06/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyWallViewModel: NSObject {

    override init() {
        super.init()
    }
    
    func messageTitle() -> String{
        return "良票根据您的交易情况收取佣金\n每日前 10 张成交订单，佣金免费\n超过 10 单，每张收取订单金额 5% 作为佣金"
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        switch indexPath.row {
        case 0:
            return 190
        default:
            return 80
        }
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        return 2
    }
    
    func numberOfSection() -> Int{
        return 1
    }
    
    func tableViewDidSelect(indexPath:NSIndexPath, controller:MyWalletViewController) {
        
    }
}
