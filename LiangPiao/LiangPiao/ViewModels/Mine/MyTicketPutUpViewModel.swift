//
//  MyTicketPutUpViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 05/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

typealias MyTicketPutUpViewModelClouse = (ticketShow:TicketShowModel) -> Void

class MyTicketPutUpViewModel: NSObject {

    var ticketNumber:NSInteger = 0
    var ticketShowModel:TicketShowModel!
    var selectSession:NSInteger = 100
    var tempList:[TicketList]!
    var sesstionModels = [ShowSessionModel]()
    var tempSessionModel = NSMutableArray()
    var temListArray = NSMutableArray()
    var ticketMuch:String!
    var ticketSellCount:String!
    var ticketSession:String!
    var ticketSoldCount:String!
    var ticketSoldMuch:String!
    var ticketDic:NSMutableDictionary!
    var controller:MyTicketPutUpViewController!
    var picketCell:PicketUpSessionTableViewCell!
    var tempSelect:NSInteger = 100
    var ticketPriceArray = NSMutableArray()
    var ticketRowArray = NSMutableArray()
    var isSellTicketVC:Bool = false
    var myTicketPutUpViewModelClouse:MyTicketPutUpViewModelClouse!
    
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
            if list.originalTicket.price != nil {
                if minPrice < list.originalTicket.price {
                    ticketPriceArray.addObject(list.originalTicket.name)
                    minPrice = list.originalTicket.price
                }
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
            if ticketShowModel.sessionList.count == 1 {
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
            if ticketShowModel.sessionList.count == 1 {
                return self.ticketShowModel.sessionList[0].ticketList.count + 3
            }
            if self.selectSession == 100 {
                self.selectSession = 0
            }
            return self.sesstionModels[self.selectSession].ticketList.count + 3
        }
        return 0
    }
    
    func tableViewCellTickerInfoTableViewCell(cell:TiketPickeUpInfoTableViewCell, indexPath:NSIndexPath) {
        if ticketShowModel.sessionCount != 1 {
            let ticketList = self.ticketShowModel.sessionList[self.selectSession].ticketList
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
        picketCell = cell
        if ticketShowModel.sessionList.count != 1 {
            picketCell.setUpDataAarray(self.getSessionTitle(sesstionModels), selectArray: self.getSessionType(sesstionModels))
            picketCell.picketUpSessionClouse = { tag in
                if self.ticketShowModel.sessionList[tag].ticketList.count == 0 {
                    UIAlertController.shwoAlertControl(self.controller, style: .Alert, title: "当前场次未挂票，是否添加", message: nil, cancel: "取消", doneTitle: "立即添加", cancelAction: {
                        
                        }, doneAction: {
                            if self.isSellTicketVC {
                                self.controller.popSellTicketVC()
                            }else{
                                self.continuePutUpTicket(self.sesstionModels[tag],isNoneTicket: true)
                                self.tempSelect = tag
                            }
                    })
                }else {
                    self.controller.hiderTicketToolsView()
                    self.selectSession = tag
                    if self.temListArray[self.selectSession] is [TicketList] {
                        self.tempList = self.temListArray[self.selectSession] as! [TicketList]
                    }else{
                        self.tempList = self.getTicketList(self.sesstionModels[self.selectSession])
                    }
                    self.getPriceArray(self.tempList)
                    self.getRowArray(self.tempList)
                    self.controller.tableView.reloadData()
                }
            }
        }
    }

    
    func requestTicketSession(){
        let tempSession = ticketShowModel.sessionList
        BaseNetWorke.sharedInstance.getUrlWithString("\(TickeSession)\(ticketShowModel.id)/session/", parameters: nil).subscribeNext { (resultDic) in
            self.tempSessionModel = NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            for model in self.tempSessionModel {
                let sessionModel = ShowSessionModel.init(fromDictionary: model as! NSDictionary)
                for session in tempSession {
                    if session.id == sessionModel.id {
                        sessionModel.ticketList.appendContentsOf(session.ticketList)
                    }
                }
                self.sesstionModels.append(sessionModel)
            }
            self.ticketShowModel.sessionList = self.sesstionModels
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
            self.connectService(self.tempList[indexPath.row - 3], indexPath: indexPath)
        }
    }
    
    func connectService(ticket:TicketList, indexPath:NSIndexPath){
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction.init(title: "取消", style: .Cancel, handler: { (cancelAction) in
            
        }))
        //status 1 正常， 2 卖光了 0 下架
        if ticket.status != 2 {
            if ticket.status == 0 {
                alertController.addAction(UIAlertAction.init(title: "删除", style: .Default, handler: { (up) in
                    self.requestDeleteTicket(ticket, indexPath:indexPath)
                }))
            }
            let str = ticket.status == 1 ? "下架":"上架"
            alertController.addAction(UIAlertAction.init(title: str, style: .Default, handler: { (up) in
                self.requestTicketPutStatus(ticket, indexPath:indexPath)
            }))
        
        }
        
        alertController.addAction(UIAlertAction.init(title: "编辑", style: .Default, handler: { (up) in
            if self.sesstionModels.count == 0 {
                self.editPutUpTicket(self.ticketShowModel.sessionList[0], ticket: ticket, indexPath: indexPath)
            }else{
                self.editPutUpTicket(self.sesstionModels[self.selectSession], ticket: ticket, indexPath: indexPath)
            }
        }))
        
        self.controller.presentViewController(alertController, animated: true) { 
            
        }
    }
    
    func editPutUpTicket(sessionModel:ShowSessionModel, ticket:TicketList, indexPath: NSIndexPath){
        let controllerVC = MySellConfimViewController()
        let tempModel = ticketShowModel
        tempModel.session = sessionModel
        controllerVC.viewModel.model = tempModel
        controllerVC.viewModel.isChange = true
        controllerVC.viewModel.isSellTicketView = false
        controllerVC.viewModel.setUpChangeCellForm(ticket)
        controllerVC.viewModel.mySellConfimViewModelClouse = { ticketModel,originName in
            ticketModel.originalTicket = self.tempList[indexPath.row - 3].originalTicket
            ticketModel.originalTicket.name = originName
            self.tempList[indexPath.row - 3] = ticketModel
            if self.sesstionModels.count == 0 {
                self.ticketShowModel.sessionList[0].ticketList[indexPath.row - 3] = ticketModel
            }else{
                self.ticketShowModel.sessionList[self.selectSession].ticketList[indexPath.row - 3] = ticketModel
            }
            self.controller.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            if self.myTicketPutUpViewModelClouse != nil {
                self.myTicketPutUpViewModelClouse(ticketShow: self.ticketShowModel)
            }
        }
        NavigationPushView(controller, toConroller: controllerVC)
    }
    
    func continuePutUpTicket(sessionModel:ShowSessionModel?, isNoneTicket:Bool){
        let controllerVC = MySellConfimViewController()
        let tempModel = ticketShowModel
        let session:ShowSessionModel!
        if sessionModel == nil {
            session = self.ticketShowModel.sessionList[self.selectSession]
            tempModel.session = session
        }else{
            tempModel.session = sessionModel
        }
        controllerVC.viewModel.isChange = false
        controllerVC.viewModel.isSellTicketView = false
        controllerVC.viewModel.model = tempModel
        controllerVC.viewModel.setUpViewModel()
        controllerVC.viewModel.mySellConfimViewModelAddClouse = { originTicket, ticketModel,originName in
            if isNoneTicket {
                self.tempList.removeAll()
                self.controller.hiderTicketToolsView()
                self.selectSession = self.tempSelect
                ticketModel.originalTicket = originTicket
                self.tempList.append(ticketModel)
                self.ticketShowModel.sessionList[self.selectSession].ticketList = self.tempList
                self.getPriceArray(self.tempList)
                self.getRowArray(self.tempList)
                let session = self.picketCell.viewWithTag(self.selectSession + 10) as! TicketSession
                session.type = 2
                self.picketCell.updateSession(self.selectSession + 10)
                self.controller.tableView.reloadData()
            }else{
                ticketModel.originalTicket = self.tempList[0].originalTicket
                ticketModel.originalTicket.name = originName
                self.tempList.append(ticketModel)
                if self.sesstionModels.count == 0 {
                    self.ticketShowModel.sessionList[0].ticketList.append(ticketModel)
                }else{
                    self.ticketShowModel.sessionList[self.selectSession].ticketList.append(ticketModel)
                }
                self.controller.tableView.insertRowsAtIndexPaths([NSIndexPath.init(forRow: self.tempList.count + 2, inSection: 0)], withRowAnimation: .Automatic)
            }
            if self.myTicketPutUpViewModelClouse != nil {
                self.myTicketPutUpViewModelClouse(ticketShow: self.ticketShowModel)
            }
        }
        NavigationPushView(controller, toConroller: controllerVC)
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
                let session = self.sesstionModels[index]
                if session.id ==  ticketSession.id {
                    ticketDic.setValue(ticketListIndex, forKey: "\(index)")
                    ticketListIndex = ticketListIndex + 1
                    if self.selectSession == 100 {
                        if ticketSession.ticketList.count != 0 {
                            self.selectSession = index
                            if self.temListArray[self.selectSession] is [TicketList] {
                                self.tempList = self.temListArray[self.selectSession] as! [TicketList]
                            }else{
                                self.tempList = self.getTicketList(self.sesstionModels[self.selectSession])
                            }
                            self.getPriceArray(self.tempList)
                            self.getRowArray(self.tempList)
                        }
                    }
                }
            }
        }
    }
    
    func getSessionTitle(showSessions:[ShowSessionModel]) -> NSMutableArray{
        let sessionTitle = NSMutableArray()
        for session in showSessions {
            sessionTitle.addObject("\(session.name) ")
        }
        return sessionTitle
    }
    
    func getSessionType(showSessions:[ShowSessionModel]) -> NSMutableArray{
        let sessionTypes = NSMutableArray.init(capacity: showSessions.count)
        for _ in 0...showSessions.count - 1 {
            sessionTypes.addObject(0)
        }
        for index in 0...ticketShowModel.sessionList.count - 1 {
            if index == self.selectSession {
                sessionTypes.replaceObjectAtIndex(index, withObject: 1)
            }else{
                if ticketShowModel.sessionList[index].ticketList.count != 0 {
                    sessionTypes.replaceObjectAtIndex(index, withObject: 2)
                }else{
                    sessionTypes.replaceObjectAtIndex(index, withObject: 0)
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
    
    func requestDeleteTicket(ticket:TicketList, indexPath:NSIndexPath){
        let url = "\(SellTicketStatus)\(ticket.id)/"
        BaseNetWorke.sharedInstance.deleteUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            if resultDic is NSDictionary {
                if (resultDic as! NSDictionary).allKeys.count > 0 {
                    MainThreadAlertShow("\((resultDic as! NSDictionary)["message"]!)", view: KWINDOWDS!)
                }else{
                    self.tempSelect = self.selectSession
                    self.tempList.removeAtIndex(indexPath.row - 3)
                    self.controller.tableView.beginUpdates()
                    self.ticketShowModel.sessionList[self.selectSession].ticketList.removeAtIndex(indexPath.row - 3)
                    self.controller.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.controller.tableView.endUpdates()
//                    if self.tempList.count == 0 {
//                        let session = self.picketCell.viewWithTag(self.selectSession + 10) as! TicketSession
//                        session.type = 0
//                        self.picketCell.updateSession(self.selectSession + 10)
//                        self.controller.tableView.reloadData()
//                    }
                }
            }
            if self.myTicketPutUpViewModelClouse != nil {
                self.myTicketPutUpViewModelClouse(ticketShow: self.ticketShowModel)
            }
        }
    }
    
    func requestTicketPutStatus(ticket:TicketList, indexPath:NSIndexPath){
        let url = "\(SellTicketStatus)\(ticket.id)/"
        BaseNetWorke.sharedInstance.putUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            ticket.status = ticket.status == 1 ? 0 : 1
            ticket.statusDesc = ticket.status == 1 ? "已上线" : "已下线"
            self.tempList[indexPath.row - 3] = ticket
            if self.sesstionModels.count == 0 {
                self.ticketShowModel.sessionList[0].ticketList[indexPath.row - 3] = ticket
            }else{
                self.ticketShowModel.sessionList[self.selectSession].ticketList[indexPath.row - 3] = ticket
            }
            self.controller.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            if self.myTicketPutUpViewModelClouse != nil {
                self.myTicketPutUpViewModelClouse(ticketShow: self.ticketShowModel)
            }
        }
    }
}
