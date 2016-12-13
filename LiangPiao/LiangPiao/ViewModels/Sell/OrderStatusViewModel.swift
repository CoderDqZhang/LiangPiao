//
//  OrderStatusViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderStatusViewModel: NSObject {

    let cellHeight = [[112,107],[49,149,119,52]]
    let cellCancelHeight = [49,149,119,52]
    var model:OrderList!
    var controller:OrderStatusViewController!
    
    override init() {
        
    }
    
    func numberOfSection() ->Int {
        if !self.isCancel() {
            return 2
        }
        return 1
    }
    
    func numbrOfRowInSection(section:Int) ->Int {
        if !isCancel() {
            switch section {
            case 0:
                return 2
            default:
                return 4
            }
        }
        return 4
    }
    
    func tableViewFooterViewHeight(section:Int) ->CGFloat{
        if !isCancel() {
            switch section {
            case 0:
                return 10
            default:
                return 100
            }
        }
        return 100
    }
    
    func tableViewHeightForRow(indexPath:NSIndexPath) ->CGFloat {
        if !isCancel() {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    return 112
                default:
                    return controller.tableView.fd_heightForCellWithIdentifier("ReciveAddressTableViewCell", configuration: { (cell) in
                        self.configCell(cell as! ReciveAddressTableViewCell, indexPath: indexPath)
                    })
                }
            default:
                switch indexPath.row {
                case 0:
                    return 49
                case 1:
                    return 149
                case 2:
                    return 119
                case 3:
                    return 52
                default:
                    return 52
                }
            }
        }
        return CGFloat(cellCancelHeight[indexPath.row])
    }
    
    func configCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(model)
    }
    
    func isCancel() ->Bool {
        var ret = true
        if model.status == 0 || model.status == 3 || model.status == 7 || model.status == 9 || model.status == 10 {
            ret =  false
        }
        return ret
    }
    
    func tableViewCellOrderStatusTableViewCell(cell:OrderStatusTableViewCell, indexPath:NSIndexPath) {
        cell.setData("\(model.status)", statusType: "")
    }
    
    
    func tableViewCellReciveAddressTableViewCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        self.configCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderTicketInfoTableViewCell(cell:OrderTicketInfoTableViewCell, indexPath:NSIndexPath){
        cell.setSellData(model)
    }
    
    func tableViewCellOrderNumberTableViewCell(cell:OrderNumberTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func tableViewCellOrderPayTableViewCell(cell:OrderPayTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(cell:OrderStatusMuchTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func requestOrderStatusChange(){
        if model.status == 9 {
            UIAlertController.shwoAlertControl(self.controller, title: "是否结算", message: nil, cancel: "取消", doneTitle: "确认收货", cancelAction: {
                
                }, doneAction: {
                    let url = "\(OrderChangeShatus)\(self.model.orderId)/"
                    let parameters = ["status":"10"]
                    BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
                        let tempModel = OrderList.init(fromDictionary: resultDic as! NSDictionary)
                        self.model.status = tempModel.status
                        self.model.statusDesc = tempModel.statusDesc
                        self.controller.updateTableView(self.model.status)
                        self.controller.tableView.reloadData()
                    }
            })
        }else{
            let url = "\(OrderChangeShatus)\(self.model.orderId)/"
            let parameters = ["status":"7"]
            BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
                let tempModel = OrderList.init(fromDictionary: resultDic as! NSDictionary)
                self.model.status = tempModel.status
                self.model.statusDesc = tempModel.statusDesc
                self.controller.updateTableView(self.model.status)
                self.controller.tableView.reloadData()
            }
        }
        
    }
}
