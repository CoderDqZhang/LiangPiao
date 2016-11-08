//
//  OrderDetailViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderDetailViewModel: NSObject {

    var orderType:OrderType = .orderWaitPay
    override init() {
        
    }
    
    func tableViewHeiFootView(tableView:UITableView, section:Int) -> CGFloat {
        switch section {
        case 2:
            return 118
        default:
            return 10
        }
    }
    
    func tableViewNumberRowInSection(tableView:UITableView, section:Int) ->Int {
        if section == 0 {
            return 1
        }
        return 2

    }
    
    func cellTitleName(indexPathRow:Int) -> String {
        return ""
    }
    
    func cellDetailLabel(indexPathRow:Int) -> String {
        switch indexPathRow {
        case 0:
            return "360.00元"
        case 1:
            return "-30.00元"
        case 2:
            return "8.00元"
        default:
            return ""
        }
    }
}
