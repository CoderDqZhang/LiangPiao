//
//  OrderDetailViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 07/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MapKit

typealias  OrderDetailViewMoedelClouse = (_ indexPath:IndexPath, _ model:OrderList) -> Void
class OrderDetailViewModel: NSObject {

    var aliPayurl:String = ""
    var model:OrderList!
    var ticketModel:TicketShowModel!
    var sesstionModel:ShowSessionModel!
    var controller:OrderDetailViewController!
    var indexPath:IndexPath!
    var deverliyModel:DeverliyModel!
    var isOrderConfim:Bool = false
    var templeTrace:Trace!
    var orderDetailViewMoedelClouse:OrderDetailViewMoedelClouse!
    
    var plachImage:UIImage!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(OrderDetailViewModel.orderStatusChange(_:)), name: NSNotification.Name(rawValue: OrderStatuesChange), object: nil)
        
    }
    
    func getDeverliyTrac(){
        if model.expressInfo != nil && model.expressInfo.expressName != nil && model.expressInfo.expressNum != nil {
            let dics = ["RequestData":["LogisticCode":model.expressInfo.expressNum,"ShipperCode":model.expressInfo.expressName],"DataType":"2","RequestType":"1002","EBusinessID":ExpressDelivierEBusinessID,"key":ExpressDelivierKey] as [String : Any]
            
            ExpressDeliveryNet.shareInstance().requestExpressDelivreyNetOrder(dics as [AnyHashable: Any], url: ExpressOrderHandleUrl, clouse: { (resultDic) in
                self.deverliyModel = DeverliyModel.init(fromDictionary: resultDic! as NSDictionary)
                self.deverliyModel.traces = self.deverliyModel.traces.reversed()
                if self.deverliyModel.traces.count == 0 {
                    var acceptionName = ""
                    for name in deverliyDic.allKeys {
                        if deverliyDic[name as! String] as! String == self.model.expressInfo.expressName as String {
                            acceptionName = name as! String
                        }
                    }
                    let dic:NSDictionary = ["AcceptStation":acceptionName,"AcceptTime":"\((self.model.expressInfo.expressNum)!)"]
                    self.templeTrace = Trace.init(fromDictionary: dic)
                    self.deverliyModel.traces.append(self.templeTrace)
                }
                DispatchQueue.main.async(execute: {
                    self.controller.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                })
            })
        }
    }
    
    func orderStatusChange(_ object:Foundation.Notification){
        self.model.status = Int(object.object as! String)
        if self.model.status == 2 {
            self.model.statusDesc = "交易取消"
        }else if self.model.status == 3 {
            self.model.statusDesc = "待发货"
        }
        self.controller.updateTableView(self.model.status)
        controller.tableView.reloadData()
        
        if orderDetailViewMoedelClouse != nil {
            self.orderDetailViewMoedelClouse(self.indexPath, self.model)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableViewHeiFootView(_ tableView:UITableView, section:Int) -> CGFloat {
        switch section {
        case 1:
            return 118
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat{
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if self.viewModelWailOrCancelStatus() {
                    return 116
                }else{
                    return 112
                }
            }else if indexPath.row == 1{
                return controller.tableView.fd_heightForCell(withIdentifier: "ReciveAddressTableViewCell", configuration: { (cell) in
                    self.configCellReviceCell(cell as! ReciveAddressTableViewCell, indexPath: indexPath)
                })
            }else{
                if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
                    return 49
                }
                return 0
            }
            
        default:
            if indexPath.row == 0 {
                return 49
            }else if indexPath.row == 1 {
                return 149
            }else if indexPath.row == 2 {
                return controller.tableView.fd_heightForCell(withIdentifier: "TicketLocationTableViewCell", configuration: { (cell) in
                    self.configCellLocationCell(cell as! TicketLocationTableViewCell, indexPath: indexPath)
                })
            }else if indexPath.row == 3 {
                if self.viewModelHaveRemarkMessage() {
                    return controller.tableView.fd_heightForCell(withIdentifier: "TicketRemarkTableViewCell", configuration: { (cell) in
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
    
    func configCellDeverliyTableViewCell(_ cell:DeverliyTableViewCell, indexPath:IndexPath) {
        if self.deverliyModel != nil && self.deverliyModel.traces.count > 0 {
            cell.setUpData(self.deverliyModel.traces[0])
        }
    }
    
    func configCellRemarkCell(_ cell:TicketRemarkTableViewCell, indexPath:IndexPath) {
        cell.setData(model)
    }
    
    func configCellLocationCell(_ cell:TicketLocationTableViewCell, indexPath:IndexPath) {
        cell.setData(model)
    }
    
    func configCellWaitPay(_ cell:OrderWaitePayTableViewCell, indexPath:IndexPath) {
        cell.setData(model)
    }
    
    func configCellDone(_ cell:OrderDoneTableViewCell, indexPath:IndexPath) {
        cell.setData("\((model.status)!)", statusType: "")
    }
    
    func tableViewCellDeverliyTableViewCell(_ cell:DeverliyTableViewCell, indexPath:IndexPath) {
        self.configCellDeverliyTableViewCell(cell, indexPath: indexPath)
    }
    
    func configCellReviceCell(_ cell:ReciveAddressTableViewCell, indexPath:IndexPath) {
        cell.setUpData(model)
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath: IndexPath, controller:OrderDetailViewController){
        if indexPath.section == 0 && indexPath.row == 2 {
            let controllerVC = LogisticsTrackingViewController()
            let tempDeverliyModel = self.deverliyModel
            if self.deverliyModel.traces.count == 1 {
                if templeTrace != nil && self.deverliyModel.traces[0] == templeTrace {
                    tempDeverliyModel?.traces.removeAll()
                }
            }
            controllerVC.viewModel.deverliyModel = tempDeverliyModel
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
    
    func tableViewNumberRowInSection(_ tableView:UITableView, section:Int) ->Int {
        if section == 0 {
            return 3
        }
        
        if self.viewModelHaveRemarkMessage() {
            return 6
        }
        return 5

    }
    
    func tableViewCellOrderWaitePayTableViewCell(_ cell:OrderWaitePayTableViewCell, indexPath:IndexPath) {
        self.configCellWaitPay(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderTicketRemarkTableViewCell(_ cell:TicketRemarkTableViewCell, indexPath:IndexPath) {
        self.configCellRemarkCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellTicketDetailInfoTableViewCell(_ cell:TicketDetailInfoTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellTicketLocationTableViewCell(_ cell:TicketLocationTableViewCell, indexPath:IndexPath){
        cell.locationButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.creatOptionMenu()
        }
        self.configCellLocationCell(cell, indexPath: indexPath)
    }
    
    func tableViewCellOrderPayTableViewCell(_ cell:OrderPayTableViewCell) {
        cell.setData(model)
    }
    
    func tableViewCellOrderMuchTableViewCell(_ cell:OrderStatusMuchTableViewCell){
        cell.setData(model)
    }
    
    func tableViewCellOrderDoneTableViewCell(_ cell:OrderDoneTableViewCell, indexPath:IndexPath){
        self.configCellDone(cell, indexPath: indexPath)
    }
    
    func tableViewCellReciveAddressTableViewCell(_ cell:ReciveAddressTableViewCell, indexPath:IndexPath) {
        self.configCellReviceCell(cell, indexPath: indexPath)
    }
    
    func tableViewOrderCellIndexPath(_ indexPath:IndexPath, cell:OrderNumberTableViewCell) {
        cell.setData(model)
    }
    
    func requestPayModel(_ cnotroller:OrderDetailViewController){
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
            WXApi.send(request)
        }
    }
    
    func requestPayUrl(_ controller:OrderDetailViewController) {
        self.controller = controller
        let url = "\(OrderPayInfo)\((model.orderId)!)/"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let payUrl = PayUrl.init(fromDictionary: resultDic.value as! NSDictionary)
                self.model.payUrl = payUrl
            }
            
        }
    }
    
    func requestOrderStatusChange(_ controller:OrderDetailViewController){
        
        UIAlertController.shwoAlertControl(controller, style: .alert, title: "是否已经收到演出票", message: nil, cancel: "取消", doneTitle: "确认收货", cancelAction: {
            
            }, doneAction: {
                let url = "\(OrderChangeShatus)\((self.model.orderId)!)/"
                let parameters = ["status":"8"]
                BaseNetWorke.sharedInstance.postUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
                    if !resultDic.isCompleted {
                        let tempModel = OrderList.init(fromDictionary: resultDic.value as! NSDictionary)
                        self.model.status = tempModel.status
                        self.model.statusDesc = tempModel.statusDesc
                        controller.updateTableView(self.model.status)
                        self.controller.tableView.reloadData()
                        if self.orderDetailViewMoedelClouse != nil {
                            self.orderDetailViewMoedelClouse(self.indexPath, self.model)
                        }
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
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let geoC = CLGeocoder.init()
        var centerLat:CLLocationDegrees = 0.00
        var centerLng:CLLocationDegrees = 0.00
        let siteTitle = model.show.venue.address
        geoC.geocodeAddressString(siteTitle!) { (placemarks, errors) in
            if errors == nil {
                let pl = placemarks?.first
                centerLat = (pl?.location?.coordinate.latitude)!
                centerLng = (pl?.location?.coordinate.longitude)!
            }
        }
        
        if(SHARE_APPLICATION.canOpenURL(URL(string:"iosamap://")!) == true){
            let gaodeAction = UIAlertAction(title: "高德地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "iosamap://navi?sourceApplication=LiangPiao&backScheme=iosamap://&lat=\(centerLat)&lon=\(centerLng)&dev=0"
                SHARE_APPLICATION.openURL(URL.init(string: urlString)!)
            })
            optionMenu.addAction(gaodeAction)
        }
        
        if(SHARE_APPLICATION.canOpenURL(URL(string:"comgooglemaps://")!) == true){
            let googleAction = UIAlertAction(title: "Google地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                SHARE_APPLICATION.openURL(URL.init(string: "comgooglemaps://?center=\(centerLat),\(centerLng)5&zoom=12")!)
            })
            optionMenu.addAction(googleAction)
        }
        
        let appleAction = UIAlertAction(title: "苹果地图", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let loc = CLLocationCoordinate2DMake(centerLat, centerLng)
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
            toLocation.name = siteTitle
            _ = MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)])
            
        })
        optionMenu.addAction(appleAction)
        
        if(SHARE_APPLICATION.canOpenURL(URL(string:"baidumap://map/")!) == true){
            let baiduAction = UIAlertAction(title: "百度地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "baidumap://map/geocoder?location=\(centerLat),\(centerLng)&coord_type=gcj02&src=webapp.rgeo.yourCompanyName.yourAppName"
                SHARE_APPLICATION.openURL(URL.init(string: urlString)!)
            })
            optionMenu.addAction(baiduAction)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)
        controller.present(optionMenu, animated: true) {
            
        }
    }
    //查看凭证
    func presentImageBrowse(_ sourceView:UIView){
        let photoBrowser = SDPhotoBrowser()
        photoBrowser.delegate = self
        photoBrowser.currentImageIndex = 0
        photoBrowser.imageCount = 1
        photoBrowser.backgroundColor = UIColor.white
        photoBrowser.sourceImagesContainerView = sourceView
        photoBrowser.imageBlock = { index in
            
        }
        photoBrowser.show()
    }
}

extension OrderDetailViewModel : SDPhotoBrowserDelegate {
    func photoBrowser(_ browser: SDPhotoBrowser!, highQualityImageURLFor index: Int) -> URL! {
        if self.model.expressInfo.photo != nil {
            return URL.init(string: self.model.expressInfo.photo)
        }
        return URL.init(string: "")
    }
    
    func photoBrowser(_ browser: SDPhotoBrowser!, placeholderImageFor index: Int) -> UIImage! {
        return plachImage == nil ? UIImage.init(color: UIColor.init(hexString: App_Theme_F6F7FA_Color), size: CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 170/375)) : plachImage
    }
}
