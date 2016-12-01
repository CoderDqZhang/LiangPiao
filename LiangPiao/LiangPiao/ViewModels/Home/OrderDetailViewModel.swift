//
//  OrderDetailViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderDetailViewModel: NSObject {

    var aliPayurl:String = ""
    var model:OrderList!
    var ticketModel:HomeTicketModel!
    var sesstionModel:TicketSessionModel!
    
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
    
    func tableViewCellOrderWaitePayTableViewCell(cell:OrderWaitePayTableViewCell) {
        cell.setData(model)
    }
    
    func tableViewCellTicketDetailInfoTableViewCell(cell:TicketDetailInfoTableViewCell){
        cell.setData(model.show, sessionModel: model.session, ticketModel: model.ticket)
    }
    
    func tableViewCellTicketLocationTableViewCell(cell:TicketLocationTableViewCell, controller:OrderDetailViewController){
        cell.setData(model.show)
    }
    
    func tableViewCellOrderPayTableViewCell(cell:OrderPayTableViewCell) {
        cell.setData(model.ticket)
    }
    
    func tableViewCellOrderMuchTableViewCell(cell:OrderMuchTableViewCell){
        cell.setData(model)
    }
    
    func requestPayUrl(cnotroller:OrderDetailViewController){
//        BaseNetWorke.sharedInstance.getUrlWithString("http://api.liangpiao.me/order/pay_info/0bf127c08c830c62608295feb04c0a3b/", parameters: nil).subscribeNext { (resultDic) in
//            self.aliPayurl = resultDic.objectForKey("alipay") as! String
//            AlipaySDK.defaultService().payOrder(self.aliPayurl, fromScheme: "LiangPiaoAlipay") { (resultDic) in
//            }
//        }
    }
}
