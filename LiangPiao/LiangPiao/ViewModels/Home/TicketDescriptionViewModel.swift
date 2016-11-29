//
//  TicketDescriptionViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 21/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TicketDescriptionViewModel: NSObject {

    var ticketModel:HomeTicketModel!
    var model:TicketDescriptionModel!
    var ticketNumber:NSInteger = 1
    var tempList:[TicketList]!
    
    var ticketPriceArray:NSArray = NSArray()
    var ticketRowArray:NSArray = NSArray()
    
    override init() {
        super.init()
    }
    
    func getPriceArray(array:[TicketList]){
        let arrays = NSMutableArray()
        for array in array {
            arrays.addObject(array.originalTicket.price)
        }
        let set = NSSet(array: arrays as [AnyObject])
        let sortDec = NSSortDescriptor.init(key: nil, ascending: true)
        ticketPriceArray = set.sortedArrayUsingDescriptors([sortDec])
    }
    
    func getRowArray(array:[TicketList]){
        let arrays = NSMutableArray()
        for array in array {
            if array.region != "" {
                arrays.addObject("\(array.region) \(array.row)排")
            }
        }
        let set = NSSet(array: arrays as [AnyObject])
        let sortDec = NSSortDescriptor.init(key: nil, ascending: true)
        ticketRowArray = set.sortedArrayUsingDescriptors([sortDec])
    }
    
    func tableViewHeight(row:Int) -> CGFloat
    {
        switch row {
        case 0:
            return 188
        case 1:
            return 80
        case 2:
            return 0.00000000001
        case 3:
            return 42
        default:
            return 60
        }
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func tableViewnumberOfRowsInSection(section:Int) -> Int{
        if self.model != nil{
            return self.model.ticketList.count + 4
        }
        return 0
    }
    
    func configCellTicketDescripTableViewCell(cell:TicketDescripTableViewCell) {
        if model != nil {
            cell.setData(model.show,sessionModel: model.session)
        }
    }
    
    func configCellTickerInfoTableViewCell(cell:TickerInfoTableViewCell, indexPath:NSIndexPath) {
        if model != nil {
            cell.setData(model.ticketList[indexPath.row - 4])
        }
    }
    
    func configCellTicketNumberTableViewCell(cell:TicketNumberTableViewCell){
        cell.numberTickView.numberLabel.rac_observeKeyPath("text", options: .New, observer: nil) { (object, objects,isNew, isOld) in
            self.ticketNumber = NSInteger(object as! String)!
        }
    }
    
    func requestTicketSession(tableView:UITableView){
        let url = "\(TickeSession)\(ticketModel.id)/session/\(ticketModel.id)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.model = TicketDescriptionModel.init(fromDictionary: resultDic as! NSDictionary)
            self.tempList = self.model.ticketList
            self.getPriceArray(self.tempList)
            self.getRowArray(self.tempList)
            tableView.reloadData()
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(controller:TicketDescriptionViewController, indexPath:NSIndexPath) {
        if indexPath.row > 3 {
            let ticketModel = self.model.ticketList[indexPath.row - 4]
            if ticketModel.sellType == 2 && ticketModel.remainCount > self.ticketNumber {
                UIAlertController.shwoAlertControl(controller, title: nil, message: "该票种须打包\(ticketModel.remainCount)张一起购买哦", cancel: "取消", doneTitle: "继续购买", cancelAction: {
                    
                    }, doneAction: {
                     self.ticketNumber = ticketModel.remainCount
                     self.pushTicketDescription(controller, indexPath: indexPath)
                })
            }else{
                self.pushTicketDescription(controller, indexPath: indexPath)
            }
            
        }
    }
    
    
    func pushTicketDescription(controller:TicketDescriptionViewController, indexPath:NSIndexPath){
        let controllerVC = TicketConfirmViewController()
        controllerVC.viewModel.model = self.model
        controllerVC.viewModel.ticketModel = self.model.ticketList[indexPath.row - 4]
        controllerVC.viewModel.ticketCount = self.getTicketNumber(indexPath)
        controllerVC.viewModel.muchOfTicket = self.getMuchOfTicket(indexPath)
        NavigationPushView(controller, toConroller: controllerVC)
    }
    
    func getTicketNumber(indexPath:NSIndexPath) -> Int {
        let ticketModel = self.model.ticketList[indexPath.row - 4]
        if self.ticketNumber > ticketModel.remainCount {
            return ticketModel.remainCount
        }else{
            return self.ticketNumber
        }
    }
    
    func getMuchOfTicket(indexPath:NSIndexPath) -> String {
        let ticketModel = self.model.ticketList[indexPath.row - 4]
        let str = "\(self.getTicketNumber(indexPath) * ticketModel.price)"
        return str
    }
    
    
    func sortTicket(controller:TicketDescriptionViewController, type:TicketSortType){
        switch type {
        case .noneType,.upType:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price < upList.price
            })
        default:
            let tickesList = self.model.ticketList
            self.model.ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price > upList.price
            })
        }
        controller.tableView.reloadData()
    }
    
    func sortTickeByOriginTicketPrice(price:NSNumber?, controller:TicketDescriptionViewController) {
        var sortArrayList:[TicketList] = []
        for tickeModel in tempList {
            if tickeModel.originalTicket.price == Int(price!) {
                sortArrayList.append(tickeModel)
            }
        }
        self.model.ticketList = sortArrayList
        controller.tableView.reloadData()
    }
    
    func sortTickeByRowTicketPrice(ticketRow:String?, controller:TicketDescriptionViewController) {
        var sortArrayList:[TicketList] = []
        for tickeModel in tempList {
            var rowStr = ""
            if tickeModel.region != "" {
                rowStr = "\(tickeModel.region) \(tickeModel.row)排"
            }
            if rowStr == ticketRow {
                sortArrayList.append(tickeModel)
            }
        }
        self.model.ticketList = sortArrayList
        controller.tableView.reloadData()
    }
}
