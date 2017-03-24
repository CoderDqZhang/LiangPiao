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
    var deverliyModel:DeverliyModel!
    var isOrderConfim:Bool = false
    var orderDetailViewMoedelClouse:OrderDetailViewMoedelClouse!
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderDetailViewModel.orderStatusChange(_:)), name: OrderStatuesChange, object: nil)
        
    }
    
    func getDeverliyTrac(){
        if model.expressInfo != nil && model.expressInfo.expressName != nil && model.expressInfo.expressNum != nil {
            let dics = ["RequestData":["LogisticCode":model.expressInfo.expressNum,"ShipperCode":model.expressInfo.expressName],"DataType":"2","RequestType":"1002","EBusinessID":ExpressDelivierEBusinessID,"key":ExpressDelivierKey]
            
            ExpressDeliveryNet.shareInstance().requestExpressDelivreyNetOrder(dics as [NSObject : AnyObject], url: ExpressOrderHandleUrl).subscribeNext { (resultDic) in
                self.deverliyModel = DeverliyModel.init(fromDictionary: resultDic as! NSDictionary)
                self.deverliyModel.traces = self.deverliyModel.traces.reverse()
                dispatch_async(dispatch_get_main_queue(), {
                    self.controller.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
                })
            }
        }
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
        case 1:
            return 118
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat{
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if self.viewModelWailOrCancelStatus() {
                    return 116
                }else{
                    return 112
                }
            }else if indexPath.row == 1{
                return controller.tableView.fd_heightForCellWithIdentifier("ReciveAddressTableViewCell", configuration: { (cell) in
                    self.configCellReviceCell(cell as! ReciveAddressTableViewCell, indexPath: indexPath)
                })
            }else{
                if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
                    return controller.tableView.fd_heightForCellWithIdentifier("DeverliyTableViewCellDetail", configuration: { (cell) in
                        self.configCellDeverliyTableViewCell(cell as! DeverliyTableViewCell, indexPath: indexPath)
                    })
                }
                return 0
            }
            
        default:
            if indexPath.row == 0 {
                return 49
            }else if indexPath.row == 1 {
                return 149
            }else if indexPath.row == 2 {
                return controller.tableView.fd_heightForCellWithIdentifier("TicketLocationTableViewCell", configuration: { (cell) in
                    self.configCellLocationCell(cell as! TicketLocationTableViewCell, indexPath: indexPath)
                })
            }else if indexPath.row == 3 {
                if self.viewModelHaveRemarkMessage() {
                    return controller.tableView.fd_heightForCellWithIdentifier("TicketRemarkTableViewCell", configuration: { (cell) in
                        self.configCellRemarkCell(cell as! TicketRemarkTableViewCell, indexPath: indexPath)
                    })
                }
                return 119
            }else if indexPath.row == 4{
                if self.viewModelHaveRemarkMessage(){
                    return 119
                }
                return 52
            }else{
                return 52
            }
        }
    }
    
    func configCellDeverliyTableViewCell(cell:DeverliyTableViewCell, indexPath:NSIndexPath) {
        if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
            cell.setUpData(self.deverliyModel.traces[0])
        }
    }
    
    func configCellRemarkCell(cell:TicketRemarkTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func configCellLocationCell(cell:TicketLocationTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func configCellWaitPay(cell:OrderWaitePayTableViewCell, indexPath:NSIndexPath) {
        cell.setData(model)
    }
    
    func configCellDone(cell:OrderDoneTableViewCell, indexPath:NSIndexPath) {
        cell.setData("\(model.status)", statusType: "")
    }
    
    func tableViewCellDeverliyTableViewCell(cell:DeverliyTableViewCell, indexPath:NSIndexPath) {
        self.configCellDeverliyTableViewCell(cell, indexPath: indexPath)
    }
    
    func configCellReviceCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        cell.setUpData(model)
    }
    
    func tableViewDidSelectRowAtIndexPath(indexPath: NSIndexPath, controller:OrderDetailViewController){
        if indexPath.section == 0 && indexPath.row == 2 {
            let controllerVC = LogisticsTrackingViewController()
            controllerVC.viewModel.deverliyModel = self.deverliyModel
            controllerVC.viewModel.model = self.model
            NavigationPushView(self.controller, toConroller: controllerVC)
        }else if indexPath.section == 1 && indexPath.row == 1 {
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = model.show
            controllerVC.viewModel.ticketModel.session = model.session
            NavigationPushView(controller, toConroller: controllerVC)
        }else if indexPath.section == 1 && indexPath.row == 2 {
            self.creatOptionMenu()
        }
    }
    
    func tableViewNumberRowInSection(tableView:UITableView, section:Int) ->Int {
        if section == 0 {
            return 3
        }
        
        if self.viewModelHaveRemarkMessage() {
            return 6
        }
        return 5

    }
    
    func tableViewCellOrderWaitePayTableViewCell(cell:OrderWaitePayTableViewCell, indexPath:NSIndexPath) {
        self.configCellWaitPay(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderTicketRemarkTableViewCell(cell:TicketRemarkTableViewCell, indexPath:NSIndexPath) {
        self.configCellRemarkCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellTicketDetailInfoTableViewCell(cell:TicketDetailInfoTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellTicketLocationTableViewCell(cell:TicketLocationTableViewCell, indexPath:NSIndexPath){
        cell.locationButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (action) in
            self.creatOptionMenu()
        }
        self.configCellLocationCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderPayTableViewCell(cell:OrderPayTableViewCell) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(cell:OrderStatusMuchTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellOrderDoneTableViewCell(cell:OrderDoneTableViewCell, indexPath:NSIndexPath){
        self.configCellDone(cell, indexPath: indexPath)
    }
    
    func tableViewCellReciveAddressTableViewCell(cell:ReciveAddressTableViewCell, indexPath:NSIndexPath) {
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewOrderCellIndexPath(indexPath:NSIndexPath, cell:OrderNumberTableViewCell) {
        cell.setData(model)
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
            if self.model.payUrl.wxpay.appid == nil {
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
    
    func viewModelHaveRemarkMessage() -> Bool {
        var ret = false
        if self.model.message != "" {
            ret = true
        }
        return ret
    }
    
    func viewModelWailOrCancelStatus() -> Bool{
        var ret = false
        if self.model.status == 0 || self.model.status == 1 || self.model.status == 2 || self.model.status == 5 || self.model.status == 100 {
            ret = true
        }
        return ret
    }
    
    func creatOptionMenu(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let geoC = CLGeocoder.init()
        var centerLat:CLLocationDegrees = 0.00
        var centerLng:CLLocationDegrees = 0.00
        let siteTitle = model.show.venue.address
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
