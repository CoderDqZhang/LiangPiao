//
//  OrderConfirmViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class OrderConfirmViewModel: NSObject {
    
    
    var tableSelectSingle:RACSignal!

    override init() {
        
    }
    
    func configCellLabel(indexPath:NSIndexPath) -> String {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                return "新增收货地址"
            default:
                return "配送方式"
            }
        case 1:
            switch indexPath.row {
            case 0:
                return ""
            case 1:
                return "代收票款"
            case 2:
                return "优惠券"
            case 3:
                return "配送费"
            case 4:
                return "买家留言:"
            default:
                return "配送方式"
            }
        default:
            switch indexPath.row {
            case 0:
                return "微信支付"
            default:
                return "支付宝"
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:NSIndexPath) {
        if indexPath.section == 2 {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! GloabTitleAndImageCell
            cell.updateImageView(true)
            if indexPath.row == 0 {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 2)) as! GloabTitleAndImageCell
                cell.updateImageView(false)
            }else{
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 2)) as! GloabTitleAndImageCell
                cell.updateImageView(false)
            }
            
        }else{
            tableSelectSingle = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                subscriber.sendNext(indexPath)
                subscriber.sendCompleted()
                return nil
            })
        }
    }
}
