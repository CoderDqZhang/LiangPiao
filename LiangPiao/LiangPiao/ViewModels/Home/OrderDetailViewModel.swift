//
//  OrderDetailViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

typealias  OrderDetailViewMoedelClouse = (indexPath:NSIndexPath, model:OrderList) -> Void
class OrderDetailViewModel: NSObject {

    var aliPayurl:String = ""
    var model:OrderList!
    var ticketModel:HomeTicketModel!
    var sesstionModel:TicketSessionModel!
    var controller:OrderDetailViewController!
    var indexPath:NSIndexPath!
    var orderDetailViewMoedelClouse:OrderDetailViewMoedelClouse!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderDetailViewModel.orderStatusChange(_:)), name: OrderStatuesChange, object: nil)
    
    }
    
    func orderStatusChange(object:NSNotification){
        print(object.object as! String)
        self.model.status = Int(object.object as! String)
        if self.model.status == 2 {
            self.model.statusDesc = "交易取消"
        }else if self.model.status == 3 {
            self.model.statusDesc = "待发货"
        }
        self.controller.updateTableView(self.model.status)
        controller.tableView.reloadData()
        
        if orderDetailViewMoedelClouse != nil {
            self.orderDetailViewMoedelClouse(indexPath: self.indexPath, model: self.model)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableViewHeiFootView(tableView:UITableView, section:Int) -> CGFloat {
        switch section {
        case 2:
            return 118
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat{
        switch indexPath.section {
        case 0:
            if self.model.status == 0 {
                return 170
            }else{
                return 124
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            default:
                return 80
            }
        default:
            switch indexPath.row {
            case 0:
                return 125
            default:
                return 48
                
            }
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
    
    func tableViewCellOrderDoneTableViewCell(cell:OrderDoneTableViewCell){
        cell.setData(model)
    }
    
    func requestPayModel(cnotroller:OrderDetailViewController){
        if model.payType == 1 {
            if self.model.payUrl.alipay == "" {
                MainThreadAlertShow("获取支付链接错误", view: cnotroller.view)
                return
            }
            AlipaySDK.defaultService().payOrder(self.model.payUrl.alipay, fromScheme: "LiangPiaoAlipay") { (resultDic) in
                print("resultDic")
            }
        }else{
            if self.model.payUrl.wxpay == nil {
                MainThreadAlertShow("获取支付链接错误", view: cnotroller.view)
                return
            }
            let request = PayReq()
            request.prepayId = self.model.payUrl.wxpay.prepayid
            request.partnerId = self.model.payUrl.wxpay.partnerid
            request.package = self.model.payUrl.wxpay.packageField
            request.nonceStr = self.model.payUrl.wxpay.noncestr
            request.timeStamp = UInt32(self.model.payUrl.wxpay.timestamp)!
            request.sign = self.model.payUrl.wxpay.sign
            WXApi.sendReq(request)
        }
    }
    
    func requestPayUrl(controller:OrderDetailViewController) {
        self.controller = controller
        let url = "http://api.liangpiao.me/order/pay_info/\(model.orderId)/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let payUrl = PayUrl.init(fromDictionary: resultDic as! NSDictionary)
            self.model.payUrl = payUrl
        }

    }
}
