//
//  MySellConfimViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 08/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellConfimViewModel: NSObject {
    
    var controller:MySellConfimViewController!
    var infoController:SellInfoViewController!
    var tickeListView:GloableTitleList!
    var deverliStr:String = "请选择"
    var ticketList = NSMutableArray()
    var model:TicketShowModel!
    var sellTicketModel:TickeSellModel!
    var sellFormModel:SellFormModel!
    var express:Expressage = Expressage()
    var present:Present = Present()
    var visite:Visite = Visite()
    var putUpModel:PutUpModel!
    
    override init() {
        super.init()
        
    }
    
    static let shareInstance = MySellConfimViewModel()
    
    func messageTitle() -> String {
        return "演出结束后第二天，完成票款结算\n 所有交易免佣金，仅含1%第三方支付平台交易手续费"
    }
    
    func setUpViewModel(){
        sellFormModel = SellFormModel.findFirstByCriteria("WHERE id = \(model.session.id)")
        if sellFormModel == nil {
            sellFormModel = SellFormModel.init()
            sellFormModel.id = "\(model.session.id)"
            self.express = Expressage.init()
            self.present = Present.init()
            self.visite = Visite.init()
        }else{
            self.express = Expressage.mj_objectWithKeyValues(sellFormModel.deverliExpress)
            self.present = Present.mj_objectWithKeyValues(sellFormModel.deverliPresnt)
            self.visite = Visite.mj_objectWithKeyValues(sellFormModel.deverliVisite)
        }
    }
    
    //MARK: MySellConfimViewController
    func setUpView(){
        tickeListView = GloableTitleList.init(frame: CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: 0), title: ticketList)
        tickeListView.frame = CGRect.init(x: 15, y: 62, width: SCREENWIDTH - 30, height: tickeListView.maxHeight)
        tickeListView.gloableTitleListClouse = { title, index in
            self.sellFormModel.ticketPrice = self.sellTicketModel.ticketChoices[index][0]
        }
    }
    
    func getTickeList(){
        ticketList.removeAllObjects()
        for ticketModel in self.sellTicketModel.ticketChoices {
            ticketList.addObject(ticketModel[1])
        }
        self.setUpView()
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat{
        return 10
        
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return controller.tableView.fd_heightForCellWithIdentifier("MySellConfimHeaderTableViewCell", configuration: { (cell) in
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
    
    func tableViewNumberOfRowsInSection(section:Int) -> Int{
        return 4
    }
    
    func tableViewCellGloabTitleNumberCountTableViewCell(cell:GloabTitleNumberCountTableViewCell, indexPath:NSIndexPath) {
        cell.setText("售卖数量", textFieldText: "1")
        cell.numberTickView.numberTextField.rac_textSignal().subscribeNext { (number) in
            self.sellFormModel.number = Int(number as! String)!
        }
    }
    
    func tableViewCellMySellTicketMuchTableViewCell(cell:MySellTicketMuchTableViewCell, indexPath:NSIndexPath) {
        cell.muchTextField.rac_textSignal().subscribeNext { (str) in
            if str as! String == "" {
                self.controller.bottomButton.button.enabled = false
                self.controller.bottomButton.button.buttonSetThemColor(App_Theme_DDE0E5_Color, selectColor: App_Theme_DDE0E5_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
                self.controller.bottomButton.button.backgroundColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
            }else{
                self.controller.bottomButton.button.enabled = true
                self.controller.bottomButton.button.buttonSetThemColor(App_Theme_4BD4C5_Color, selectColor: App_Theme_40C6B7_Color, size: CGSize.init(width: SCREENWIDTH, height: 49))
            }
            self.sellFormModel.price = str as! String
        }
    }
    
    func setConfigHeaderCell(cell:MySellConfimHeaderTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(model)
    }
    
    
    func tableViewMySellConfimHeaderTableViewCell(cell:MySellConfimHeaderTableViewCell, indexPath:NSIndexPath) {
        self.setConfigHeaderCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellMySellTicketTableViewCell(cell:MySellTicketTableViewCell, indexPath:NSIndexPath) {
        cell.contentView.addSubview(tickeListView)
    }
    
    
    //MARK: SellInfoViewController
    
    func getDeveliryStr() -> String{
        if self.sellFormModel.deverliPresnt == nil && self.sellFormModel.deverliExpress == nil && self.sellFormModel.deverliVisite == nil {
            return "请选择"
        }else{
            if self.sellFormModel.deverliPresnt == "请选择" && self.sellFormModel.deverliVisite == "请选择" && self.sellFormModel.deverliExpress == "请选择" {
                return "请选择"
            }
            deverliStr = ""
            if self.sellFormModel.deverliExpress != nil && self.sellFormModel.deverliExpress != "请选择" {
                let dic = NSString.DataToNSDiction(self.sellFormModel.deverliExpress)
                self.express = Expressage.mj_objectWithKeyValues(dic)
                if self.express.isSelect {
                    self.deverliStr = self.deverliStr.stringByAppendingString("快递配送 ")
                }
            }
            if self.sellFormModel.deverliPresnt != nil && self.sellFormModel.deverliPresnt != "请选择"{
                let dic = NSString.DataToNSDiction(self.sellFormModel.deverliPresnt)
                self.present = Present.mj_objectWithKeyValues(dic)
                if self.present.isSelect {
                    self.deverliStr = self.deverliStr.stringByAppendingString("现场取票 ")
                }
            }
            if self.sellFormModel.deverliVisite != nil && self.sellFormModel.deverliVisite != "请选择"{
                let dic = NSString.DataToNSDiction(self.sellFormModel.deverliVisite)
                self.visite = Visite.mj_objectWithKeyValues(dic)
                if self.visite.isSelect {
                    self.deverliStr = self.deverliStr.stringByAppendingString("上门取票 ")
                }
            }
            return deverliStr
        }
    }
    
    func sellInfoViewNumberSection() -> Int {
        return 2
    }
    
    func sellInfoNumberRowSection(section:Int) ->Int {
        switch section {
        case 0:
            return 5
        default:
            return 1
        }
    }
    
    func sellInfotableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 54
        default:
            return infoController.tableView.fd_heightForCellWithIdentifier("MySellServiceTableViewCell", configuration: { (cell) in
                self.configMySellServiceCell(cell as! MySellServiceTableViewCell, indexPath:indexPath)
            })
        }
        
    }

    func configMySellServiceCell(cell:MySellServiceTableViewCell, indexPath:NSIndexPath) {
        cell.setData("交易服务费: 00.00 元", servicemuch: "结算总价: 00.00 元", sevicep: "第三方支付交易手续费1%\n订单票款结算金额将于演出结束后24小时内转入账户钱包中", type: 0)
    }
    
    
    func sellInfoTableViewDidSelect(indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
           infoController.showSellTypePickerView()
        case 1:
            infoController.showTicketRegionPickerView()
        case 2:
            infoController.showTicketRowPickerView()
        case 4:
            let controllerVC = OrderDeliveryTypeViewController()
            controllerVC.viewModel.express = self.express
            controllerVC.viewModel.present = self.present
            controllerVC.viewModel.visite = self.visite
            controllerVC.viewModel.orderDeliveryTypeViewModelClouse = { array in
                self.deverliStr = ""
                for object in array {
                    if object is Expressage {
                        let str = NSString.DataTOjsonString((object as! Expressage).mj_keyValues())
                        self.sellFormModel.deverliExpress = str
                    }
                    if object is Present {
                        let str = NSString.DataTOjsonString((object as! Present).mj_keyValues())
                        self.sellFormModel.deverliPresnt = str
                    }
                    if object is Visite {
                        let str = NSString.DataTOjsonString((object as! Visite).mj_keyValues())
                        self.sellFormModel.deverliVisite = str
                    }
                }
                self.sellFormModel.saveOrUpdate()
                self.infoController.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 4, inSection: 0)], withRowAnimation: .Automatic)
            }
            NavigationPushView(infoController, toConroller: controllerVC)
        default:
            break
        }
    }
    
    func tableViewGloabTitleAndDetailImageCell(cell:GloabTitleAndDetailImageCell, indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
            cell.setData("出售方式", detail: self.sellFormModel.sellType)
        case 1:
            cell.setData("区域", detail: self.sellFormModel.ticketRegin)
        case 2:
            cell.setData("排数", detail: self.sellFormModel.ticketRow)
        default:
            cell.hideLineLabel()
            cell.setData("配送方式", detail: self.getDeveliryStr())
        }
    }
    
    func tableViewGloabTitleAndSwitchBarTableViewCell(cell:GloabTitleAndSwitchBarTableViewCell) {
        cell.switchBar.rac_signalForControlEvents(.ValueChanged).subscribeNext { (value) in
            self.sellFormModel.seatType = (value as! UISwitch).on ? "1" : "2"
        }
    }
    
    func updateGloabTitleAndDetailImageCell(cell:GloabTitleAndDetailImageCell, row:Int, title:String) {
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
                array.addObject(region[1])
            }
        }
        return array
    }
    
    func getSellType() -> NSMutableArray{
        let array = NSMutableArray()
        if self.sellTicketModel != nil {
            for sellType in self.sellTicketModel.sellTypeChoices {
                array.addObject(sellType[1])
            }
        }
        return array
    }
    
    func tableViewMySellServiceTableViewCell(cell:MySellServiceTableViewCell, indexPath:NSIndexPath) {
        switch indexPath.section {
        case 1:
            self.configMySellServiceCell(cell, indexPath: indexPath)
        default:
            cell.setData("余额：00.00 元", servicemuch: "押金：50.00 元", sevicep: "保证金将于订单完成后直接返还至账户钱包中，挂单、删除或下架后押金亦退还至钱包中", type: 1)
        }
    }
    
    func requestSellTicket(){
        let url = "\(SellTicket)\(model.id)/session/\(model.session.id)/ticket/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            self.sellTicketModel = TickeSellModel.init(fromDictionary: resultDic as! NSDictionary)
            if self.sellTicketModel != nil {
                self.getTickeList()
                self.controller.setUpView()
                self.controller.tableView.reloadData()
                if self.controller.tableView.mj_header != nil {
                    self.controller.tableView.mj_header.endRefreshing()
                }
            }
        }
    }
    
    func requestSellTicketPost(){
        var paramerts = NSMutableDictionary()
        paramerts = ["show_session_ticket":self.sellFormModel.ticketPrice,"seat_type":self.sellFormModel.seatType, "price":self.sellFormModel.price, "region":self.sellFormModel.ticketRegin, "sell_type":self.sellFormModel.sellType == "单卖" ? "1" : "2", "ticket_count":self.sellFormModel.number,"row":self.sellFormModel.ticketRow]
        var delivery_type = ""
        if self.express.isSelect {
            delivery_type = delivery_type.stringByAppendingString("1,")
        }
        if self.present.isSelect {
            delivery_type = delivery_type.stringByAppendingString("2,")
            paramerts.addEntriesFromDictionary(["scene_get_ticket_date":self.present.time,"scene_get_ticket_address":self.present.address, "scene_get_ticket_phone":self.present.phone])
        }
        if self.visite.isSelect {
            delivery_type = delivery_type.stringByAppendingString("3,")
            paramerts.addEntriesFromDictionary(["self_get_ticket_date":self.visite.time,"self_get_ticket_address":self.visite.address, "self_get_ticket_phone":self.visite.phone])
        }
        paramerts.addEntriesFromDictionary(["delivery_type":delivery_type])
        let url = "\(SellTicket)\(model.id)/session/\(model.session.id)/ticket/"
        BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: paramerts).subscribeNext { (resultDic) in
            self.putUpModel = PutUpModel.init(fromDictionary: resultDic as! NSDictionary)
            Tools.shareInstance.showMessage(self.controller.view, msg: "挂票成功", autoHidder: true)
            self.controller.navigationController?.popViewControllerAnimated(true)
        }
    }
}
