//
//  OrderListViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

enum OrderStatus : String {
    case DEEFAUL = "0", //待支付
     CANCELED = "1", //用户取消
     EXPORED = "2",  //过时取消
     PAID = "3", //已经支付
     PAIDTICKETSHORTAGE = "4", //支付完成库存不足
     PAIDCANCELED = "5", //支付完成取消交易
     REFUNDED = "6",//已退款
     SHIPPED = "7", //已发货
     COMPLETED = "8", //已完成
     PENDING = "9",//待结算
     CLOSED = "10" //已结算
    static let allValues = [DEEFAUL, CANCELED, EXPORED ,PAID, PAIDTICKETSHORTAGE,PAIDCANCELED,REFUNDED,SHIPPED,SHIPPED,COMPLETED,PENDING,CLOSED]
}


class OrderListViewModel: NSObject {

    var model:OrderListModel!
    var selectOrder:OrderList!
    var indexPath:NSIndexPath!
    var controller:OrderListViewController!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderDetailViewModel.orderStatusChange(_:)), name: OrderStatuesChange, object: nil)
        
    }
    
    func orderStatusChange(object:NSNotification){
        if selectOrder != nil {
            if Int(object.object as! String) != 100 {
                selectOrder.status = Int(object.object as! String)
                if selectOrder.status == 2 {
                    selectOrder.statusDesc = "交易取消"
                }else if selectOrder.status == 3 {
                    selectOrder.statusDesc = "待发货"
                }
                self.changeOrderStatusPay(selectOrder, indexPath: self.indexPath, controller: controller)
            }else{
                let controller = OrderDetailViewController()
                controller.viewModel.model = selectOrder
                NavigationPushView(controller, toConroller: controller)
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func listTitle() ->String {
        if model == nil || model.orderList.count == 0 {
            return "订单"
        }
        return "共 \(model.orderList.count) 个订单"
    }
    
    func numberOfSectionsInTableView() -> Int {
        if model != nil {
            return model.orderList.count
        }
        return 0
    }
    
    func numbrOfRowInSection(section:Int) -> Int {
        let orderModel = model.orderList[section] 
        if orderModel.status == 0 {
            return 3
        }
        return 2
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 49
        case 1:
            let orderModel = model.orderList[indexPath.section]
            if orderModel.status == 0 {
                return 149
            }
            return 163
        default:
            return 59
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath, controller:OrderListViewController) {
        if indexPath.row == 1 {
            let controllerVC = OrderDetailViewController()
            controllerVC.viewModel.model = model.orderList[indexPath.section]
            controllerVC.viewModel.indexPath = indexPath
            controllerVC.viewModel.orderDetailViewMoedelClouse = { indexPath, model in
                self.model.orderList[indexPath.section] = model
                controller.tableView.reloadSections(NSIndexSet.init(index: indexPath.section), withRowAnimation: .Automatic)
            }
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
    
    func tableViewOrderCellIndexPath(indexPath:NSIndexPath, cell:OrderNumberTableViewCell) {
        cell.setData(model.orderList[indexPath.section])
    }
    
    func tableViewOrderTicketInfoCellIndexPath(indexPath:NSIndexPath, cell:OrderTicketInfoTableViewCell) {
        cell.setData(model.orderList[indexPath.section])
    }
    
    func tableViewOrderHandleCellIndexPath(indexPath:NSIndexPath, cell:OrderHandleTableViewCell, controller:OrderListViewController) {
        cell.cancelOrderBtn.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            UIAlertController.shwoAlertControl(controller, title: nil, message: "是否要放弃本次交易", cancel: "稍等一会", doneTitle: "确认取消", cancelAction: {
                
                }, doneAction: {
                    let model = self.model.orderList[indexPath.section]
                    self.changeOrderStatusCancel(model, indexPath:indexPath, controller:controller)
            })
            
        }
        cell.payOrderBtn.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.indexPath = indexPath
            self.controller = controller
            self.requestPayInfo(self.model.orderList[indexPath.section], controller: controller)
        }
    }
    
    func requestOrderList(controller:OrderListViewController, isNext:Bool){
        if !UserInfoModel.isLoggedIn() {
            MainThreadAlertShow("请登录后查看", view: KWINDOWDS!)
            return;
        }
        var url = ""
        if isNext {
            url = "\(OrderListUrl)?page=\(model.nextPage)"
        }else{
            url = OrderListUrl
        }
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            
            if isNext {
                let tempModel =  OrderListModel.init(fromDictionary: resultDic as! NSDictionary)
                self.model.hasNext = tempModel.hasNext
                self.model.nextPage = tempModel.nextPage
                self.model.orderList.appendContentsOf(tempModel.orderList)
                if (self.model.hasNext != nil) && self.model.hasNext == true {
                    controller.tableView.mj_footer.endRefreshing()
                }else{
                    controller.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            }else{
               self.model =  OrderListModel.init(fromDictionary: resultDic as! NSDictionary)
                if self.model.hasNext != nil && self.model.hasNext == true {
                    if controller.tableView.mj_footer == nil {
                        controller.setUpLoadMoreData()
                    }
                }
                if controller.tableView.mj_header != nil {
                    controller.tableView.mj_header.endRefreshing()
                }
            }
            controller.tableView.reloadData()
        }
    }
    
    func changeOrderStatusCancel(model:OrderList, indexPath:NSIndexPath, controller:OrderListViewController){
        let url = "\(OrderChangeShatus)\(model.orderId)/"
        let parameters = ["status":"1"]
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
            let orderList = OrderList.init(fromDictionary: resultDic as! NSDictionary)
            let tempOrder = self.model.orderList[indexPath.section]
            orderList.show = tempOrder.show
            orderList.session = tempOrder.session
            orderList.ticket = tempOrder.ticket
            self.model.orderList[indexPath.section] = orderList
            controller.tableView.reloadSections(NSIndexSet.init(index: indexPath.section), withRowAnimation: .Automatic)
        }
    }
    
    func requestPayInfo(model:OrderList, controller:OrderListViewController){
        self.selectOrder = model
        let url = "\(OrderPayInfo)\(model.orderId)/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let payUrl = PayUrl.init(fromDictionary: resultDic as! NSDictionary)
            model.payUrl = payUrl
            if model.payType == 1 {
                if model.payUrl.alipay == "" {
                    MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS!)
                    return
                }
                AlipaySDK.defaultService().payOrder(model.payUrl.alipay, fromScheme: "LiangPiaoAlipay") { (resultDic) in
                    print("resultDic")
                }
            }else{
                if model.payUrl.wxpay == nil {
                    MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS!)
                    return
                }
                let request = PayReq()
                request.prepayId = model.payUrl.wxpay.prepayid
                request.partnerId = model.payUrl.wxpay.partnerid
                request.package = model.payUrl.wxpay.packageField
                request.nonceStr = model.payUrl.wxpay.noncestr
                request.timeStamp = UInt32(model.payUrl.wxpay.timestamp)!
                request.sign = model.payUrl.wxpay.sign
                WXApi.sendReq(request)
            }
        }
    }
    
    func changeOrderStatusPay(model:OrderList, indexPath:NSIndexPath, controller:OrderListViewController){
        let url = "\(OrderChangeShatus)\(model.orderId)/"
        let parameters = ["status":"3"]
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
            let orderList = OrderList.init(fromDictionary: resultDic as! NSDictionary)
            let tempOrder = self.model.orderList[indexPath.section]
            orderList.show = tempOrder.show
            orderList.session = tempOrder.session
            orderList.ticket = tempOrder.ticket
            self.model.orderList[indexPath.section] = orderList
            controller.tableView.reloadSections(NSIndexSet.init(index: indexPath.section), withRowAnimation: .Automatic)
        }
    }
}
