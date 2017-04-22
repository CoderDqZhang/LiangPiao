//
//  OrderStatusViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 13/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias ReloadeMySellOrderList = (_ indexPath:IndexPath, _ model:OrderList) -> Void

class OrderStatusViewModel: NSObject {

    let cellHeight = [[112,107],[49,149,119,52]]
    let cellCancelHeight = [49,149,119,52]
    var model:OrderList!
    var deverliyModel:DeverliyModel!
    var controller:OrderStatusViewController!
    var selectIndexPath:IndexPath!
    var templeTrace:Trace!
    var reloadeMySellOrderList:ReloadeMySellOrderList!
    
    override init() {
        
    }
    
    func getDeverliyTrac(){
        if model.expressInfo != nil && model.expressInfo.expressName != nil && model.expressInfo.expressNum != nil {
            let dics = ["RequestData":["LogisticCode":model.expressInfo.expressNum,"ShipperCode":model.expressInfo.expressName],"DataType":"2","RequestType":"1002","EBusinessID":ExpressDelivierEBusinessID,"key":ExpressDelivierKey] as [String : Any]
            
            ExpressDeliveryNet.shareInstance().requestExpressDelivreyNetOrder(dics as [AnyHashable: Any], url: ExpressOrderHandleUrl, clouse: { (resultDic) in
                self.deverliyModel = DeverliyModel.init(fromDictionary: resultDic! as NSDictionary)
                self.deverliyModel.traces = self.deverliyModel.traces.reversed()
                if self.deverliyModel.traces.count == 0 {
                    var acceptionName = ""
                    for name in deverliyDic.allKeys {
                        if deverliyDic[name as! String] as! String == self.model.expressInfo.expressName as String {
                            acceptionName = name as! String
                        }
                    }
                    let dic:NSDictionary = ["AcceptStation":acceptionName,"AcceptTime":"物流编号：\((self.model.expressInfo.expressNum)!)"]
                    self.templeTrace = Trace.init(fromDictionary: dic)
                    self.deverliyModel.traces.append(self.templeTrace)
                }
                DispatchQueue.main.async(execute: {
                    self.controller.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                })
            })
        }
    }
    
    func numberOfSection() ->Int {
        if !self.isCancel() {
            return 2
        }
        return 1
    }
    
    func numbrOfRowInSection(_ section:Int) ->Int {
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
    
    func tableViewFooterViewHeight(_ section:Int) ->CGFloat{
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
    
    func tableViewHeightForRow(_ indexPath:IndexPath) ->CGFloat {
        if !isCancel() {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    return 112
                case 1:
                    return controller.tableView.fd_heightForCell(withIdentifier: "ReciveAddressTableViewCell", configuration: { (cell) in
                        self.configCell(cell as! ReciveAddressTableViewCell, indexPath: indexPath)
                    })
                default:
                    if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
                        return controller.tableView.fd_heightForCell(withIdentifier: "DeverliyTableViewCellSellDetail", configuration: { (cell) in
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
    
    func configCellDeverliyTableViewCell(_ cell:DeverliyTableViewCell, indexPath:IndexPath) {
        if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
            cell.setUpData(self.deverliyModel.traces[0])
        }
    }
    
    func configCell(_ cell:ReciveAddressTableViewCell, indexPath:IndexPath) {
        cell.setUpData(model)
    }
    
    func isCancel() ->Bool {
        var ret = true
        if model.status == 0 || model.status == 3 || model.status == 7 || model.status == 9 || model.status == 10 || model.status == 8 {
            ret =  false
        }
        return ret
    }
    
    func tableViewCellOrderStatusTableViewCell(_ cell:OrderStatusTableViewCell, indexPath:IndexPath) {
        cell.setData("\((model.status)!)", statusType: "")
    }
    
    func tableViewCellDeverliyTableViewCell(_ cell:DeverliyTableViewCell, indexPath:IndexPath) {
        self.configCellDeverliyTableViewCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellReciveAddressTableViewCell(_ cell:ReciveAddressTableViewCell, indexPath:IndexPath) {
        self.configCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderTicketInfoTableViewCell(_ cell:OrderTicketInfoTableViewCell, indexPath:IndexPath){
        cell.setSellData(model)
    }
    
    func tableViewCellOrderNumberTableViewCell(_ cell:OrderNumberTableViewCell, indexPath:IndexPath) {
        cell.setSellData(model)
    }
    
    func tableViewCellOrderPayTableViewCell(_ cell:OrderPayTableViewCell, indexPath:IndexPath) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(_ cell:OrderStatusMuchTableViewCell, indexPath:IndexPath) {
        cell.setData(model)
    }
    
    func orderStatusTableViewDidSelect(_ tableView:UITableView, indexPath:IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            let controllerVC = LogisticsTrackingViewController()
            let tempDeverliyModel = self.deverliyModel
            if self.deverliyModel.traces.count == 1 {
                if templeTrace != nil && self.deverliyModel.traces[0] == templeTrace {
                    tempDeverliyModel?.traces.removeAll()
                }
            }
            controllerVC.viewModel.deverliyModel = tempDeverliyModel
            controllerVC.viewModel.model = self.model
            NavigationPushView(self.controller, toConroller: controllerVC)
        }
    }
    
    func requestOrderStatusChange(){
        if (self.model.deliveryType == 4){
            let deverliyController = DelivererPushViewController()
            deverliyController.viewModel.model = self.model
            deverliyController.viewModel.indexPath = self.selectIndexPath
            deverliyController.viewModel.reloadeMyOrderDeatail = { indexPath, model in
                self.controller.tableView.reloadData()
                if self.reloadeMySellOrderList != nil {
                    self.controller.updateTableView(model.status)
                    self.reloadeMySellOrderList(self.selectIndexPath, model)
                }
            }
            NavigationPushView(self.controller, toConroller: deverliyController)
        }else{
            let url = "\(OrderChangeShatus)\((self.model.orderId)!)/"
            let parameters = ["status":"7"]
            BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let tempModel = OrderList.init(fromDictionary: resultDic.value as! NSDictionary)
                    self.model.status = tempModel.status
                    self.model.statusDesc = tempModel.statusDesc
                    self.model.supplierStatusDesc = tempModel.supplierStatusDesc
                    self.controller.updateTableView(self.model.status)
                    if self.reloadeMySellOrderList != nil {
                        self.reloadeMySellOrderList(self.selectIndexPath, self.model)
                    }
                }
            }
        }
    }
}
