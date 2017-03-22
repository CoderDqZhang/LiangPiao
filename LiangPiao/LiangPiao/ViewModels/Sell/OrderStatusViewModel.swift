//
//  OrderStatusViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias ReloadeMySellOrderList = (indexPath:NSIndexPath, model:OrderList) -> Void

class OrderStatusViewModel: NSObject {

    let cellHeight = [[112,107],[49,149,119,52]]
    let cellCancelHeight = [49,149,119,52]
    var model:OrderList!
    var deverliyModel:DeverliyModel!
    var controller:OrderStatusViewController!
    var selectIndexPath:NSIndexPath!
    var reloadeMySellOrderList:ReloadeMySellOrderList!
    
    override init() {
        
    }
    
    func getDeverliyTrac(){
        if model.expressInfo != nil && model.expressInfo.expressName != nil && model.expressInfo.expressNum != nil {
            let dics = ["RequestData":["LogisticCode":model.expressInfo.expressNum,"ShipperCode":model.expressInfo.expressName],"DataType":"2","RequestType":"1002","EBusinessID":ExpressDelivierEBusinessID,"key":ExpressDelivierKey]
            
            ExpressDeliveryNet.shareInstance().requestExpressDelivreyNetOrder(dics as [NSObject : AnyObject], url: ExpressOrderHandleUrl).subscribeNext { (resultDic) in
                self.deverliyModel = DeverliyModel.init(fromDictionary: resultDic as! NSDictionary)
                self.deverliyModel.traces = self.deverliyModel.traces.reverse()
                dispatch_async(dispatch_get_main_queue(), {
                    self.controller.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
                })
            }
        }
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
                return 3
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
                case 1:
                    return controller.tableView.fd_heightForCellWithIdentifier("ReciveAddressTableViewCell", configuration: { (cell) in
                        self.configCell(cell as! ReciveAddressTableViewCell, indexPath: indexPath)
                    })
                default:
                    if self.deverliyModel != nil {
                        return controller.tableView.fd_heightForCellWithIdentifier("DeverliyTableViewCellSellDetail", configuration: { (cell) in
                            self.configCellDeverliyTableViewCell(cell as! DeverliyTableViewCell, indexPath: indexPath)
                        })
                    }
                    return 0
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
    
    func configCellDeverliyTableViewCell(cell:DeverliyTableViewCell, indexPath:NSIndexPath) {
        if self.deverliyModel.traces.count > 0 {
            cell.setUpData(self.deverliyModel.traces[0])
        }
    }
    
    func configCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(model)
    }
    
    func isCancel() ->Bool {
        var ret = true
        if model.status == 0 || model.status == 3 || model.status == 7 || model.status == 9 || model.status == 10 || model.status == 8 {
            ret =  false
        }
        return ret
    }
    
    func tableViewCellOrderStatusTableViewCell(cell:OrderStatusTableViewCell, indexPath:NSIndexPath) {
        cell.setData("\(model.status)", statusType: "")
    }
    
    func tableViewCellDeverliyTableViewCell(cell:DeverliyTableViewCell, indexPath:NSIndexPath) {
        if self.deverliyModel != nil {
            cell.setUpData(self.deverliyModel.traces[0])
        }
    }
    
    func tableViewCellReciveAddressTableViewCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        self.configCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderTicketInfoTableViewCell(cell:OrderTicketInfoTableViewCell, indexPath:NSIndexPath){
        cell.setSellData(model)
    }
    
    func tableViewCellOrderNumberTableViewCell(cell:OrderNumberTableViewCell, indexPath:NSIndexPath) {
        cell.setSellData(model)
    }
    
    func tableViewCellOrderPayTableViewCell(cell:OrderPayTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(cell:OrderStatusMuchTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func orderStatusTableViewDidSelect(tableView:UITableView, indexPath:NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            let controllerVC = LogisticsTrackingViewController()
            controllerVC.viewModel.deverliyModel = self.deverliyModel
            controllerVC.viewModel.model = self.model
            NavigationPushView(self.controller, toConroller: controllerVC)
        }
    }
    
    func requestOrderStatusChange(){
        let deverliyController = DelivererPushViewController()
        deverliyController.viewModel.model = self.model
        deverliyController.viewModel.indexPath = self.selectIndexPath
        deverliyController.viewModel.reloadeMyOrderDeatail = { indexPath, model in
            self.controller.tableView.reloadData()
            if self.reloadeMySellOrderList != nil {
                self.controller.updateTableView(model.status)
                self.reloadeMySellOrderList(indexPath: self.selectIndexPath, model: model)
            }
        }
        NavigationPushView(self.controller, toConroller: deverliyController)
    }
}
