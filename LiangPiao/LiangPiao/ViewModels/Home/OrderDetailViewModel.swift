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
    var aliPayurl:String = ""
    
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
    
    func requestPayUrl(cnotroller:OrderDetailViewController){
        BaseNetWorke.sharedInstance.getUrlWithString("http://api.liangpiao.me/order/pay_info/0bf127c08c830c62608295feb04c0a3b/", parameters: nil).subscribeNext { (resultDic) in
            self.aliPayurl = resultDic.objectForKey("alipay") as! String
            AlipaySDK.defaultService().payOrder(self.aliPayurl, fromScheme: "LiangPiaoAlipay") { (resultDic) in
            }
        }
    }
}
