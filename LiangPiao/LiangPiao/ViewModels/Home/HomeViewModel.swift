//
//  HomeViewModel.swift
//  LiangPiao
//
//  Created by Zhang on 02/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MJExtension
import MapKit

class HomeViewModel: NSObject {
    
    var models = NSMutableArray()
    var searchModel:RecommentTickes!
    var controller:HomeViewController!
    var locationManager:AMapLocationManager!
    var locationStr:String = UserDefaultsGetSynchronize("location") as! String == "nil" ? "北京": UserDefaultsGetSynchronize("location") as! String
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewModel.userDidTakeScreenshot(_:)), name: UIApplicationUserDidTakeScreenshotNotification, object: nil)
        self.setUpLocationManager()
    }
    
    func setUpLocationManager(){
        locationManager = AMapLocationManager.init()
        locationManager.locationTimeout = 2
        locationManager.reGeocodeTimeout = 2
        locationManager.delegate = self
        locationManager.requestLocationWithReGeocode(true) { (location, regeo, error) in
            if error != nil {
                return;
            }
            if (regeo != nil) {
                self.locationStr = (regeo.city as NSString).substringToIndex(2)
                UserDefaultsSetSynchronize(self.locationStr, key: "location")
                self.controller.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Automatic)
            }
        }
    }
    
    func userDidTakeScreenshot(notifiation:NSNotification){
        let image = KWINDOWDS().screenshot()
        SaveImageTools.sharedInstance.saveImage("ScreenShotImage.png", image: image, path: "ScreenShot")
        if KWINDOWDS().viewWithTag(10000) != nil {
            KWINDOWDS().viewWithTag(10000)?.removeFromSuperview()
        }
        KWINDOWDS().addSubview(GloableShareView.init(title: "分享截屏给好友", model: nil, image: image, url: nil))
    }
    
    func numberOfSectionsInTableView() -> Int{
        return 2
    }
    
    func numberOfRowsInSection(section:Int) ->Int {
        switch section {
        case 0:
            return 3
        default:
            if models.count > 0{
                return models.count + 2
            }
            return 1
        }
    }
    
    func tableViewHeightForFooterInSection(section:Int) -> CGFloat {
        switch section {
        case 1:
            return 0.0001
        default:
            return 10
        }
    }
    
    func tableViewHeightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat
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
    
    func navigationPushTicketPage(index:Int) {
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
    
    func tableViewDidSelectRowAtIndexPath(indexPath:NSIndexPath) {
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
                let model = TicketShowModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
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
        }
    }
    
    func cellData(cell:RecommendTableViewCell, indexPath:NSIndexPath) {
        let model = TicketShowModel.init(fromDictionary: models.objectAtIndex(indexPath.row - 1) as! NSDictionary)
        cell.setData(model)
    }
    
    func requestHotTicket(tableView:UITableView){
        BaseNetWorke.sharedInstance.getUrlWithString(TickeHot, parameters: nil).subscribeNext { (resultDic) in
            let resultModels =  NSMutableArray.mj_objectArrayWithKeyValuesArray(resultDic)
            self.models = resultModels.mutableCopy() as! NSMutableArray
            tableView.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: .Automatic)
            if tableView.mj_header != nil {
                tableView.mj_header.endRefreshing()
                self.controller.endRefreshView()
            }
        }
    }
    
    func showLoacationAlert(){
        UIAlertController.shwoAlertControl(controller, style: .Alert, title: "定位服务未开启", message: "请在手机设置中开启定位服务以便更好为您服务", cancel: "知道了", doneTitle: "开启定位", cancelAction: { 
            
            }, doneAction: {
                let url = NSURL.init(string: "prefs:root=LOCATION_SERVICES")
                if SHARE_APPLICATION.canOpenURL(url!) {
                    SHARE_APPLICATION.canOpenURL(url!)
                }
        })
    }
    
    func showLocationData(){
        let alertSheet = UIAlertController.init(title: "城市选择", message: nil, preferredStyle: .ActionSheet)
        alertSheet.addAction(UIAlertAction.init(title: "取消", style: .Cancel, handler: { (cancelAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "北京", style: .Default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "天津", style: .Default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "上海", style: .Default, handler: { (defaultAction) in
            
        }))
        alertSheet.addAction(UIAlertAction.init(title: "武汉", style: .Default, handler: { (defaultAction) in
            
        }))
        controller.presentViewController(alertSheet, animated: true) { 
            
        }
    }
}

extension HomeViewModel : AMapLocationManagerDelegate {
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print(location)
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didExitRegion region: AMapLocationRegion!) {
        print(region)
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didStartMonitoringForRegion region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
            if locationStr == "北京" {
                manager.requestLocationWithReGeocode(true, completionBlock: { (lcation, regencode, error) in
                    if error != nil {
                        return
                    }
                    if regencode != nil {
                        self.locationStr = (regencode.city as NSString).substringToIndex(2)
                        UserDefaultsSetSynchronize(self.locationStr, key: "location")
                        self.controller.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Automatic)
                    }
                })
            }
        }else if status == .NotDetermined {
            self.showLoacationAlert()
        }else {
            
        }
    }
}
