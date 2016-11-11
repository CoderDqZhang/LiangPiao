//
//  OrderListViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderListViewModel: NSObject {

    var orderArray = []
    override init() {
        
    }
    
    func listTitle() ->String {
        if orderArray.count == 0 {
            return "订单"
        }
        return "共 \(orderArray.count) 个订单"
    }
    
    func numberOfSection() -> Int {
        return orderArray.count
    }
    
    func numbrOfRowInSection(section:Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 3
        }
    }
    
    func tableViewHeightForRow(row:Int) -> CGFloat {
        switch row {
        case 0:
            return 49
        case 1:
            return 149
        default:
            return 59
        }
    }
    
}
