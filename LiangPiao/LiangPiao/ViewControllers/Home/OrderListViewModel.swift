//
//  OrderListViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderListViewModel: NSObject {

    var orderArray = ["",""]
//    var 
    var orderTypeArrays:[OrderType] = [.orderDone,.orderWaitPay]
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
    
    func tableViewHeightForRow(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 49
        case 1:
            if indexPath.section == 0 {
                return 163
            }
            return 149
        default:
            return 59
        }
    }
    
    func tableViewOrderCellIndexPath(indexPath:NSIndexPath, cell:OrderNumberTableViewCell) {
        let model = OrderModel()
        if indexPath.section == 0 {
            model.orderStatue = ""
            cell.setData(model)
        }else{
            model.orderStatue = "waitePay"
            cell.setData(model)
        }
    }
    
    func tableViewOrderTicketInfoCellIndexPath(indexPath:NSIndexPath, cell:OrderTicketInfoTableViewCell) {
        if indexPath.section == 0 {
            cell.setData(.orderDone)
        }else{
            cell.setData(.orderWaitPay)
        }
    }
    
    func tableViewOrderHandleCellIndexPath(indexPath:NSIndexPath, cell:OrderHandleTableViewCell) {
        
    }
    
}
