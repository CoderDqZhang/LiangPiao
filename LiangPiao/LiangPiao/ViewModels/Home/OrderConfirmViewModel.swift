//
//  OrderConfirmViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderConfirmViewModel: NSObject {
    
    
    
    override init() {
        
    }
    
    func configCellLabel(indexPath:NSIndexPath) -> String {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
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
}
