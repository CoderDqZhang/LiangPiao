//
//  OrderListViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderListViewModel: NSObject {

    var model:OrderListModel!
    var orderTypeArrays:[OrderType] = [.orderDone,.orderWaitPay]
    
    override init() {
        
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
            NavigationPushView(controller, toConroller: controllerVC)
            
        }
    }
    
    func tableViewOrderCellIndexPath(indexPath:NSIndexPath, cell:OrderNumberTableViewCell) {
        cell.setData(model.orderList[indexPath.section])
    }
    
    func tableViewOrderTicketInfoCellIndexPath(indexPath:NSIndexPath, cell:OrderTicketInfoTableViewCell) {
        cell.setData(model.orderList[indexPath.section])
    }
    
    func tableViewOrderHandleCellIndexPath(indexPath:NSIndexPath, cell:OrderHandleTableViewCell) {
        
    }
    
    func requestOrderList(controller:OrderListViewController, isNext:Bool){
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
    
}
