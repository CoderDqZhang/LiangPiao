//
//  MyTicketPutUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyTicketPutUpViewModel: NSObject {

    var ticketModel:HomeTicketModel!
    var model:TicketDescriptionModel!
    var ticketNumber:NSInteger = 1
    var tempList:[TicketList]!
    var sesstionModel:TicketSessionModel!
    
    var ticketPriceArray:NSArray = NSArray()
    var ticketRowArray:NSArray = NSArray()
    
    override init() {
        super.init()
    }
    
    func getPriceArray(array:[TicketList]){
        let arrays = NSMutableArray()
        for array in array {
            arrays.addObject(array.originalTicket.name)
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
            return 90
        case 2:
            return 42
        default:
//            if self.model.ticketList.count == 0 {
//                return SCREENHEIGHT - 374
//            }
            return 60
        }
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    
    
    func tableViewnumberOfRowsInSection(section:Int) -> Int{
//        if self.model != nil{
//            if self.model.ticketList.count == 0 {
//                return 5
//            }
//            return self.model.ticketList.count + 4
//        }
        return 20
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
        cell.numberTickView.numberTextField.rac_observeKeyPath("text", options: .New, observer: nil) { (object, objects,isNew, isOld) in
            self.ticketNumber = NSInteger(object as! String)!
        }
    }
    
    func requestTicketSession(controller:MyTicketPutUpViewController){
        var url = ""
        if sesstionModel != nil {
            url = "\(TickeSession)\(ticketModel.id)/session/\(sesstionModel.id)"
        }else if ticketModel.session != nil {
            url = "\(TickeSession)\(ticketModel.id)/session/\(ticketModel.session.id)"
        }
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.model = TicketDescriptionModel.init(fromDictionary: resultDic as! NSDictionary)
            self.tempList = self.model.ticketList
            self.getPriceArray(self.tempList)
            self.getRowArray(self.tempList)
            
            controller.tableView.reloadData()
            controller.updataLikeImage()
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(controller:MyTicketPutUpViewController, indexPath:NSIndexPath) {
        
    }
    
    
    func pushTicketDescription(controller:MyTicketPutUpViewController, indexPath:NSIndexPath){
        
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
    
    
    func sortTicket(controller:MyTicketPutUpViewController, type:TicketSortType){
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
    
    func sortTickeByOriginTicketPrice(price:String?, controller:MyTicketPutUpViewController) {
        if price == "0" {
            self.model.ticketList = tempList
        }else{
            var sortArrayList:[TicketList] = []
            for tickeModel in tempList {
                if tickeModel.originalTicket.name == price {
                    sortArrayList.append(tickeModel)
                }
            }
            self.model.ticketList = sortArrayList
        }
        controller.tableView.reloadData()
    }
    
    func sortTickeByRowTicketPrice(ticketRow:String?, controller:MyTicketPutUpViewController) {
        if ticketRow == "0" {
            self.model.ticketList = tempList
        }else{
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
}
