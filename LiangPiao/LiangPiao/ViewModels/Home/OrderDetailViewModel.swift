//
//  OrderDetailViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

typealias  OrderDetailViewMoedelClouse = (indexPath:NSIndexPath, model:OrderList) -> Void
class OrderDetailViewModel: NSObject {

    var aliPayurl:String = ""
    var model:OrderList!
    var ticketModel:TicketShowModel!
    var sesstionModel:ShowSessionModel!
    var controller:OrderDetailViewController!
    var indexPath:NSIndexPath!
    var isOrderConfim:Bool = false
    var orderDetailViewMoedelClouse:OrderDetailViewMoedelClouse!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderDetailViewModel.orderStatusChange(_:)), name: OrderStatuesChange, object: nil)
    
    }
    
    func orderStatusChange(object:NSNotification){
        self.model.status = Int(object.object as! String)
        if self.model.status == 2 {
            self.model.statusDesc = "交易取消"
        }else if self.model.status == 3 {
            self.model.statusDesc = "待发货"
        }
        self.controller.updateTableView(self.model.status)
        controller.tableView.reloadData()
        
        if orderDetailViewMoedelClouse != nil {
            self.orderDetailViewMoedelClouse(indexPath: self.indexPath, model: self.model)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableViewHeiFootView(tableView:UITableView, section:Int) -> CGFloat {
        switch section {
        case 2:
            return 118
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat{
        switch indexPath.section {
        case 0:
            if self.model.status == 0 {
                return controller.tableView.fd_heightForCellWithIdentifier("OrderWaitePayTableViewCell", configuration: { (cell) in
                    self.configCellWaitPay(cell as! OrderWaitePayTableViewCell, indexPath: indexPath)
                })
            }else{
                return controller.tableView.fd_heightForCellWithIdentifier("OrderDoneTableViewCell", configuration: { (cell) in
                    self.configCellDone(cell as! OrderDoneTableViewCell, indexPath: indexPath)
                })
            }
        case 1:
            switch indexPath.row {
            case 0:
                return 150
            default:
                if self.model.message != "" {
                    let str = "备注详情：\(self.model.message)"
//                    let str = "开发者使用这门语言进行 iOS 应用开发,在开发中 我们常常需要用到各种字符串、类、接口等等,今天小编和大家分享的就是 swift2.0 中 String 的类型转换..."
                    let height = str.heightWithConstrainedWidth(str, font: App_Theme_PinFan_R_12_Font!, width: SCREENWIDTH - 30)
                    let returnHeight = height + 125 > 145 ? height + 125 : 145
                    return returnHeight
                }
                return 80
            }
        default:
            switch indexPath.row {
            case 0:
                return 125
            default:
                return 48
                
            }
        }
    }
    
    
    func configCellWaitPay(cell:OrderWaitePayTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func configCellDone(cell:OrderDoneTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath: NSIndexPath, controller:OrderDetailViewController){
        if indexPath.section == 1 && indexPath.row == 0 {
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = model.show
            controllerVC.viewModel.sesstionModel = model.session
            NavigationPushView(controller, toConroller: controllerVC)
        }else if indexPath.section == 1 && indexPath.row == 1 {
            self.creatOptionMenu()
        }
    }
    
    func tableViewNumberRowInSection(tableView:UITableView, section:Int) ->Int {
        if section == 0 {
            return 1
        }
        return 2

    }
    
    func tableViewCellOrderWaitePayTableViewCell(cell:OrderWaitePayTableViewCell, indexPath:NSIndexPath) {
        self.configCellWaitPay(cell, indexPath: indexPath)
    }
    
    func tableViewCellTicketDetailInfoTableViewCell(cell:TicketDetailInfoTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellTicketLocationTableViewCell(cell:TicketLocationTableViewCell, controller:OrderDetailViewController){
        cell.setData(model)
    }
    
    func tableViewCellOrderPayTableViewCell(cell:OrderPayTableViewCell) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(cell:OrderMuchTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellOrderDoneTableViewCell(cell:OrderDoneTableViewCell, indexPath:NSIndexPath){
        self.configCellDone(cell, indexPath: indexPath)
    }
    
    func requestPayModel(cnotroller:OrderDetailViewController){
        if model.payType == 1 {
            if self.model.payUrl == nil || self.model.payUrl.alipay == "" {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            AlipaySDK.defaultService().payOrder(self.model.payUrl.alipay, fromScheme: "LiangPiaoAlipay") { (resultDic) in
                print("resultDic")
            }
        }else{
            if self.model.payUrl == nil || self.model.payUrl.wxpay == nil {
                MainThreadAlertShow("获取支付链接错误", view: KWINDOWDS())
                return
            }
            let request = PayReq()
            request.prepayId = self.model.payUrl.wxpay.prepayid
            request.partnerId = self.model.payUrl.wxpay.partnerid
            request.package = self.model.payUrl.wxpay.packageField
            request.nonceStr = self.model.payUrl.wxpay.noncestr
            request.timeStamp = UInt32(self.model.payUrl.wxpay.timestamp)!
            request.sign = self.model.payUrl.wxpay.sign
            WXApi.sendReq(request)
        }
    }
    
    func requestPayUrl(controller:OrderDetailViewController) {
        self.controller = controller
        let url = "\(OrderPayInfo)\(model.orderId)/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).subscribeNext { (resultDic) in
            let payUrl = PayUrl.init(fromDictionary: resultDic as! NSDictionary)
            self.model.payUrl = payUrl
        }
    }
    
    func requestOrderStatusChange(controller:OrderDetailViewController){
        UIAlertController.shwoAlertControl(controller, style: .Alert, title: "是否已经收到演出票", message: nil, cancel: "取消", doneTitle: "确认收货", cancelAction: {
            
            }, doneAction: {
                let url = "\(OrderChangeShatus)\(self.model.orderId)/"
                let parameters = ["status":"8"]
                BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters).subscribeNext { (resultDic) in
                    let tempModel = OrderList.init(fromDictionary: resultDic as! NSDictionary)
                    self.model.status = tempModel.status
                    self.model.statusDesc = tempModel.statusDesc
                    controller.updateTableView(self.model.status)
                    self.controller.tableView.reloadData()
                    if self.orderDetailViewMoedelClouse != nil {
                        self.orderDetailViewMoedelClouse(indexPath: self.indexPath, model: self.model)
                    }
                }
        })
    }
    
    func creatOptionMenu(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let geoC = CLGeocoder.init()
        var centerLat:CLLocationDegrees = 0.00
        var centerLng:CLLocationDegrees = 0.00
        let siteTitle = "北京市海淀区西直门外白石桥5号"
        geoC.geocodeAddressString(siteTitle) { (placemarks, errors) in
            if errors == nil {
                let pl = placemarks?.first
                centerLat = (pl?.location?.coordinate.latitude)!
                centerLng = (pl?.location?.coordinate.longitude)!
            }
        }
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"iosamap://")!) == true){
            let gaodeAction = UIAlertAction(title: "高德地图", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "iosamap://navi?sourceApplication=LiangPiao&backScheme=iosamap://&lat=\(centerLat)&lon=\(centerLng)&dev=0"
                SHARE_APPLICATION.openURL(NSURL.init(string: urlString)!)
            })
            optionMenu.addAction(gaodeAction)
        }
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"comgooglemaps://")!) == true){
            let googleAction = UIAlertAction(title: "Google地图", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                SHARE_APPLICATION.openURL(NSURL.init(string: "comgooglemaps://?center=\(centerLat),\(centerLng)5&zoom=12")!)
            })
            optionMenu.addAction(googleAction)
        }
        
        let appleAction = UIAlertAction(title: "苹果地图", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let loc = CLLocationCoordinate2DMake(centerLat, centerLng)
            let currentLocation = MKMapItem.mapItemForCurrentLocation()
            let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
            toLocation.name = siteTitle
            MKMapItem.openMapsWithItems([currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber(bool: true)])
            
        })
        optionMenu.addAction(appleAction)
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"baidumap://map/")!) == true){
            let baiduAction = UIAlertAction(title: "百度地图", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "baidumap://map/geocoder?location=\(centerLat),\(centerLng)&coord_type=gcj02&src=webapp.rgeo.yourCompanyName.yourAppName"
                SHARE_APPLICATION.openURL(NSURL.init(string: urlString)!)
            })
            optionMenu.addAction(baiduAction)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)
        controller.presentViewController(optionMenu, animated: true) {
            
        }
    }
}
