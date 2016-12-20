//
//  MyTicketPutUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MyTicketPutUpViewModel: NSObject {

    var ticketNumber:NSInteger = 0
    var ticketShowModel:TicketShowModel!
    var selectSession:NSInteger = 100
    var tempList:[TicketList]!
    var sesstionModels = NSMutableArray()
    var temListArray = NSMutableArray()
    var ticketMuch:String!
    var ticketSellCount:String!
    var ticketSession:String!
    var ticketSoldCount:String!
    var ticketSoldMuch:String!
    var ticketDic:NSMutableDictionary!
    var controller:MyTicketPutUpViewController!
    
    var ticketPriceArray = NSMutableArray()
    var ticketRowArray = NSMutableArray()
    
    override init() {
        super.init()
    }
    
    func getPriceArray(array:[TicketList]){
        ticketPriceArray.removeAllObjects()
        let sortArray = array.sort { (oldList, newList) -> Bool in
            return oldList.originalTicket.price < newList.originalTicket.price
        }
        var minPrice = 0
        for list in sortArray {
            if minPrice < list.originalTicket.price {
                ticketPriceArray.addObject(list.originalTicket.name)
                minPrice = list.originalTicket.price
            }
        }
    }
    
    func getRowArray(array:[TicketList]){
        ticketRowArray.removeAllObjects()
        let arrays = NSMutableArray()
        for array in array {
            if array.region != "" {
                arrays.addObject("\(array.region) \(array.row)排")
            }
        }
        let set = NSSet(array: arrays as [AnyObject])
        let sortDec = NSSortDescriptor.init(key: nil, ascending: true)
        ticketRowArray = NSMutableArray.init(array: set.sortedArrayUsingDescriptors([sortDec]))
    }
    
    func tableViewHeight(row:Int) -> CGFloat
    {
        switch row {
        case 0:
            return 188
        case 1:
            if ticketShowModel.sessionCount == 1 {
                return 0.00000001
            }
            return 90
        case 2:
            return 42
        default:
            return 60
        }
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func tableViewnumberOfRowsInSection(section:Int) -> Int{
        if sesstionModels.count != 0 || ticketShowModel.sessionCount == 1 {
            if ticketShowModel.sessionCount == 1 {
                return self.ticketShowModel.sessionList[0].ticketList.count + 3
            }
            return self.ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList.count + 3
        }
        return 0
    }
    
    func tableViewCellTickerInfoTableViewCell(cell:TiketPickeUpInfoTableViewCell, indexPath:NSIndexPath) {
        if ticketShowModel.sessionCount != 1 {
            let ticketList = self.ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList
            cell.setData(ticketList[indexPath.row - 3])
            if temListArray[self.selectSession] as! NSObject == 0 {
                temListArray.replaceObjectAtIndex(self.selectSession, withObject: ticketList)
            }
        }else{
            cell.setData(ticketShowModel.sessionList[0].ticketList[indexPath.row - 3])
        }
    }
    
    func tableViewCellPickUpTickeTableViewCell(cell:PickUpTickeTableViewCell) {
        if ticketShowModel.sessionCount == 1 {
            cell.hiddenLindeLabel()
        }
        cell.setData(ticketShowModel, session: ticketSession, sellCount: self.ticketSellCount, soldCount: self.ticketSoldCount, soldMuch: ticketSoldMuch)
    }
    
    func tableViewCellPicketUpSessionTableViewCell(cell:PicketUpSessionTableViewCell) {
        if ticketShowModel.sessionCount != 1 {
            cell.setUpDataAarray(self.getSessionTitle(sesstionModels), selectArray: self.getSessionType(sesstionModels))
            cell.picketUpSessionClouse = { tag in
                if self.ticketDic.objectForKey("\(tag)") == nil {
                    self.connectService()
                }else {
                    self.controller.hiderTicketToolsView()
                    self.selectSession = tag
                    if self.temListArray[self.selectSession] is [TicketList] {
                        self.tempList = self.temListArray[self.selectSession] as! [TicketList]
                    }else{
                        self.tempList = self.getTicketList(ShowSessionModel.init(fromDictionary: self.sesstionModels.objectAtIndex(self.selectSession) as! NSDictionary))
                    }
                    self.getPriceArray(self.tempList)
                    self.getRowArray(self.tempList)
                    self.controller.tableView.reloadData()
                }
            }
        }
    }

    
    func requestTicketSession(){
        BaseNetWorke.sharedInstance.getUrlWithString("\(TickeSession)\(ticketShowModel.id)/session/", parameters: nil).subscribeNext { (resultDic) in
            self.sesstionModels = NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.setSelectSession()
            self.controller.tableView.reloadData()
        }
    }

    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath) {
        if indexPath.row == 0 {
            let tempShowModel = self.ticketShowModel
            tempShowModel.session = self.ticketShowModel.sessionList[0]
            if ticketShowModel.sessionCount == 1 {
                let controllerVC = TicketDescriptionViewController()
                controllerVC.viewModel.ticketModel = tempShowModel
                NavigationPushView(controller, toConroller: controllerVC)
            }else{
                let controllerVC = TicketSceneViewController()
                controllerVC.viewModel.model = tempShowModel
                NavigationPushView(controller, toConroller: controllerVC)
            }
        }else if indexPath.row > 2 {
            self.connectService()
        }
    }
    
    func connectService(){
        UIAlertController.shwoAlertControl(self.controller, style: .Alert, title: "暂时请联系客服帮忙操作", message: nil, cancel: "稍等一会", doneTitle: "联系客服", cancelAction:{
            
            }, doneAction: {
                AppCallViewShow(self.controller.view, phone: "400-873-8011")
        })
    }
    
    func oneSession(){
        self.selectSession = 0
        ticketDic = NSMutableDictionary()
        ticketDic.setValue(0, forKey: "0")
        self.tempList = self.ticketShowModel.sessionList[0].ticketList
        self.getRowArray(self.tempList)
        self.getPriceArray(self.tempList)
    }
    
    func setSelectSession(){
        ticketDic = NSMutableDictionary()
        for _ in 0...self.sesstionModels.count - 1 {
            temListArray.addObject(0)
        }
        var ticketListIndex:NSInteger = 0
        for ticketSession in ticketShowModel.sessionList {
            for index in 0...self.sesstionModels.count - 1 {
                let session = ShowSessionModel.init(fromDictionary: self.sesstionModels[index] as! NSDictionary)
                if session.id ==  ticketSession.id {
                    ticketDic.setValue(ticketListIndex, forKey: "\(index)")
                    ticketListIndex = ticketListIndex + 1
                    if self.selectSession == 100 {
                        self.selectSession = index
                        if self.temListArray[self.selectSession] is [TicketList] {
                            self.tempList = self.temListArray[self.selectSession] as! [TicketList]
                        }else{
                            self.tempList = self.getTicketList(ShowSessionModel.init(fromDictionary: self.sesstionModels.objectAtIndex(self.selectSession) as! NSDictionary))
                        }
                        self.getPriceArray(self.tempList)
                        self.getRowArray(self.tempList)
                    }
                }
            }
        }
    }
    
    func getSessionTitle(showSessions:NSMutableArray) -> NSMutableArray{
        let sessionTitle = NSMutableArray()
        for session in showSessions {
            let session = ShowSessionModel.init(fromDictionary: session as! NSDictionary)
            sessionTitle.addObject("\(session.name) ")
        }
        return sessionTitle
    }
    
    func getSessionType(showSessions:NSMutableArray) -> NSMutableArray{
        let sessionTypes = NSMutableArray.init(capacity: showSessions.count)
        for _ in 0...showSessions.count - 1 {
            sessionTypes.addObject(0)
        }
        var isSelect = false
        for ticketSession in ticketShowModel.sessionList {
            for index in 0...showSessions.count - 1 {
                let session = ShowSessionModel.init(fromDictionary: showSessions[index] as! NSDictionary)
                if session.id ==  ticketSession.id {
                    if !isSelect {
                        sessionTypes.replaceObjectAtIndex(index, withObject: 1)
                        isSelect = true
                    }else{
                        sessionTypes.replaceObjectAtIndex(index, withObject: 2)
                    }
                    break;
                }
            }
        }
        return sessionTypes
    }
    
    func getTicketNumber(indexPath:NSIndexPath) -> Int {
        let ticketModel = ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList[indexPath.row - 4]
        if self.ticketNumber > ticketModel.remainCount {
            return ticketModel.remainCount
        }else{
            return self.ticketNumber
        }
    }
    
    func getMuchOfTicket(indexPath:NSIndexPath) -> String {
        let ticketModel = ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList[indexPath.row - 4]
        let str = "\(self.getTicketNumber(indexPath) * ticketModel.price)"
        return str
    }
    
    func getTicketList(model:ShowSessionModel) -> [TicketList] {
        var ticketList:[TicketList] = []
        for session in ticketShowModel.sessionList {
            if session.id == model.id {
                ticketList.appendContentsOf(session.ticketList)
            }
        }
        return ticketList
    }
    
    func sortTicket(type:TicketSortType){
        switch type {
        case .noneType,.upType:
            let tickesList = ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList
            self.ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price < upList.price
            })
        default:
            let tickesList = ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList
            self.ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = tickesList.sort({ (downList, upList) -> Bool in
                return downList.price > upList.price
            })
        }
        self.controller.tableView.reloadData()
    }
    
    func sortTickeByOriginTicketPrice(price:String?) {
        if price == "0" {
            ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = tempList
        }else{
            var sortArrayList:[TicketList] = []
            for tickeModel in tempList {
                if tickeModel.originalTicket.name == price {
                    sortArrayList.append(tickeModel)
                }
            }
            ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = sortArrayList
        }
        self.controller.tableView.reloadData()
    }
    
    func sortTickeByRowTicketPrice(ticketRow:String?) {
        if ticketRow == "0" {
            ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = tempList
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
            ticketShowModel.sessionList[Int(ticketDic.objectForKey("\(self.selectSession)") as! NSInteger)].ticketList = sortArrayList
            self.controller.tableView.reloadData()
        }
    }
}
