//
//  OrderConfirmViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 04/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveSwift

enum OrderFormType {
    case withNomal
    case withAddress
    case withOrderStatues
}

enum DelivityType {
    case delivityNomal
    case delivitySF
    case delivityVisite
}

typealias  OrderConfirmViewModelClouse = (_ indexPath:IndexPath) ->Void

class OrderConfirmViewModel: NSObject {
    
    
    var tableSelectSingle:Signal<Int, NSError>!
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
    var remainCount:Int = 1
    var orderModel:OrderList!
    var controller:TicketConfirmViewController!
    var delivityType:DelivityType = .delivityNomal
    var isHaveModel:Bool = false
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(OrderConfirmViewModel.paySuccess(_:)), name: NSNotification.Name(rawValue: OrderStatuesChange), object: nil)
    }
    
    func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) != 100 {
            if self.orderModel != nil {
                self.orderModel.status = Int(object.object as! String)
                if self.orderModel.status == 2 {
                    self.orderModel.statusDesc = "交易取消"
                }else if self.orderModel.status == 3 {
                    self.orderModel.statusDesc = "待发货"
                }
                var isOrderDetail:Bool = false
                if self.controller.navigationController?.viewControllers != nil {
                    for controller in (self.controller.navigationController?.viewControllers)! {
                        if controller is OrderDetailViewController {
                            isOrderDetail = true
                            break
                        }
                    }
                }
                
                if !isOrderDetail {
                    let controllerVC = OrderDetailViewController()
                    controllerVC.viewModel.model = self.orderModel
                    controllerVC.viewModel.isOrderConfim = true
                    NavigationPushView(self.controller, toConroller: controllerVC)
                }
            }else{
//                MainThreadAlertShow("订单失效，请重新生成", view: KWINDOWDS())
            }
        }else{
            if self.orderModel != nil {
                self.requestPayUrl(self.orderModel)
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configCellLabel(_ indexPath:IndexPath) -> String {
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
            case 2:
                return "代收票款"
            case 3:
                return "优惠券"
            case 4:
                return "配送费"
            case 5:
                return "买家留言:"
            default:
                return "配送方式"
            }
        default:
            if WXApi.isWXAppInstalled() {
                switch indexPath.row {
                case 0:
                    return "微信支付"
                default:
                    return "支付宝"
                }
            }
            return "支付宝"
            
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ tableView:UITableView, indexPath:IndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 76
            case 1:
                if UserInfoModel.isLoggedIn() && AddressModel.haveAddress() && self.formType == .withNomal {
                    let addressModels = AddressModel.unarchiveObjectWithFile()
                    if addressModels.count > 0 {
                        return 76
                    }
                    return 58
                }
                return 58
            default:
                return 52
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            case 1:
                return 48
            case 5:
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
    
    func tableViewHeightForFooterInSection(_ section:Int) ->CGFloat {
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
    
    func tableViewNumberOfRowsInSection(_ section:Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 6
        default:
            if WXApi.isWXAppInstalled() {
                return 2
            }
            return 1
        }
    }
    
    func tableViewCellReciveTableViewCell(_ cell:ReciveTableViewCell){
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
            self.updateMuchOfTicke()
            self.controller.upDataTableView()
            
        }
    }
    
    func tableViewCellCofimTicketTableViewCell(_ cell:CofimTicketTableViewCell){
        cell.ticketPhoto.image = UIImage.init(named: "Feeds_Default_Cover_02")
        cell.setData(model.show, ticketModel: ticketModel, sessionModel: model.session, remainCount:"\(remainCount)")
    }
    
    func configCellTicketNumberTableViewCell(_ cell:TicketNumberTableViewCell){
        var  cellDetail:GloabTitleAndDetailCell!
        cell.numberTickView.remainCount = self.ticketModel.remainCount
        if self.ticketModel.sellType == 2 {
            cell.numberTickView.numberTextField.text = "\((self.ticketModel.remainCount)!)"
            cell.numberTickView.upButton.setImage(UIImage.init(named: "Icon_Add_disable"), for: .normal)
            cell.numberTickView.upButton.isEnabled = false
        }
        cell.numberTickView.numberTextField.reactive.producer(forKeyPath: "text").start { (object) in
            if Int(object.value as! String)! <= self.ticketModel.remainCount {
                self.remainCount = Int(object.value as! String)!
                self.orderForme.remainCount = self.remainCount
                if cellDetail == nil {
                    cellDetail = self.controller.tableView.cellForRow(at: IndexPath.init(row: 2, section: 1)) as? GloabTitleAndDetailCell
                }
                let much = "\(Double(Double(self.ticketModel.price) * Double(self.remainCount)) * 100)"
                if cellDetail != nil {
                    cellDetail.detailLabel.text = "\(much.muchType(much)) 元"
                    self.updateMuchOfTicke()
                }
            }else{
                cell.numberTickView.numberTextField.text = "\(self.ticketModel.remainCount)"
                self.orderForme.remainCount = self.ticketModel.remainCount
            }
        }
    }
    
    func tableViewCellGloabTextFieldCell(_ cell:GloabTextFieldCell,indexPath:IndexPath)
    {
        
    }
    
    func tableViewCellGloabTitleAndDetailCell(_ cell:GloabTitleAndDetailCell,indexPath:IndexPath)
    {
        switch indexPath.row {
        case 2:
            let much = Double(Double(ticketModel.price) * Double(remainCount))
            cell.setData(self.configCellLabel(indexPath), detail: "\(much)0 元")
        default:
            if self.formDelevityType == .expressage {
                let str = self.delivityType == .delivityNomal ? "\((self.ticketModel.deliveryPrice)!).00 元" : self.delivityType == .delivitySF ? "\((self.ticketModel.deliveryPriceSf)!).00 元" : "0.00 元"
                cell.setData(self.configCellLabel(indexPath), detail: str)
            }else{
                cell.setData(self.configCellLabel(indexPath), detail: "0.00 元")
            }
        }
    }
    
    func tableViewDidSelect(_ tableView:UITableView, indexPath:IndexPath) {
        if indexPath.section == 2 {
            let cell = tableView.cellForRow(at: indexPath) as! GloabTitleAndImageCell
            cell.updateImageView(true)
            if indexPath.row == 0 {
                if tableView.numberOfRows(inSection: 2) > 1 {
                    let cell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 2)) as! GloabTitleAndImageCell
                    cell.updateImageView(false)
                }
            }else{
                let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 2)) as! GloabTitleAndImageCell
                cell.updateImageView(false)
            }
            if WXApi.isWXAppInstalled() {
                orderForme.payType = indexPath.row == 0 ? .weiChat : .aliPay
            }else{
                orderForme.payType = .aliPay
            }
            
        }else{
            if self.formType == .withNomal {
                if self.orderConfirmViewModelClouse != nil {
                    self.orderConfirmViewModelClouse(indexPath)
                }
            }
        }
    }
    
    func updateCellString(_ tableView:UITableView, string:String){
        if string == "快递到付" {
             self.delivityType = .delivityVisite
        }else{
            self.delivityType = string == "普通快递（\(self.ticketModel.deliveryPrice)元）" ? .delivityNomal : .delivitySF
        }
        let cell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! GloabTitleAndDetailImageCell
        cell.detailLabel.text = string
        
        let cell1 = tableView.cellForRow(at: IndexPath.init(row: 4, section: 1)) as! GloabTitleAndDetailCell
        let str = self.delivityType == .delivityNomal ? "\(self.ticketModel.deliveryPrice).00 元" : self.delivityType == .delivitySF ? "\(self.ticketModel.deliveryPriceSf).00 元" :  "0.00 元"
        cell1.detailLabel.text = str
        self.updateMuchOfTicke()
    }
    
    func updateMuchOfTicke(){
        var much = 0
        if self.formDelevityType == .expressage && self.ticketModel.deliveryType != "4" {
            much = self.delivityType == .delivityNomal ? self.ticketModel.deliveryPrice : self.delivityType == .delivitySF ? self.ticketModel.deliveryPriceSf : 0
        }
        muchOfTicketWithOther = "\(Double(Double(ticketModel.price) * Double(remainCount)) + Double(much))0"
        orderForme.deliveryPrice = muchOfTicketWithOther
    }
    
    func createOrder(){
        self.orderForme.deliveryType = self.formDelevityType
        if (self.orderForme.deliveryType == .expressage) && (self.orderForme.addressId == nil) {
            MainThreadAlertShow("请填写配送地址", view: KWINDOWDS())
            return
        }
        if (self.orderForme.deliveryType != .expressage) && (self.orderForme.name == "" || self.orderForme.phone == "") {
            MainThreadAlertShow("请填写配送信息", view: KWINDOWDS())
            return
        }
        self.requestOrderPay(self.orderForme)
    }
    
    func requestOrderPay(_ orderForm:OrderFormModel){
        
        let dates = NSDate.string(toDate: self.model.session.name.components(separatedBy: " ")[0])
        let interval: TimeInterval = dates!.timeIntervalSince(NSDate.dateNow())
        let days = (Int(interval)) / 86400
        if days < 0 && orderForme.deliveryType == .expressage {
            UIAlertController.shwoAlertControl(self.controller, style: .alert, title: "提示", message: "该票已不符合快递要求，可联系商家自取", cancel: "取消", doneTitle: "联系商家", cancelAction: { 
                
            }, doneAction: { 
                if self.ticketModel.supplier != nil
                {
                    AppCallViewShow(self.controller.view, phone: self.ticketModel.supplier.mobileNum.phoneType(self.ticketModel.supplier.mobileNum))
                }
            })
            return
        }
        
        var parameters:NSDictionary = NSDictionary()
        let pay_type = orderForm.payType == .weiChat ? "2" : "1"
        var delivery_type = ""
        if orderForme.deliveryType == .expressage {
            if self.delivityType == .delivityVisite {
                delivery_type = "4"
            }else{
                delivery_type = "1"
            }
        }else if orderForme.deliveryType == .presentRecive{
            delivery_type = "2"
        }else {
            delivery_type = "3"
        }
        let delivery_price = self.delivityType == .delivityNomal ? "\((self.ticketModel.deliveryPrice)!)" : self.delivityType == .delivitySF ? "\((self.ticketModel.deliveryPriceSf)!)" : "0"
        if orderForm.deliveryType == .expressage {
            parameters = ["ticket_id": "\((orderForm.ticketID)!)"
                ,"ticket_count":orderForm.remainCount!
                ,"delivery_type":delivery_type
                ,"delivery_price":delivery_price
                ,"pay_type":pay_type
                ,"address_id":"\((orderForme.addressId)!)"
                ,"message":orderForme.message!]
        }else{
            parameters = ["ticket_id":"\((orderForm.ticketID)!)"
                ,"ticket_count":orderForm.remainCount!
                ,"delivery_type":delivery_type
                ,"pay_type":pay_type
                ,"delivery_price":"0"
                ,"name":orderForme.name!
                ,"phone":orderForme.phone!
                ,"message":orderForme.message!]
        }
        
        BaseNetWorke.sharedInstance.postUrlWithString(OrderCreate, parameters: parameters).observe { (resultDic) in
            if !resultDic.isCompleted {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserConfimNewOrder), object: nil)
                self.orderModel = OrderList.init(fromDictionary: resultDic.value as! NSDictionary)
                self.orderModel.session = self.model.session
                self.orderModel.show = self.model.show
                self.orderModel.ticket = self.ticketModel
                self.requestPay(self.orderModel)
            }
        }
    }
    
    func requestPay(_ model:OrderList){
        if model.payType == 1 {
            if model.payUrl.alipay == "" {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            AlipaySDK.defaultService().payOrder(model.payUrl.alipay, fromScheme: "LiangPiaoAlipay") { (resultDic) in
                print("resultDic")
            }
        }else{
            if model.payUrl.wxpay == nil {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            let request = PayReq()
            request.prepayId = model.payUrl.wxpay.prepayid
            request.partnerId = model.payUrl.wxpay.partnerid
            request.package = model.payUrl.wxpay.packageField
            request.nonceStr = model.payUrl.wxpay.noncestr
            request.timeStamp = UInt32(model.payUrl.wxpay.timestamp)!
            request.sign = model.payUrl.wxpay.sign
            WXApi.send(request)
        }
    }
    
    func requestPayUrl(_ model:OrderList){
        let url = "\(OrderPayInfo)\((model.orderId)!)/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let payUrl = PayUrl.init(fromDictionary: resultDic.value as! NSDictionary)
                self.orderModel.payUrl = payUrl
                let controllerVC = OrderDetailViewController()
                controllerVC.viewModel.model = self.orderModel
                controllerVC.viewModel.isOrderConfim = true
                NavigationPushView(self.controller, toConroller: controllerVC)
            }
        }
    }
}
