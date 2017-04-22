//
//  HomeViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MJExtension
import MapKit
import Alamofire

class HomeViewModel: NSObject {
    
    var models = NSMutableArray()
    var banner:Banners!
    var searchModel:RecommentTickes!
    var controller:HomeViewController!
    var locationManager:AMapLocationManager!
    var locationStr:String = "北京"
//    var locationStr:String = UserDefaultsGetSynchronize("location") as! String == "nil" ? "北京": UserDefaultsGetSynchronize("location") as! String
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewModel.userDidTakeScreenshot(_:)), name: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil)
        //self.setUpLocationManager()
    }
    
    func setUpLocationManager(){
        locationManager = AMapLocationManager.init()
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        locationManager.delegate = self
        locationManager.requestLocation(withReGeocode: true) { (location, regeo, error) in
            if error != nil {
                return;
            }
            if (regeo != nil) {
//                self.locationStr = (regeo?.city! as String).substring(to: 2)
//                UserDefaultsSetSynchronize(self.locationStr as AnyObject, key: "location")
//                self.controller.tableView.reloadSections(NSIndexSet.init(index: 0) as IndexSet, with: .automatic)
            }
        }
    }
    
    func userDidTakeScreenshot(_ notifiation:Foundation.Notification){
        let image = KWINDOWDS().screenshot()
        KWINDOWDS().currentViewController()?.view.endEditing(true)
        _ = SaveImageTools.sharedInstance.saveImage("ScreenShotImage.png", image: image!, path: "ScreenShot")
        if KWINDOWDS().viewWithTag(10000) != nil {
            KWINDOWDS().viewWithTag(10000)?.removeFromSuperview()
        }
        
        KWINDOWDS().addSubview(GloableShareView.init(title: "分享截屏给好友", model: nil, image: image, url: nil))
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(_ section:Int) ->Int {
        switch section {
        case 0:
            if self.banner != nil && self.banner.banners.count > 0 {
                return 3
            }
            return 2
        default:
            if models.count > 0{
                return models.count + 2
            }
            return 1
        }
    }
    
    func tableViewHeightForFooterInSection(_ section:Int) -> CGFloat {
        switch section {
        case 1:
            return 0.0001
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(_ indexPath:IndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 255
            case 1:
                return 100
            default:
                return SCREENWIDTH * 162/375
            }
        default:
            switch indexPath.row {
            case 0:
                return 57
            case self.numberOfRowsInSection(indexPath.section) - 1:
                return 79
            default:
                return 140
            }
        }
    }
    
    func navigationPushTicketPage(_ index:Int) {
//        let controllerVC = BarCodeViewController()
//        NavigationPushView(self.controller, toConroller: controllerVC)
        let ticketPage = TicketPageViewController()
        ticketPage.progressHeight = 0
        ticketPage.progressWidth = 0
        ticketPage.adjustStatusBarHeight = true
        ticketPage.progressColor = UIColor.init(hexString: App_Theme_4BD4C5_Color)
        ticketPage.hidesBottomBarWhenPushed = true
        if index == 4 {
            ticketPage.pageViewControllerDidSelectIndexPath(0)
        }else{
            ticketPage.pageViewControllerDidSelectIndexPath(index + 1)
        }
        //TakingData事件
        switch index {
        case 0:
            GloableSetEvent("Home_Tools", lable: "drama", parameters: nil)
        case 1:
            GloableSetEvent("Home_Tools", lable: "show", parameters: nil)
        case 2:
            GloableSetEvent("Home_Tools", lable: "music", parameters: nil)
        case 3:
            GloableSetEvent("Home_Tools", lable: "sport", parameters: nil)
        default:
            GloableSetEvent("Home_Tools", lable: "All", parameters: nil)
        }
        
        NavigationPushView(controller, toConroller: ticketPage)
    }
    
    func tableViewDidSelectRowAtIndexPath(_ indexPath:IndexPath) {
        switch indexPath.section {
        case 0:
            break;
        default:
            switch indexPath.row {
            case 0:
                break;
            case self.numberOfRowsInSection(indexPath.section) - 1:
                self.navigationPushTicketPage(4)
            default:
                let model = TicketShowModel.init(fromDictionary: models.object(at: indexPath.row - 1) as! NSDictionary)
                self.pushTicketDetail(model)
            }
        }
    }
    
    func pushTicketDetail(_ model:TicketShowModel){
        if model.sessionCount == 1 {
            let controllerVC = TicketDescriptionViewController()
            controllerVC.viewModel.ticketModel = model
            NavigationPushView(controller, toConroller: controllerVC)
        }else{
            let controllerVC = TicketSceneViewController()
            controllerVC.viewModel.model = model
            NavigationPushView(controller, toConroller: controllerVC)
        }
    }
    
    func cellData(_ cell:RecommendTableViewCell, indexPath:IndexPath) {
        let model = TicketShowModel.init(fromDictionary: models.object(at: indexPath.row - 1) as! NSDictionary)
        cell.setData(model)
    }
    
    func tableViewHomeScrollerTableViewCell(_ cell:HomeScrollerTableViewCell, indexPath:IndexPath) {
        let imageUrls = NSMutableArray()
        for banner in self.banner.banners {
            imageUrls.add(banner.image)
        }
        cell.setcycleScrollerViewData(imageUrls.mutableCopy() as! NSArray)
        cell.cyCleScrollerViewClouse = { index in
            let banner = self.banner.banners[index]
            if banner.bannerType == 2 {
                let controllerVC = NotificationViewController()
                controllerVC.url = banner.url
                NavigationPushView(self.controller, toConroller: controllerVC)
            }else{
                self.pushTicketDetail(banner.show)
            }
        }
    }
    
    func requestHotTicket(_ tableView:UITableView){
        
        BaseNetWorke.sharedInstance.getUrlWithString(TickeHot, parameters: nil).observe { (resultDic) in
            print(resultDic)
            if !resultDic.isCompleted {
                if resultDic.event.value is NSDictionary {
                    
                }else{
                    let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                    if resultModels != nil {
                        self.models = resultModels!
                    }
                    tableView.reloadSections(NSIndexSet.init(index: 1) as IndexSet, with: .automatic)
                }
                if tableView.mj_header != nil {
                    tableView.mj_header.endRefreshing()
                    self.controller.endRefreshView()
                }
            }
        }
    }
    
    
    
    func requestBanner(){
        BaseNetWorke.sharedInstance.getUrlWithString(HomeBanner, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.banner = Banners.init(fromDictionary: resultDic.value as! NSDictionary)
                self.controller.tableView.reloadSections(NSIndexSet.init(index: 0) as IndexSet, with: .automatic)
            }
            
        }
    }
    
    func showLoacationAlert(){
        UIAlertController.shwoAlertControl(controller, style: .alert, title: "定位服务未开启", message: "请在手机设置中开启定位服务以便更好为您服务", cancel: "知道了", doneTitle: "开启定位", cancelAction: { 
            
            }, doneAction: {
                let url = URL.init(string: "prefs:root=LOCATION_SERVICES")
                if SHARE_APPLICATION.canOpenURL(url!) {
                    SHARE_APPLICATION.canOpenURL(url!)
                }
        })
    }
    
    func showLocationData(){
        let alertSheet = UIAlertController.init(title: "城市选择", message: nil, preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (cancelAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "北京", style: .default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "天津", style: .default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "上海", style: .default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "武汉", style: .default, handler: { (defaultAction) in
            
        }))
        controller.present(alertSheet, animated: true) { 
            
        }
    }
}

extension HomeViewModel : AMapLocationManagerDelegate {
    private  func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        print(location)
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didExitRegion region: AMapLocationRegion!) {
        print(region)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didStartMonitoringFor region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            if locationStr == "北京" {
                manager.requestLocation(withReGeocode: true, completionBlock: { (lcation, regencode, error) in
                    if error != nil {
                        return
                    }
                    if regencode != nil {
//                        self.locationStr = NSString(regencode?.city!).substring(to: 2)
//                        UserDefaultsSetSynchronize(self.locationStr as AnyObject, key: "location")
//                        self.controller.tableView.reloadSections(NSIndexSet.init(index: 0) as IndexSet, with: .automatic)
                    }
                })
            }
        }else if status == .notDetermined {
            self.showLoacationAlert()
        }else {
            
        }
    }
}
