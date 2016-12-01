//
//  OrderConfirmViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

enum OrderFormType {
    case withNomal
    case withAddress
    case withOrderStatues
}

enum DelivityType {
    case delivityNomal
    case delivitySF
}

typealias  OrderConfirmViewModelClouse = (indexPath:NSIndexPath) ->Void

class OrderConfirmViewModel: NSObject {
    
    
    var tableSelectSingle:RACSignal!
    var orderConfirmViewModelClouse:OrderConfirmViewModelClouse!
    var model:TicketDescriptionModel!
    var ticketModel:TicketList!
    var muchOfTicket:String = ""
    dynamic var muchOfTicketWithOther:String = ""
    let orderForme = OrderFormModel.shareInstance
    var addressModel:AddressModel!
    var formDelevityType:FormDelivityType = .presentRecive
    var formType:OrderFormType = .withAddress
    var formAddress:NSInteger = 0
    var ticketCount:Int = 0
    var orderModel:OrderList!
    
    var delivityType:DelivityType = .delivityNomal
    
    override init() {
       
    }
    
    func configCellLabel(indexPath:NSIndexPath) -> String {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                return "新增收货地址"
            default:
                return "配送方式"
            }
        case 1:
            switch indexPath.row {
            case 0:
                return ""
            case 1:
                return "代收票款"
            case 2:
                return "优惠券"
            case 3:
                return "配送费"
            case 4:
                return "买家留言:"
            default:
                return "配送方式"
            }
        default:
            switch indexPath.row {
            case 0:
                return "微信支付"
            default:
                return "支付宝"
            }
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 86
            case 1:
                return 52
            default:
                return 52
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            case 4:
                return 62
            default:
                return 48
            }
        default:
            switch indexPath.row {
            case 0:
                return 48
            default:
                return 52
            }
        }
    }
    
    func tableViewHeightForFooterInSection(section:Int) ->CGFloat {
        if self.formType == .withAddress {
            if section == 0 {
                return 105
            }else if section == 2 {
                return 67
            }else{
                return 10
            }
        }else{
            if section == 2 {
                return 67
            }else{
                return 10
            }
        }
    }
    
    func tableViewNumberOfRowsInSection(section:Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        default:
            return 2
        }
    }
    
    func tableViewCellReciveTableViewCell(cell:ReciveTableViewCell, controller:TicketConfirmViewController){
        cell.setData(ticketModel)
        cell.reciveViewClouse = { tag in
            if tag == 1 {
                self.formDelevityType = .expressage
                self.formType = .withNomal
            }else{
                if tag == 2 {
                    self.formDelevityType = .presentRecive
                }else{
                    self.formDelevityType = .visitRecive
                }
                self.formType = .withAddress
            }
            self.formAddress = tag
            controller.upDataTableView()
        }
    }
    
    func tableViewCellCofimTicketTableViewCell(cell:CofimTicketTableViewCell, controller:TicketConfirmViewController){
        cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
        cell.setData(model.show, ticketModel: ticketModel, sessionModel: model.session, ticketCount:"\(ticketCount)")
    }
    
    func tableViewCellGloabTextFieldCell(cell:GloabTextFieldCell,indexPath:NSIndexPath, controller:TicketConfirmViewController)
    {
        
    }
    
    func tableViewCellGloabTitleAndDetailCell(cell:GloabTitleAndDetailCell,indexPath:NSIndexPath, controller:TicketConfirmViewController)
    {
        switch indexPath.row {
        case 1:
            cell.setData(self.configCellLabel(indexPath), detail: "\(self.muchOfTicket).00 元")
        default:
            let str = self.delivityType == .delivityNomal ? "8.00 元" : "12.00 元"
            cell.setData(self.configCellLabel(indexPath), detail: str)
        }
        orderForme.deliveryType = .expressage
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:NSIndexPath, controller:TicketConfirmViewController) {
        if indexPath.section == 2 {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! GloabTitleAndImageCell
            cell.updateImageView(true)
            if indexPath.row == 0 {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 2)) as! GloabTitleAndImageCell
                cell.updateImageView(false)
            }else{
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 2)) as! GloabTitleAndImageCell
                cell.updateImageView(false)
            }
            orderForme.payType = indexPath.row == 0 ? .weiChat : .aliPay
            
        }else{
            if self.formType == .withNomal {
                if (self.orderConfirmViewModelClouse == nil) != nil {
                    self.orderConfirmViewModelClouse(indexPath:indexPath)
                }
            }
        }
    }
    
    func updateCellString(tableView:UITableView, string:String){
        self.delivityType = string == "普通快递（8元）" ? .delivityNomal : .delivitySF
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0)) as! GloabTitleAndDetailImageCell
        cell.detailLabel.text = string
        
        let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 3, inSection: 1)) as! GloabTitleAndDetailCell
        let str = self.delivityType == .delivityNomal ? "8.00 元" : "12.00 元"
        cell1.detailLabel.text = str
        self.updateMuchOfTicke()
    }
    
    func updateMuchOfTicke(){
        let much = self.delivityType == .delivityNomal ? 8.00 : 12.00
        muchOfTicketWithOther = "\(Double(muchOfTicket)! + much)0"
        orderForme.deliveryPrice = muchOfTicketWithOther
    }
    
    func createOrder(controller:TicketConfirmViewController){
        self.orderForme.deliveryType = self.formDelevityType
        if (self.orderForme.deliveryType == .expressage) && (self.orderForme.addressId == nil) {
            MainThreadAlertShow("请填写配送地址", view: controller.view)
            return
        }
        if (self.orderForme.deliveryType != .expressage) && (self.orderForme.name == "" || self.orderForme.phone == "") {
            MainThreadAlertShow("请填写配送信息", view: controller.view)
            return
        }
        self.requestOrderPay(self.orderForme, controller: controller)
    }
    
    func requestOrderPay(orderForm:OrderFormModel,controller:TicketConfirmViewController){
        var parameters:NSDictionary = NSDictionary()
        let pay_type = orderForm.payType == .weiChat ? "2" : "1"
        let delivery_type = orderForme.deliveryType == .expressage ? "1" : "2"
        let delivery_price = self.delivityType == .delivityNomal ? "8" : "12"
        if orderForm.deliveryType == .expressage {
            parameters = ["ticket_id":orderForm.ticketID!
                ,"ticket_count":orderForm.ticketCount!
                ,"delivery_type":delivery_type
                ,"delivery_price":delivery_price
                ,"pay_type":pay_type
                ,"address_id":orderForme.addressId!
                ,"mesaage":orderForme.message!]
        }else{
            parameters = ["ticket_id":orderForm.ticketID!
                ,"ticket_count":orderForm.ticketCount!
                ,"delivery_type":delivery_type
                ,"pay_type":pay_type
                ,"name":orderForme.name!
                ,"phone":orderForme.phone!
                ,"mesaage":orderForme.message!]
        }
        
        BaseNetWorke.sharedInstance.postUrlWithString(OrderCreate, parameters: parameters).subscribeNext { (resultDic) in
            self.orderModel = OrderList.init(fromDictionary: resultDic as! NSDictionary)
            self.orderModel.session = self.model.session
            self.orderModel.show = self.model.show
            self.orderModel.ticket = self.ticketModel
            let controllerVC = OrderDetailViewController()
            controllerVC.viewModel.model = self.orderModel
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
}
