 //
//  MySellConfimViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift
 
 
 let TempTicketRowRegionsStr = "随机"
 let TempCellStr = "请选择"
 
typealias MySellConfimViewModelClouse = (_ ticket:TicketList, _ name:String) -> Void
typealias MySellConfimViewModelAddClouse = (_ originTicket:OriginalTicket, _ ticket:TicketList, _ name:String) -> Void

class MySellConfimViewModel: NSObject {
    
    var controller:MySellConfimViewController!
    var infoController:SellInfoViewController!
    var tickeListView:GloableTitleList!
    var deverliStr:String = TempCellStr
    var ticketList = NSMutableArray()
    var model:TicketShowModel!
    var sellTicketModel:TickeSellModel!
    var sellFormModel:SellFormModel!
    var express:Expressage = Expressage()
    var present:Present = Present()
    var visite:Visite = Visite()
    var putUpModel:TicketList!
    var much:String!
    var isChange:Bool = false
    var selectIndex:NSInteger = 0
    var ticketOriginName:String = ""
    var originTicket:OriginalTicket!
    var isNoneTicket:Bool = false
    var isSellTicketView:Bool = false
    var mySellConfimViewModelAddClouse:MySellConfimViewModelAddClouse!
    var mySellConfimViewModelClouse:MySellConfimViewModelClouse!
    override init() {
        super.init()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, forKeyPath: SellTicketNumberChange)
    }
    
    static let shareInstance = MySellConfimViewModel()
    
    func messageTitle() -> String {
        return "卖票前请确保有票，拒绝挂售期票\n位置精确的票品更有利于售卖\n平台所有交易免佣金，仅含1%的第三方平台交易手续费\n商家跳票后押金会直接赔付用户\n三次跳票将取消卖票资格"
    }
    
    func setUpViewModel(){
        sellFormModel = SellFormModel.findFirst(byCriteria: "WHERE id = \((model.session.id)!)")
        if sellFormModel == nil {
            sellFormModel = SellFormModel.init()
            sellFormModel.id = "\((model.session.id)!)"
            self.express = Expressage.init()
            self.present = Present.init()
            self.visite = Visite.init()
        }else{
            if sellFormModel.deverliExpress != TempCellStr {
                self.express = Expressage.mj_object(withKeyValues: sellFormModel.deverliExpress)
            }else{
                self.express = Expressage.init()
                self.express.isSelect = true
            }
            if sellFormModel.deverliPresnt != TempCellStr {
                self.present = Present.mj_object(withKeyValues: sellFormModel.deverliPresnt)
            }else{
                self.present = Present.init()
            }
            if sellFormModel.deverliVisite != TempCellStr {
                self.visite = Visite.mj_object(withKeyValues: sellFormModel.deverliVisite)
            }else{
                self.visite = Visite.init()
            }
            
        }
    }
    
    func setUpChangeCellForm(_ ticket:TicketList){
        sellFormModel = SellFormModel.findFirst(byCriteria: "WHERE id = \((model.session.id)!)")
        if sellFormModel == nil {
            sellFormModel = SellFormModel.init()
            sellFormModel.id = "\((model.session.id)!)"
        }
        self.ticketOriginName = ticket.originalTicket.name
        self.originTicket = ticket.originalTicket
        self.putUpModel = ticket
        sellFormModel.ticketPrice = "\((ticket.originalTicket.id)!)"
        sellFormModel.price = "\((ticket.price)!)"
        sellFormModel.number = ticket.ticketCount
        sellFormModel.sellType = ticket.sellType == 1 ? "可以分开卖":"一起卖"
        sellFormModel.seatType = "\((ticket.seatType)!)"
        sellFormModel.ticketRegin = ticket.region == "" ? TempTicketRowRegionsStr : ticket.region
        sellFormModel.sellCategoty = ticket.sellCategory
        if ticket.region == "" {
           sellFormModel.ticketRow = TempTicketRowRegionsStr
        }else{
            sellFormModel.ticketRow = ticket.row == "" ? TempTicketRowRegionsStr : "\((ticket.row)!)排"
        }
        if ticket.deliveryType == "1" {
            self.express.isSelect = true
            sellFormModel.deverliExpress = NSString.dataTOjsonString(self.express.mj_keyValues())
        }else{
            sellFormModel.deverliExpress = TempCellStr
            self.express = Expressage.init()
        }
        if ticket.sceneGetTicketAddress != "" {
            self.present.isSelect = true
            self.present.address = ticket.sceneGetTicketAddress
            self.present.phone = ticket.sceneGetTicketPhone
            self.present.time = ticket.sceneGetTicketDate
            sellFormModel.deverliPresnt = NSString.dataTOjsonString(self.present.mj_keyValues())
        }else{
            sellFormModel.deverliPresnt = TempCellStr
            self.present = Present.init()
        }
        if ticket.selfGetTicketAddress != "" {
            self.visite.isSelect = true
            self.visite.address = ticket.selfGetTicketAddress
            self.visite.phone = ticket.selfGetTicketPhone
            self.visite.time = ticket.selfGetTicketDate
            sellFormModel.deverliPresnt = NSString.dataTOjsonString(self.visite.mj_keyValues())
        }else{
            sellFormModel.deverliVisite = TempCellStr
            self.visite = Visite.init()
        }
    }
    
    //MARK: MySellConfimViewController
    func setUpView(){
        tickeListView = GloableTitleList.init(frame: CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: 0), title: ticketList, selectIndex:selectIndex)
        tickeListView.frame = CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: tickeListView.maxHeight)
        if self.sellFormModel.ticketPrice == "10" {
            self.sellFormModel.ticketPrice = self.sellTicketModel.ticketChoices[0][0]
            if self.originTicket != nil {
                self.originTicket.name = self.sellTicketModel.ticketChoices[0][1]
                self.originTicket.id = Int64(self.sellTicketModel.ticketChoices[0][0])
            }
        }
        tickeListView.gloableTitleListClouse = { title, index in
            self.sellFormModel.ticketPrice = self.sellTicketModel.ticketChoices[index][0]
            if self.originTicket != nil {
                self.originTicket.name = self.sellTicketModel.ticketChoices[index][1]
                self.originTicket.id = Int64(self.sellTicketModel.ticketChoices[index][0])
            }
            self.ticketOriginName = self.sellTicketModel.ticketChoices[index][1]
        }
    }
    
    func getTickeList(){
        ticketList.removeAllObjects()
        selectIndex = 0
        var index:NSInteger = 0
        for ticketModel in self.sellTicketModel.ticketChoices {
            ticketList.add(ticketModel[1])
            if isChange {
                if ticketModel[0] == sellFormModel.ticketPrice {
                    selectIndex = index
                }
            }
            index = index + 1
        }
        self.setUpView()
    }
    
    func tableViewHeightForFooterInSection(_ section:Int) -> CGFloat{
        return 10
        
    }
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return controller.tableView.fd_heightForCell(withIdentifier: "MySellConfimHeaderTableViewCell", configuration: { (cell) in
                self.setConfigHeaderCell(cell as! MySellConfimHeaderTableViewCell, indexPath: indexPath)
            })
        case 1:
            return tickeListView.maxHeight + 78
        case 2:
            return 105
        default:
            return 173
        }
        
    }
    
    func tableViewNumberOfRowsInSection(_ section:Int) -> Int{
        return 4
    }
    
    func tableViewCellGloabTitleNumberCountTableViewCell(_ cell:GloabTitleNumberCountTableViewCell, indexPath:IndexPath) {
        cell.setText("售卖数量", textFieldText: "1")
        
        if isChange {
            cell.setText("售卖数量", textFieldText: "\(sellFormModel.number)")
        }else{
            self.sellFormModel.number = 1
            cell.numberTickView.numberTextField.reactive.producer(forKeyPath: "text").start({ (text) in
                self.sellFormModel.number = Int(text.value as! String)!
            })
        }
    }
    
    func tableViewCellMySellTicketMuchTableViewCell(_ cell:MySellTicketMuchTableViewCell, indexPath:IndexPath) {
        if isChange {
            cell.muchTextField.text = self.sellFormModel.price
        }
        cell.muchTextField.reactive.continuousTextValues.observeValues { (str) in
            if String(str!) == "" {
                self.controller.bottomButton.button.isEnabled = false
                self.controller.bottomButton.button.buttonSetThemColor(App_Theme_DDE0E5_Color, selectColor: App_Theme_DDE0E5_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
                self.controller.bottomButton.button.backgroundColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            }else{
                self.controller.bottomButton.button.isEnabled = true
                self.controller.bottomButton.button.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
            }
            self.sellFormModel.price = str!
        }
    }
    
    func setConfigHeaderCell(_ cell:MySellConfimHeaderTableViewCell, indexPath:IndexPath) {
        cell.setUpData(model)
    }
    
    
    func tableViewMySellConfimHeaderTableViewCell(_ cell:MySellConfimHeaderTableViewCell, indexPath:IndexPath) {
        self.setConfigHeaderCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellMySellTicketTableViewCell(_ cell:MySellTicketTableViewCell, indexPath:IndexPath) {
        cell.contentView.addSubview(tickeListView)
    }
    
    func pushSellInfo(){
        self.much = "\(Double(self.sellFormModel.number) * Double(self.sellFormModel.price)!)"
        var id:Int64
        if self.putUpModel != nil && self.putUpModel.originalTicket != nil {
            id = self.putUpModel.originalTicket.id != nil ? self.putUpModel.originalTicket.id : 0
            if self.originTicket.id != nil {
                id = self.originTicket.id
            }
        }else{
            if self.originTicket.id != nil {
                id = self.originTicket.id
            }else{
                id = Int64(0)
                _ = Tools.shareInstance.showMessage(self.controller.view, msg: "获取票品id错误", autoHidder: true)
            }
        }
        
        let url = "\(TicketSellRegion)\((id))/regions/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value is [[String]] {
                    self.sellTicketModel.regionChoices = resultDic.value as! [[String]]
                }
                NavigationPushView(self.controller, toConroller: SellInfoViewController())
            }
            
        }
    }
    
    
    //MARK: SellInfoViewController
    
    func getDeveliryStr() -> String{
        if self.sellFormModel.deverliPresnt == nil && self.sellFormModel.deverliExpress == nil && self.sellFormModel.deverliVisite == nil {
            return TempCellStr
        }else{
            if self.sellFormModel.deverliPresnt == TempCellStr && self.sellFormModel.deverliVisite == TempCellStr && self.sellFormModel.deverliExpress == TempCellStr {
                return "快递到付"
            }
            deverliStr = ""
            if self.sellFormModel.deverliExpress != nil && self.sellFormModel.deverliExpress != TempCellStr {
                let dic = NSString.data(toNSDiction: self.sellFormModel.deverliExpress)
                self.express = Expressage.mj_object(withKeyValues: dic)
                if self.express.isSelect {
                    self.deverliStr = self.deverliStr + "快递到付 "
                }
            }
            if self.sellFormModel.deverliPresnt != nil && self.sellFormModel.deverliPresnt != TempCellStr {
                let dic = NSString.data(toNSDiction: self.sellFormModel.deverliPresnt)
                self.present = Present.mj_object(withKeyValues: dic)
                if self.present.isSelect {
                    self.deverliStr = self.deverliStr + "现场取票 "
                }
            }
            if self.sellFormModel.deverliVisite != nil && self.sellFormModel.deverliVisite != TempCellStr {
                let dic = NSString.data(toNSDiction: self.sellFormModel.deverliVisite)
                self.visite = Visite.mj_object(withKeyValues: dic)
                if self.visite.isSelect {
                    self.deverliStr = self.deverliStr + "上门取票 "
                }
            }
            return deverliStr
        }
    }
    
    func sellInfoViewNumberSection() -> Int {
        return 4
    }
    
    func sellInfoNumberRowSection(_ section:Int) ->Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 1
        }
    }
    
    func sellInfotableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 54
        case 1:
            return 54
        case 2:
            return 70
        default:
            return infoController.tableView.fd_heightForCell(withIdentifier: "MySellServiceTableViewCell", configuration: { (cell) in
                self.configMySellServiceCell(cell as! MySellServiceTableViewCell, indexPath:indexPath)
            })
        }
        
    }

    func configMySellServiceCell(_ cell:MySellServiceTableViewCell, indexPath:IndexPath) {
        let totalMuch = "\(much)".muchType("\((Double(much)! * 100))")
        let serviceMuch = "\((Double(much)! * 100) * 0.01)".muchType("\((Double(much)! * 100) * 0.01)")
        cell.setData("结算总价: \(totalMuch) 元", servicemuch: "交易手续费: \(serviceMuch) 元", sevicep: "第三方支付交易手续费1%\n订单票款将于对方确认收货后立即结算至钱包账户", type: 0)
    }
    
    
    func sellInfoTableViewDidSelect(_ indexPath:IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                infoController.showTicketRegionPickerView()
            }else{
                infoController.showTicketRowPickerView()
            }
        case 1:
            if indexPath.row == 0 {
                infoController.showSellTypePickerView()
            }else{
                let controllerVC = OrderDeliveryTypeViewController()
                controllerVC.viewModel.express = self.express
                controllerVC.viewModel.present = self.present
                controllerVC.viewModel.visite = self.visite
                controllerVC.viewModel.orderDeliveryTypeViewModelClouse = { array in
                    self.deverliStr = ""
                    for object in array {
                        if object is Expressage {
                            let str = NSString.dataTOjsonString((object as! Expressage).mj_keyValues())
                            self.sellFormModel.deverliExpress = str
                        }
                        if object is Present {
                            let str = NSString.dataTOjsonString((object as! Present).mj_keyValues())
                            self.sellFormModel.deverliPresnt = str
                        }
                        if object is Visite {
                            let str = NSString.dataTOjsonString((object as! Visite).mj_keyValues())
                            self.sellFormModel.deverliVisite = str
                        }
                    }
                    self.sellFormModel.saveOrUpdate()
                    self.infoController.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .automatic)
                }
                NavigationPushView(infoController, toConroller: controllerVC)
            }
        case 2:
            break
        default:
            KWINDOWDS().addSubview(GloableServiceView.init(title: "手续费说明", message: "所有交易免佣金，仅含1%第三方支付平台交易手续费\n结算票款时系统自动扣减手续费"))
        }
    }
    
    func tableViewGloabTitleAndDetailImageCell(_ cell:GloabTitleAndDetailImageCell, indexPath:IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.setData("区域", detail: self.sellFormModel.ticketRegin)
            }else{
                cell.hideLineLabel()
                cell.setData("排数", detail: self.sellFormModel.ticketRow)
            }
        default:
            if indexPath.row == 0 {
                cell.setData("出售方式", detail: self.sellFormModel.sellType)
            }else{
                cell.hideLineLabel()
                cell.setData("配送方式", detail: self.getDeveliryStr())
            }
        }
    }
    
    func tableViewTicketStatusTableViewCell(_ cell:TicketStatusTableViewCell) {
        cell.setTicketModel(self.sellFormModel)
        cell.ticketStatusTableViewCellClouse = { isSeat, isTicket in
            self.sellFormModel.seatType = isSeat ? "1" : "2"
            self.sellFormModel.sellCategoty = isTicket ? 1:0
        }
        
        cell.ticketTicketSellClouse = { tap, label in
            UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "提示", message: "现票必须保证72小时内发货，期票发货时间需与买家商议。现票快递类违约不能付票，每张赔付50元，期票违约每张赔付100元.", cancel: "取消", doneTitle: "确定", cancelAction: {
                
                }, doneAction: {
                    cell.updataLabel(label)
            })
        }
        
    }
    
    func tableViewGloabTitleAndSwitchBarTableViewCell(_ cell:GloabTitleAndSwitchBarTableViewCell) {
        cell.switchBar.isEnabled = true
        if self.sellFormModel.seatType == "1"  {
            if self.sellFormModel.number > 1 {
                cell.switchBar.setOn(true, animated: true)
            }else{
                cell.switchBar.setOn(false, animated: true)
                cell.switchBar.isEnabled = false
            }
        }else{
            cell.switchBar.setOn(false, animated: true)
        }
        cell.switchBar.reactive.controlEvents(.valueChanged).observe { (result) in
            self.sellFormModel.seatType = (result.value!).isOn ? "1" : "2"
        }
    }
    
    func updateGloabTitleAndDetailImageCell(_ cell:GloabTitleAndDetailImageCell, row:Int, title:String) {
        cell.setDetailText(title)
        switch row {
        case 0:
            self.sellFormModel.sellType = title
        case 1:
            self.sellFormModel.ticketRegin = title
        case 2:
            self.sellFormModel.ticketRow = title
        default:
            cell.setData("配送方式", detail: deverliStr)
        }
    }
    
    func getRegionArray() -> NSMutableArray{
        let array = NSMutableArray()
        if self.sellTicketModel != nil {
            for region in self.sellTicketModel.regionChoices {
                array.add(region[1])
            }
        }
        return array
    }
    
    func getSellType() -> NSMutableArray{
        let array = NSMutableArray()
        if self.sellTicketModel != nil {
            for sellType in self.sellTicketModel.sellTypeChoices {
                array.add(sellType[1])
            }
        }
        return array
    }
    
    func tableViewMySellServiceTableViewCell(_ cell:MySellServiceTableViewCell, indexPath:IndexPath) {
        switch indexPath.section {
        case 3:
            self.configMySellServiceCell(cell, indexPath: indexPath)
        default:
            cell.setData("余额：00.00 元", servicemuch: "押金：50.00 元", sevicep: "保证金将于订单完成后直接返还至账户钱包中，挂单、删除或下架后押金亦退还至钱包中", type: 1)
        }
    }
    
    func requestSellTicket(){
        let url = "\(SellTicket)\((model.id)!)/session/\((model.session.id)!)/ticket/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.sellTicketModel = TickeSellModel.init(fromDictionary: resultDic.value as! NSDictionary)
                if self.sellTicketModel.ticketChoices.count != 0 {
                    let dic = ["id":Int64(self.sellTicketModel.ticketChoices[0][0])!,"name":self.sellTicketModel.ticketChoices[0][0],"price":100] as [String : Any]
                    self.originTicket = OriginalTicket.init(fromDictionary: dic as NSDictionary)
                    if self.sellTicketModel != nil {
                        self.getTickeList()
                        self.controller.setUpView()
                        self.controller.tableView.reloadData()
                        if self.controller.tableView.mj_header != nil {
                            self.controller.tableView.mj_header.endRefreshing()
                        }
                    }
                }else{
                    MainThreadAlertShow("该场次暂无售票", view: KWINDOWDS())
                }
            }
        }
    }
    
    func requestSellTicketPost(){
        var paramerts = NSMutableDictionary()
        var str = ""
        if self.sellFormModel.ticketRegin != "随机" {
            str = self.sellFormModel.ticketRow == "随机" ? "" : (self.sellFormModel.ticketRow as NSString).substring(to: self.sellFormModel.ticketRow.length - 1)
        }else{
            str = "0"
        }
        //涉及到兼容性版本...老版本为择优分配  现版本全部改成 随机
        paramerts = ["show_session_ticket":self.sellFormModel.ticketPrice,
                     "seat_type":self.sellFormModel.seatType,
                     "price":self.sellFormModel.price,
                     "region":self.sellFormModel.ticketRegin == "随机" ? "择优分配" : self.sellFormModel.ticketRegin,
                     "sell_type":self.sellFormModel.sellType == "可以分开卖" ? "1" : "2",
                     "ticket_count":self.sellFormModel.number == 0 ? 1:self.sellFormModel.number,
                     "sell_category":self.sellFormModel.sellCategoty == 1 ? "1":"0",
                     "row":str]
        var delivery_type = ""
        if self.express.isSelect {
            delivery_type = delivery_type + "4,"
        }
        if self.present.isSelect {
            delivery_type = delivery_type + "2,"
            paramerts.addEntries(from: ["scene_get_ticket_date":self.present.time,"scene_get_ticket_address":self.present.address, "scene_get_ticket_phone":self.present.phone])
        }
        if self.visite.isSelect {
            delivery_type = delivery_type + "3,"
            paramerts.addEntries(from: ["self_get_ticket_date":self.visite.time,"self_get_ticket_address":self.visite.address, "self_get_ticket_phone":self.visite.phone])
        }
        paramerts.addEntries(from: ["delivery_type":delivery_type])
        if self.isChange {
            self.changeTicke(paramerts)
        }else{
            self.postTicket(paramerts)
        }
    }
    
    func changeTicke(_ paramerts:NSDictionary){
        let url = "\(SellTicketStatus)\((putUpModel.id)!)/"
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: paramerts).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.putUpModel = TicketList.init(fromDictionary: resultDic.value as! NSDictionary)
                MainThreadAlertShow("修改成功", view: KWINDOWDS())
                if self.mySellConfimViewModelClouse != nil {
                    self.mySellConfimViewModelClouse(self.putUpModel, self.ticketOriginName)
                    for controllers in (self.controller.navigationController?.viewControllers)! {
                        if controllers is MyTicketPutUpViewController {
                            self.infoController.navigationController?.popToViewController(controllers, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func postTicket(_ paramerts:NSDictionary){
//        if sellTicketModel.needDeposit {
//            UIAlertController.shwoAlertControl(self.infoController, style: .alert, title: "尚未缴纳押金，可联系客服400-873-8011", message: nil, cancel: "取消", doneTitle: "联系客服", cancelAction: {
//                
//            }, doneAction: { 
//                AppCallViewShow(self.controller.view, phone: "400-873-8011")
//            })
//            return
//        }
        let url = "\(SellTicket)\((model.id)!)/session/\((model.session.id)!)/ticket/"
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: paramerts).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.putUpModel = TicketList.init(fromDictionary: resultDic.value as! NSDictionary)
                MainThreadAlertShow("挂票成功", view: KWINDOWDS())
                if self.isSellTicketView {
                    
                    self.showMyTicketPutUpViewController(self.model)
                    //                self.infoController.navigationController?.popViewControllerAnimated(true)
                }else{
                    if self.mySellConfimViewModelAddClouse != nil {
                        self.mySellConfimViewModelAddClouse(self.originTicket, self.putUpModel, self.ticketOriginName)
                        for controllers in (self.controller.navigationController?.viewControllers)! {
                            if controllers is MyTicketPutUpViewController {
                                self.infoController.navigationController?.popToViewController(controllers, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func showMyTicketPutUpViewController(_ model:TicketShowModel){
        let url = "\(OneShowTicketUrl)\((model.id)!)/ticket/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let sessionList = NSMutableArray.mj_objectArray(withKeyValuesArray: (resultDic.value as! NSDictionary).object(forKey: "session_list"))
                var sessions:[ShowSessionModel] = []
                for session in sessionList!{
                    sessions.append(ShowSessionModel.init(fromDictionary: session as! NSDictionary))
                }
                model.sessionList = sessions
                let controllerVC = MyTicketPutUpViewController()
                controllerVC.viewModel.ticketShowModel = model
                controllerVC.viewModel.ticketSellCount = MySellViewModel.TicketShowModelSellCount(model)
                controllerVC.viewModel.ticketSoldCount = MySellViewModel.TicketShowModelSoldCount(model)
                let priceModel = MySellViewModel.sellManagerMinMaxPrice(model)
                var ticketMuch = ""
                if priceModel.minPrice != priceModel.maxPrice {
                    ticketMuch = "\(priceModel.minPrice)-\(priceModel.maxPrice)"
                }else{
                    ticketMuch = "\(priceModel.minPrice)"
                }
                controllerVC.viewModel.ticketSoldMuch = ticketMuch
                controllerVC.viewModel.ticketSession = MySellViewModel.TicketShowModelSession(model)
                controllerVC.viewModel.isSellTicketVC = true
                NavigationPushView(self.controller, toConroller: controllerVC)
            }
        }
    }
}

